package com.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

public class Course implements Serializable {
		/**
	 * 
	 */

		private Integer id;
		private String course_name;
		private String author;
		private String cover_image_url;
		@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone="GMT+8")
		@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
		private Date create_date;
		private String create_datestr;
		private String end_datestr;
		private Integer click_number;
		private Integer status;
		private Integer recommendation_grade;
		private CourseType courseType;
		private Integer course_type_id;
		
		
		public Integer getCourse_type_id() {
			return course_type_id;
		}
		public void setCourse_type_id(Integer course_type_id) {
			this.course_type_id = course_type_id;
		}
		public Integer getId() {
			return id;
		}
		public void setId(Integer id) {
			this.id = id;
		}
		public String getCourse_name() {
			return course_name;
		}
		public void setCourse_name(String course_name) {
			this.course_name = course_name;
		}
		public String getAuthor() {
			return author;
		}
		public void setAuthor(String author) {
			this.author = author;
		}
		public String getCover_image_url() {
			return cover_image_url;
		}
		public void setCover_image_url(String cover_image_url) {
			this.cover_image_url = cover_image_url;
		}
		public Date getCreate_date() {
			return create_date;
		}
		public void setCreate_date(Date create_date) {
			this.create_date = create_date;
		}
		public String getCreate_datestr() {
			return create_datestr;
		}
		public void setCreate_datestr(String create_datestr) {
			this.create_datestr = create_datestr;
		}
		public Integer getClick_number() {
			return click_number;
		}
		public void setClick_number(Integer click_number) {
			this.click_number = click_number;
		}
		public Integer getStatus() {
			return status;
		}
		public void setStatus(Integer status) {
			this.status = status;
		}
		public Integer getRecommendation_grade() {
			return recommendation_grade;
		}
		public void setRecommendation_grade(Integer recommendation_grade) {
			this.recommendation_grade = recommendation_grade;
		}
		public CourseType getCourseType() {
			return courseType;
		}
		public void setCourseType(CourseType courseType) {
			this.courseType = courseType;
		}
		
		public String getEnd_datestr() {
			return end_datestr;
		}
		public void setEnd_datestr(String end_datestr) {
			this.end_datestr = end_datestr;
		}
		public Course(Integer id, String course_name, String author,
				String cover_image_url, Date create_date,
				String create_datestr, String end_datestr,
				Integer click_number, Integer status,
				Integer recommendation_grade, CourseType courseType) {
			super();
			this.id = id;
			this.course_name = course_name;
			this.author = author;
			this.cover_image_url = cover_image_url;
			this.create_date = create_date;
			this.create_datestr = create_datestr;
			this.end_datestr = end_datestr;
			this.click_number = click_number;
			this.status = status;
			this.recommendation_grade = recommendation_grade;
			this.courseType = courseType;
		}
		public Course() {
			super();
		}

	@Override
	public String toString() {
		return "Course{" +
				"id=" + id +
				", course_name='" + course_name + '\'' +
				", author='" + author + '\'' +
				", cover_image_url='" + cover_image_url + '\'' +
				", create_date=" + create_date +
				", create_datestr='" + create_datestr + '\'' +
				", end_datestr='" + end_datestr + '\'' +
				", click_number=" + click_number +
				", status=" + status +
				", recommendation_grade=" + recommendation_grade +
				", courseType=" + courseType +
				", course_type_id=" + course_type_id +
				'}';
	}
}
