package com.entity;

import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;
import com.fasterxml.jackson.annotation.JsonFormat;

public class Resource {
	private Integer id;
	private String title;
	private String path;
	private String cover_image_url;
	private String original_name;
	private Long file_size;
	private String file_type;
	private Integer click_count;
	@JSONField(format="yyyy-MM-dd HH:mm:ss")
	@JsonFormat(pattern = "yyyy年MM月dd日 HH:mm:ss",timezone = "GMT+8")
	private Date create_date;
	private Integer cost_type;
	private Integer cost_number;
	private Integer user_id;
	private User user;
	private Chapter chapter;
	private Integer chapter_id;
	private Integer status;
	private String chapter_path;
	//无参构造
	public Resource() {
	}
	public Resource(String title, String path, String cover_image_url,
			String original_name, String file_type, Integer click_count,
			Date create_date, Integer cost_type, Integer cost_number,
			Integer user_id, Integer status) {
		this.title = title;
		this.path = path;
		this.cover_image_url = cover_image_url;
		this.original_name = original_name;
		this.file_type = file_type;
		this.click_count = click_count;
		this.create_date = create_date;
		this.cost_type = cost_type;
		this.cost_number = cost_number;
		this.user_id = user_id;
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
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public String getCover_image_url() {
		return cover_image_url;
	}
	public void setCover_image_url(String cover_image_url) {
		this.cover_image_url = cover_image_url;
	}
	public String getOriginal_name() {
		return original_name;
	}
	public void setOriginal_name(String original_name) {
		this.original_name = original_name;
	}
	public Long getFile_size() {
		return file_size;
	}
	public void setFile_size(long l) {
		this.file_size = l;
	}
	public String getFile_type() {
		return file_type;
	}
	public void setFile_type(String file_type) {
		this.file_type = file_type;
	}
	public Integer getClick_count() {
		return click_count;
	}
	public void setClick_count(Integer click_count) {
		this.click_count = click_count;
	}
	public Date getCreate_date() {
		return create_date;
	}
	public void setCreate_date(Date create_date) {
		this.create_date = create_date;
	}
	public Integer getCost_type() {
		return cost_type;
	}
	public void setCost_type(Integer cost_type) {
		this.cost_type = cost_type;
	}
	public Integer getCost_number() {
		return cost_number;
	}
	public void setCost_number(Integer cost_number) {
		this.cost_number = cost_number;
	}
	public Integer getUser_id() {
		return user_id;
	}
	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Chapter getChapter() {
		return chapter;
	}
	public void setChapter(Chapter chapter) {
		this.chapter = chapter;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	
	
	public Integer getChapter_id() {
		return chapter_id;
	}
	public void setChapter_id(Integer chapter_id) {
		this.chapter_id = chapter_id;
	}
	public String getChapter_path() {
		return chapter_path;
	}
	public void setChapter_path(String chapter_path) {
		this.chapter_path = chapter_path;
	}
	@Override
	public String toString() {
		return "Resource [id=" + id + ", title=" + title + ", path=" + path
				+ ", cover_image_url=" + cover_image_url + ", original_name="
				+ original_name + ", file_size=" + file_size + ", file_type="
				+ file_type + ", click_count=" + click_count + ", create_date="
				+ create_date + ", cost_type=" + cost_type + ", cost_number="
				+ cost_number + ", user_id=" + user_id + ", user=" + user
				+ ", chapter=" + chapter + ", chapter_id=" + chapter_id
				+ ", status=" + status + ", chapter_path=" + chapter_path + "]";
	}


}
