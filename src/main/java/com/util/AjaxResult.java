package com.util;

/**
 * ajax方法统一返回对象
 * @author teacher
 * @date 2018-8-22
 */
public class AjaxResult {
	/**
	 * 执行操作是否成功
	 */
	private boolean success;
	/**
	 * 操作执行后的提示
	 */
	private String msg;
	/**
	 * 执行操作后需要传递到页面的数据
	 */
	private Object obj;
	
	public AjaxResult(boolean success, String msg, Object obj) {
		this.success = success;
		this.msg = msg;
		this.obj = obj;
	}
	public AjaxResult() {
	}
	public boolean isSuccess() {
		return success;
	}
	public void setSuccess(boolean success) {
		this.success = success;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public Object getObj() {
		return obj;
	}
	public void setObj(Object obj) {
		this.obj = obj;
	}
	/**
	 * 操作成功,但没有提示信息,也没有数据
	 * @author teacher
	 * @date 2018-8-22
	 * @return
	 */
	public static AjaxResult isOk(){
		return new AjaxResult(true, "", "");
	}
	/**
	 * 操作成功,有数据,但没有提示信息
	 * @author teacher
	 * @date 2018-8-22
	 * @param data 传递的数据
	 * @return
	 */
	public static AjaxResult isOk(Object data){
		return new AjaxResult(true, "", data);
	}
	/**
	 * 操作成功,有提示信息,但没有数据
	 * @author teacher
	 * @date 2018-8-22
	 * @param msg 提示信息
	 * @return
	 */
	public static AjaxResult isOk(String msg){
		return new AjaxResult(true, msg, "");
	}
	/**
	 * 操作成功,有提示信息,有数据
	 * @author teacher
	 * @date 2018-8-22
	 * @param msg 提示信息
	 * @param data 数据
	 * @return
	 */
	public static AjaxResult isOk(String msg, Object data){
		return new AjaxResult(true, msg, data);
	}

	/**
	 * 操作失败,但没有提示信息,也没有数据
	 * @author teacher
	 * @date 2018-8-22
	 * @return
	 */
	public static AjaxResult isFail(){
		return new AjaxResult(false, "", "");
	}
	/**
	 * 操作失败,有数据,但没有提示信息
	 * @author teacher
	 * @date 2018-8-22
	 * @param data 传递的数据
	 * @return
	 */
	public static AjaxResult isFail(Object data){
		return new AjaxResult(false, "", data);
	}
	/**
	 * 操作失败,有提示信息,但没有数据
	 * @author teacher
	 * @date 2018-8-22
	 * @param msg 提示信息
	 * @return
	 */
	public static AjaxResult isFail(String msg){
		return new AjaxResult(false, msg, "");
	}
	/**
	 * 操作失败,有提示信息,有数据
	 * @author teacher
	 * @date 2018-8-22
	 * @param msg 提示信息
	 * @param data 数据
	 * @return
	 */
	public static AjaxResult isFail(String msg, Object data){
		return new AjaxResult(false, msg, data);
	}
	
}
