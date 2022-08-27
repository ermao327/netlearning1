package com.controller;


import com.alibaba.fastjson.JSON;
import com.constant.Constant;
import com.entity.Course;
import com.entity.GoldPoints;
import com.entity.Resource;
import com.entity.User;
import com.github.pagehelper.PageInfo;
import com.service.*;
import com.util.AjaxResult;
import com.util.StringUtil;
import com.vo.GoldPointsVo;
import com.vo.ResourceVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * date:2021/3/4
 * autor:JY
 */

@Controller
@RequestMapping("/resource")
public class UserResourceController {
    @Autowired
    UserResourceService service;
    @Autowired
    UserLoginService userService;
    @Autowired
    ResourceService rsService;
    @Autowired
    UserGpService gpService;
    @RequestMapping("/checkup.do")
    @ResponseBody
    public AjaxResult getResourceByResourceId(@RequestParam("resource_id") Integer resourceId,HttpSession session){
        System.out.println("resourceId="+resourceId);
        //根据resourceId查询资源
        Resource resource = rsService.findResourceByResourceId(resourceId);
        System.out.println("resources="+resource);

        //获取当前用户
        User user=(User)session.getAttribute(Constant.SESSION_USER);
        //根据用户id查询相应的积分金币表
        GoldPointsVo goldPoint = gpService.findGoldPointsVoByUid(user.getId());//用户的积分金币对象
        GoldPointsVo authorGoldPoint = gpService.findGoldPointsVoByUid(resource.getUser_id());//作者的积分金币对象
        Integer userPoint = goldPoint.getSum_point_count();//用户拥有的积分
        Integer userGold = goldPoint.getSum_gold_count();//用户拥有的金币
        Integer authorPoint = authorGoldPoint.getSum_point_count();//作者拥有的积分
        Integer authorGold = authorGoldPoint.getSum_gold_count();//作者拥有的金币
        Integer gp=resource.getCost_number();//该资源需要的金币或积分

        AjaxResult ajaxResult = null;
        if (resource.getCost_type()==0){
            //积分
            if (userPoint>=gp){
                System.out.println("upoint"+userPoint);
                GoldPoints usergoldPoints = new GoldPoints();
                usergoldPoints.setUser_id(user.getId());
                usergoldPoints.setPoint_count(-gp);
                usergoldPoints.setInfo("视频花费积分"+gp);
                usergoldPoints.setCreate_date(new Date());
                GoldPoints authorgoldPoints = new GoldPoints();
                authorgoldPoints.setUser_id(resource.getUser_id());
                authorgoldPoints.setPoint_count(gp);
                authorgoldPoints.setInfo("点击视频增加积分"+gp);
                authorgoldPoints.setCreate_date(new Date());
                rsService.modifyPointOrGold(usergoldPoints);
                rsService.modifyPointOrGold(authorgoldPoints);
                ajaxResult=new AjaxResult(true,"扣除了"+gp+"点积分",resource);
            }else {
                System.out.println("进入积分不足");
                ajaxResult.setSuccess(false);
                ajaxResult.setMsg("积分不足，请关注相关活动领取！");
            }
        }else {
            //金币
            if (userGold>=gp){
                GoldPoints usergoldPoints = new GoldPoints();
                usergoldPoints.setUser_id(user.getId());
                usergoldPoints.setGold_count(-gp);
                usergoldPoints.setInfo("视频花费金币"+gp);
                GoldPoints authorgoldPoints = new GoldPoints();
                authorgoldPoints.setUser_id(resource.getUser_id());
                authorgoldPoints.setGold_count(gp);
                authorgoldPoints.setInfo("点击视频增加金币"+gp);
                usergoldPoints.setCreate_date(new Date());
                authorgoldPoints.setCreate_date(new Date());
                rsService.modifyPointOrGold(usergoldPoints);
                rsService.modifyPointOrGold(authorgoldPoints);
                ajaxResult=new AjaxResult(true,"扣除了"+gp+"点金币",resource);
            }else {
                System.out.println("进入金币不足");
                ajaxResult=new AjaxResult(false,"金币不足，请关注相关活动领取！",null);
            }
        }
        System.out.println("ajaxResult"+ajaxResult.getMsg());
        return ajaxResult;
    }

