drop database if exists netclass;
create database netclass;

use netclass;


DROP TABLE IF EXISTS t_user;
CREATE TABLE t_user (
  id int AUTO_INCREMENT COMMENT '用户主键',
  login_name varchar(40) COMMENT '用户名,登录名',
  nickname varchar(60) NOT NULL COMMENT '用户昵称',
  password varchar(40) COMMENT '密码',
  role varchar(60) COMMENT '角色',
  email varchar(60) COMMENT '邮箱',
  login_date datetime COMMENT '最近一次登录的日期',
  create_date datetime COMMENT '用户创建日期',
  status int(1) COMMENT '0启用,1禁用',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS t_course_type;
CREATE TABLE t_course_type (
  id int AUTO_INCREMENT,
  type_name varchar(60) COMMENT '类型名称',
  parent_id int COMMENT '父类别id',
  status int(1) COMMENT '0启用1禁用',
  PRIMARY KEY (id),
  CONSTRAINT t_type_parent_fk FOREIGN KEY (parent_id) REFERENCES t_course_type (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




DROP TABLE IF EXISTS t_course;
CREATE TABLE t_course (
  id int AUTO_INCREMENT COMMENT '课程表主键',
  course_name varchar(100) COMMENT '课程名称',
  author varchar(100) COMMENT '课程的作者',
  cover_image_url varchar(200) COMMENT '课程封面图片的相对路径',
  create_date datetime COMMENT '课程发布时间',
  click_number int DEFAULT 0 COMMENT '课程点击量',
  status int(1) COMMENT '课程状态(0启用,1禁用)',
  recommendation_grade int(1) COMMENT '课程推荐等级(0普通,1推荐)',
  course_type_id int COMMENT '所属的课程类别的id',
  PRIMARY KEY (id),
  CONSTRAINT t_course_type_fk FOREIGN KEY (course_type_id) REFERENCES t_course_type (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS  t_chapter;
 create table t_chapter(
 id int primary key,
 course_id int references t_course(id),
  create_date datetime,
  status int default 0);

DROP TABLE IF EXISTS t_chapter;
CREATE TABLE t_chapter (
  id int AUTO_INCREMENT COMMENT '课程与资源的表的主键(课程章节)',
  course_id int COMMENT '课程的id',
  title varchar(100) COMMENT '课程章节标题',
  info varchar(300) COMMENT '课程章节简介',
  create_date datetime COMMENT '课程章节创建时间',
  status int(1) COMMENT '0启用1禁用',
  PRIMARY KEY (id),
  CONSTRAINT t_resource_course_id_fk FOREIGN KEY (course_id) REFERENCES t_course (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS t_resource;
CREATE TABLE t_resource (
  id int AUTO_INCREMENT COMMENT '资源主键',
  title varchar(200) COMMENT '资源标题',
  path varchar(200) COMMENT '资源相对路径',
  cover_image_url varchar(200) COMMENT '资源封面图片地址',
  original_name varchar(200) COMMENT '文件原始名称',
  file_size int COMMENT '文件大小(字节)',
  file_type varchar(50) COMMENT '文件类型(文件后缀名)',
  click_count int COMMENT '点击量',
  create_date datetime COMMENT '上传时间',
  cost_type int(1) COMMENT '0积分,1金币',
  cost_number int DEFAULT 0 COMMENT '下载文件或查看视频需要的积分或金币',
  user_id int COMMENT '上传用户id',
  chapter_id int COMMENT '章节id' references t_chapter(id),
  status int(1) COMMENT '0启用1禁用',
  PRIMARY KEY (id),
  CONSTRAINT t_resource_course_resource_fk FOREIGN KEY (chapter_id) REFERENCES t_chapter (id),
  CONSTRAINT t_resource_user_id_fk FOREIGN KEY (user_id) REFERENCES t_user (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
insert into t_resource values(1,'javaScript入门','upload','a.jpg','javaScript入门',100,'mp4',100,'2018-6-8 12:30:23',1,5,1,1,0);

DROP TABLE IF EXISTS t_comment;
CREATE TABLE t_comment (
  id int AUTO_INCREMENT COMMENT '评论表的主键',
  context varchar(2000) COMMENT '评论内容',
  create_date datetime COMMENT '创建时间',
  user_id int COMMENT '发布的用户id',
  resource_id int COMMENT '被评论的资源id',
  status int(1) COMMENT '0启用1禁用2待审核',
  PRIMARY KEY (id),
  CONSTRAINT t_comment_resource_id_fk FOREIGN KEY(resource_id)REFERENCES t_resource(id),
  CONSTRAINT t_comment_user_id_fk FOREIGN KEY(user_id) REFERENCES t_user(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



DROP TABLE IF EXISTS t_gold_points;
CREATE TABLE t_gold_points (
  id int AUTO_INCREMENT COMMENT '积分金币表主键',
  user_id int COMMENT '积分金币所属用户id',
  point_count int DEFAULT 0 COMMENT '使用或获得的积分数',
  gold_count int DEFAULT 0 COMMENT '使用或获得的金币数',
  info varchar(200) COMMENT '操作的内容简单说明',
  create_date datetime COMMENT '操作时间',
  PRIMARY KEY (id),
  CONSTRAINT t_gold_points_user_id_fk FOREIGN KEY (user_id) REFERENCES t_user (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS t_praise;
CREATE TABLE t_praise (
  id int AUTO_INCREMENT COMMENT '点赞记录表主键',
  user_id int COMMENT '用户id',
  comment_id int COMMENT '被点赞的评论的id',
  create_date datetime COMMENT '点赞时间',
  PRIMARY KEY (id),
  CONSTRAINT t_praise_comment_id_fk FOREIGN KEY (comment_id) REFERENCES t_comment (id),
  CONSTRAINT t_praise_user_id_fk FOREIGN KEY (user_id) REFERENCES t_user (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS t_user_resource;
CREATE TABLE t_user_resource (
  id int AUTO_INCREMENT COMMENT '用户已购买的资源表主键',
  user_id int COMMENT '用户id',
  resource_id int COMMENT '资源id',
  create_date datetime COMMENT '购买日期',
  update_date datetime COMMENT '最近一次查看的日期',
  PRIMARY KEY (id),
  CONSTRAINT t_resource_user_resource_id_fk FOREIGN KEY (resource_id) REFERENCES t_resource (id),
  CONSTRAINT t_resource_user_user_id_fk FOREIGN KEY (user_id) REFERENCES t_user (id)
) ;