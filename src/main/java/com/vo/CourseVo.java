package com.vo;

import com.entity.Course;

import java.util.Date;

public class CourseVo extends Course {
	private Date begin_date;
	private Date end_date;
	private Integer pageNo;
	private Integer pageSize;
	private Integer course_type_id;
	public Integer getCourse_type_id() {
		return course_type_id;
	}
	public void setCourse_type_id(Integer course_type_id) {
		this.course_type_id = course_type_id;
	}
	public Date getBegin_date() {
		return begin_date;
	}
	public void setBegin_date(Date begin_date) {
		this.begin_date = begin_date;
	}
	public Date getEnd_date() {
		return end_date;
	}
	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
	}
	public Integer getPageNo() {
		return pageNo;
	}
	public void setPageNo(Integer pageNo) {
		this.pageNo = pageNo;
	}
	public Integer getPageSize() {
		return pageSize;
	}
	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}
	
}
