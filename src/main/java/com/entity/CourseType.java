package com.entity;

import java.util.HashSet;
import java.util.Set;

public class CourseType {
	private Integer id;
	private String type_name;
	private Integer parent_id;
	private Integer status;
	//该类型的子类型集合
	private Set<CourseType> childrens = new HashSet<CourseType>();
	
	
	public Set<CourseType> getChildrens() {
		return childrens;
	}
	public void setChildrens(Set<CourseType> childrens) {
		this.childrens = childrens;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getType_name() {
		return type_name;
	}
	public void setType_name(String type_name) {
		this.type_name = type_name;
	}
	public Integer getParent_id() {
		return parent_id;
	}
	public void setParent_id(Integer parent_id) {
		this.parent_id = parent_id;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public CourseType(Integer id, String type_name, Integer parent_id,
			Integer status) {
		super();
		this.id = id;
		this.type_name = type_name;
		this.parent_id = parent_id;
		this.status = status;
	}
	public CourseType() {
		super();
	}
	
}
