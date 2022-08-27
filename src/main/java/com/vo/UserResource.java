package com.vo;

import com.entity.Resource;
import com.entity.User;

import java.io.Serializable;
import java.util.Date;

	/**
	 * 用户购买资源   实体
	 * @author soft01
	 *
	 */
public class UserResource implements Serializable{
		/**
		 * 
		 */
	private static final long serialVersionUID = 1L;
	/**
	 * 用户已购买的资源表主键
	 */
	private Integer id;
	/**
	 *用户id 
	 */
	private Integer userId;
	/**
	 * 用户
	 */
	private User user;
	/**
	 * 资源id
	 */
	private Integer resourceId;
	/**
	 * 资源
	 */
	private Resource resource;
	/**
	 * 购买日期
	 */
	private Date createDate;
	/**
	 * 最近一次查看的日期
	 */
	private Date updateDate;
	/**
	 * MP4格式的视频，最近一次观看所到的时间位置
	 */
	private Integer currentLookTime;
	
	
	public UserResource() {
		super();
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public Integer getId() {
		return id;
	}

	public Integer getUserId() {
		return userId;
	}

	public User getUser() {
		return user;
	}

	public Integer getResourceId() {
		return resourceId;
	}

	public Resource getResource() {
		return resource;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public void setResourceId(Integer resourceId) {
		this.resourceId = resourceId;
	}

	public void setResource(Resource resource) {
		this.resource = resource;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	
	public Integer getCurrentLookTime() {
		return currentLookTime;
	}

	public void setCurrentLookTime(Integer currentLookTime) {
		this.currentLookTime = currentLookTime;
	}

	@Override
	public String toString() {
		return "UserResource [id=" + id + ", userId=" + userId + ", user="
				+ user + ", resourceId=" + resourceId + ", resource="
				+ resource + ", createDate=" + createDate + ", updateDate="
				+ updateDate + "]";
	}
	
	
}
