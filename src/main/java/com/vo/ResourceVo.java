package com.vo;

import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

public class ResourceVo {
	private Integer id;
	private String title;
	private String path;
	private String cover_image_url;
	private String original_name;
	private Double file_size;
	private String file_type;
	private Integer click_count;
	private Integer cost_type;
	private Double cost_number;
	private Integer user_id;
	private String user_name;
	private Integer status;
	@JSONField(format="yyyy-MM-dd HH:mm:ss")
	@JsonFormat(pattern = "yyyy年MM月dd日 HH:mm:ss",timezone = "GMT+8")
	private Date create_date;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date create_start_date;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date create_end_date;
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
	public Double getFile_size() {
		return file_size;
	}
	public void setFile_size(Double file_size) {
		this.file_size = file_size;
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
	public Integer getCost_type() {
		return cost_type;
	}
	public void setCost_type(Integer cost_type) {
		this.cost_type = cost_type;
	}
	public Double getCost_number() {
		return cost_number;
	}
	public void setCost_number(Double cost_number) {
		this.cost_number = cost_number;
	}
	public Integer getUser_id(Integer id) {
		return user_id;
	}
	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Date getCreate_date() {
		return create_date;
	}
	public void setCreate_date(Date create_date) {
		this.create_date = create_date;
	}
	public Date getCreate_start_date() {
		return create_start_date;
	}
	public void setCreate_start_date(Date create_start_date) {
		this.create_start_date = create_start_date;
	}
	public Date getCreate_end_date() {
		return create_end_date;
	}
	public void setCreate_end_date(Date create_end_date) {
		this.create_end_date = create_end_date;
	}
	public ResourceVo() {
		super();
	}
	public ResourceVo(Integer id, String title, String path, String cover_image_url, String original_name,
			Double file_size, String file_type, Integer click_count, Integer cost_type, Double cost_number,
			Integer user_id, String user_name, Integer status, Date create_date, Date create_start_date,
			Date create_end_date) {
		super();
		this.id = id;
		this.title = title;
		this.path = path;
		this.cover_image_url = cover_image_url;
		this.original_name = original_name;
		this.file_size = file_size;
		this.file_type = file_type;
		this.click_count = click_count;
		this.cost_type = cost_type;
		this.cost_number = cost_number;
		this.user_id = user_id;
		this.user_name = user_name;
		this.status = status;
		this.create_date = create_date;
		this.create_start_date = create_start_date;
		this.create_end_date = create_end_date;
	}

	@Override
	public String toString() {
		return "ResourceVo{" +
				"id=" + id +
				", title='" + title + '\'' +
				", path='" + path + '\'' +
				", cover_image_url='" + cover_image_url + '\'' +
				", original_name='" + original_name + '\'' +
				", file_size=" + file_size +
				", file_type='" + file_type + '\'' +
				", click_count=" + click_count +
				", cost_type=" + cost_type +
				", cost_number=" + cost_number +
				", user_id=" + user_id +
				", user_name='" + user_name + '\'' +
				", status=" + status +
				", create_date=" + create_date +
				", create_start_date=" + create_start_date +
				", create_end_date=" + create_end_date +
				'}';
	}
}
