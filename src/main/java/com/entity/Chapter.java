package com.entity;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import com.alibaba.fastjson.annotation.JSONField;

public class Chapter {
	private Integer id;
	private String title;
	//课程对象(需要时使用)
	private Course course;
	private Resource resource;
	//课程ID，可以直接使用
	private Integer course_id;
	private String info;
	@JSONField(format="yyyy-MM-dd HH:mm:ss")
	private Date create_date;
	private Integer status;
	private Set<Resource> resources = new HashSet<Resource>();
	public Chapter() {
	}
	public Chapter(String title, Integer course_id, String info,
			Date create_date, Integer status) {
		this.title = title;
		this.course_id = course_id;
		this.info = info;
		this.create_date = create_date;
		this.status = status;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Course getCourse() {
		return course;
	}
	public void setCourse(Course course) {
		this.course = course;
	}
	public Integer getCourse_id() {
		return course_id;
	}
	public void setCourse_id(Integer course_id) {
		this.course_id = course_id;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public Date getCreate_date() {
		return create_date;
	}
	public void setCreate_date(Date create_date) {
		this.create_date = create_date;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	
	public Resource getResource() {
		return resource;
	}
	public void setResource(Resource resource) {
		this.resource = resource;
	}
//	@Override
//	public String toString() {
//		return "Chapter [id=" + id + ", title=" + title + ", course=" + course
//				+ ", course_id=" + course_id + ", info=" + info
//				+ ", create_date=" + create_date + ", status=" + status + "]";
//	}


	@Override
	public String toString() {
		return "Chapter{" +
				"id=" + id +
				", title='" + title + '\'' +
				", course=" + course +
				", resource=" + resource +
				", course_id=" + course_id +
				", info='" + info + '\'' +
				", create_date=" + create_date +
				", status=" + status +
				", resources=" + resources +
				'}';
	}

	public Set<Resource> getResources() {
		return resources;
	}
	public void setResources(Set<Resource> resources) {
		this.resources = resources;
	}
	
}