    @RequestMapping("/showRs.do")
    public String showRs(@RequestParam("course_id") Integer courseId, @RequestParam("resource_id") Integer resourceId, @RequestParam("path") String path, HttpSession session){
        //根据resourceId查询资源
        Resource resource = rsService.findResourceByResourceId(resourceId);
        session.setAttribute("resource",resource);
        return "front/front_courseDetail";
    }
    // 根据传过来的Json对象字符串在服务端根据名字 查询 是否存在对应资源并创建对应的resource对象
    @PostMapping("/getUploadFileSize")
    @ResponseBody
    public AjaxResult getSize(HttpSession session,HttpServletRequest request ){
        String resourceObj = request.getParameter("resourceObj");
        Resource resource = JSON.parseObject(resourceObj, Resource.class);
        int res = service.isExsitResourceTitle(resource.getTitle());
        System.out.println(res);
        File file = getFile(resource, session);
        //判断数据库中是否有同名标题的资源
        if(res==1){
            return new AjaxResult(true,"存在同名标题",file.length());
        }
        //文件存在就返回文件大小，不存在就返回0
        return new AjaxResult(true,"查询资源成功",file.length());
    }
    //在前台我的资源页面中展示资源列表 后台资源管理页面查询所有资源
    @RequestMapping("/findBackResource.do")
    @ResponseBody
    public AjaxResult findBackResource(String pageNo,HttpSession session,ResourceVo rs){
        System.out.println(rs);
        Integer page = Integer.valueOf(pageNo);
        AjaxResult res = new AjaxResult(true, "查询成功", null);
//        User user =(User) request.getSession().getAttribute("user");
//        Integer id = user.getId();
       //判断是后台模糊查询用户资源还是前端查询当前用户的资源
        if(rs.getUser_name()==null){
            User user =(User) session.getAttribute(Constant.SESSION_USER);
            rs.setUser_id(user.getId());
        }
        else if(rs.getUser_name()!=""){
        int uid = userService.findUidByName(rs.getUser_name());
        rs.setUser_id(uid);
        }else{
        }
        PageInfo<ResourceVo> resource = service.findResource(rs, page);
        res.setObj(resource);
        return res;
    }
    //添加资源的断点续传
    @PostMapping("/addFrontResource.do")
    @ResponseBody
    public AjaxResult addFrontResource(MultipartFile multiFiles,String uploadcount,String filename
   , HttpSession session,String title,String cost_type,String cost_number,String chapter_id,String file_size) throws IOException {
        AjaxResult res = new AjaxResult(true, "添加资源成功", null);
        if(uploadcount.equals("1")){
            Resource resource = getResource(Long.parseLong(file_size),filename, title, cost_type, cost_number, chapter_id);
            File file = getFile(resource, session);
            service.createResource(session,resource,file);
        }
        continueUpload(session,filename,multiFiles);
        return res;
    }
    //修改资源的断点续传
    @PostMapping("/modifyFrontResource.do")
    @ResponseBody
    public AjaxResult modifyFrontResource(String id,MultipartFile multiFiles,String uploadcount, String filename
            , HttpSession session,String title,String cost_type,String cost_number,String chapter_id,String file_size) throws IOException {
        AjaxResult ajaxResult = new AjaxResult(true, "修改资源成功", null);

       if(uploadcount.equals("1")){
           Resource resource = getResource(Long.parseLong(file_size),filename, title, cost_type, cost_number, chapter_id);
           resource.setId(StringUtil.getInt(id));
           File file = getFile(resource, session);
           service.updateUserResource(session,resource,file);
       }
        continueUpload(session,filename,multiFiles);
        return  ajaxResult;
    }
    //删除后台资源
    @PostMapping("/removeFrontResource.do")
    @ResponseBody
    public AjaxResult removeFrontResource(String id){
        int i = service.deleteResourceById(StringUtil.getInt(id));
        if(i==1){
            return   new AjaxResult(true,"删除资源成功",null);
        }
        return new AjaxResult(true,"删除资源失败",null);
    }
    //后台修改资源状态
    @PostMapping("/toggleStatus.do")
    @ResponseBody
    public AjaxResult toggleStatus(Resource rs,HttpServletRequest request) throws IOException {
        int i = service.updateUserResourceStatus(rs);
        if(i==1){
            return new AjaxResult(true,"修改资源状态成功",null);
        }
        return new AjaxResult(false,"修改资源状态失败",null);
    }
//    后台资源MP4类型文件跳转到资源详情页面实现播放功能
    @RequestMapping("/play.do")
    public String play(HttpServletRequest request,String path){
        request.getSession().setAttribute("path",path);
        return "/background/back_resourceDetailSet";
    }
    //后台资源非MP4类型文件实现下载功能
    @RequestMapping("/down.do")
    public ResponseEntity<byte[]> down(HttpServletRequest request, Integer resourceId) throws IOException {
        Resource res = service.findResourceByid(resourceId);
        String path=request.getSession().getServletContext().getRealPath("/"+res.getPath());
        InputStream in=new FileInputStream(new File(path));
        byte[] body=null;
        body=new byte[in.available()];// 返回下一次对此输入流调用的方法可以不受阻塞地从此输入流读取（或跳过）的估计剩余字节数
        in.read(body);//读入到输入流里面
        // 设置头信息
        // 使用MultiValueMap接口的实现类HttpHeaders设置响应头信息
        HttpHeaders headers = new HttpHeaders();
        // 参数一:表示当前所使用的MIME协议方式,即下载的方式
        // 其值有两种
        //  1.attachment:以附件的方式进行下载
        //  2.inline:在线打开
        // 参数二:下载时所显示的文件名
        headers.setContentDispositionFormData("attachment",res.getOriginal_name());
        return new ResponseEntity<byte[]>(body,headers, HttpStatus.OK);
    }
    // 通过前台的资源名字查询服务器相应的文件
    public static File getFile(Resource resource,HttpSession session){
        String dir = new SimpleDateFormat("yyyyMMdd").format(new Date());
        String path = session.getServletContext().getRealPath("/upload/"+dir+"/"+resource.getOriginal_name());
        File file = new File(path);
        return  file;
    }
    //断点续传封装的方法
   public static void continueUpload(HttpSession session,String filename,MultipartFile multiFiles) throws IOException {
       String dir = new SimpleDateFormat("yyyyMMdd").format(new Date());
       String path =session.getServletContext().getRealPath("/upload/"+dir);
       File file = new File(path);
       file.mkdirs();
       file=new File(file,filename);
       FileOutputStream os = new FileOutputStream(file,true);
       os.write(multiFiles.getBytes());
       os.flush();
       os.close();
   }
   //通过前台传的数据新建一个资源对象
   public static Resource getResource(Long filesize ,String filename,String title,String cost_type,String cost_number,String chapter_id){
       Resource resource = new Resource();
       resource.setFile_size(filesize);
       resource.setOriginal_name(filename);
       resource.setTitle(title);
       resource.setCost_type(StringUtil.getInt(cost_type));
       resource.setCost_number(StringUtil.getInt(cost_number));
       resource.setChapter_id(StringUtil.getInt(chapter_id));
       return resource;
    }

}
