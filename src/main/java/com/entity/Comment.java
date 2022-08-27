package com.entity;

import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

public class Comment implements Comparable<Comment>{
	private Integer id;
	private String context;
	@JSONField(format="yyyy-MM-dd HH:mm:ss")
	private Date create_date;
	private Integer user_id;
	//用户对象(需要时使用)
	private User user;
	private Integer resource_id;
	private Integer status;
	public Comment() {
	}
	public Comment(String context, Date create_date, Integer user_id,
			Integer resource_id, Integer status) {
		super();
		this.context = context;
		this.create_date = create_date;
		this.user_id = user_id;
		this.resource_id = resource_id;
		this.status = status;
	}

	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getContext() {
		return context;
	}
	public void setContext(String context) {
		this.context = context;
	}
	public Date getCreate_date() {
		return create_date;
	}
	public void setCreate_date(Date create_date) {
		this.create_date = create_date;
	}
	public Integer getUser_id() {
		return user_id;
	}
	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}
	public Integer getResource_id() {
		return resource_id;
	}
	public void setResource_id(Integer resource_id) {
		this.resource_id = resource_id;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Override
	public String toString() {
		return "Comment [id=" + id + ", context=" + context + ", create_date="
				+ create_date + ", user_id=" + user_id + ", user=" + user
				+ ", resource_id=" + resource_id + ", status=" + status + "]";
	}

	@Override
	public int compareTo(Comment o) {
		return (this.create_date.after(o.getCreate_date()))?-1:1;
	}
	
}
