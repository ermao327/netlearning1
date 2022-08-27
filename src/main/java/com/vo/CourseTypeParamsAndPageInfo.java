package com.vo;

import com.github.pagehelper.PageInfo;
import com.entity.CourseType;


/**
 * 课程类别管理页面localStorage参数和分页查询结果封装类
 * @author soft01
 *
 */
public class CourseTypeParamsAndPageInfo {
	/**
	 * 查二级类别时，所属的一级类别id
	 */
	private String oldId1;
	/**
	 * 查三级类别时，所属的二级类别id
	 */
	private String oldId2;
	/**
	 * 查一级类别时，页面所在的页码
	 */
	private String oldPageNo1;
	/**
	 * 查二级类别时，页面所在的页码
	 */
	private String oldPageNo2;
	/**
	 * 课程类别的分页查询结果
	 */
	PageInfo<CourseType> pageTypes =new PageInfo<CourseType>();
	
	public CourseTypeParamsAndPageInfo() {
		super();
	}

	public String getOldId1() {
		return oldId1;
	}

	public String getOldPageNo1() {
		return oldPageNo1;
	}

	public String getOldId2() {
		return oldId2;
	}

	public String getOldPageNo2() {
		return oldPageNo2;
	}

	public PageInfo<CourseType> getPageTypes() {
		return pageTypes;
	}

	public void setOldId1(String oldId1) {
		this.oldId1 = oldId1;
	}

	public void setOldPageNo1(String oldPageNo1) {
		this.oldPageNo1 = oldPageNo1;
	}

	public void setOldId2(String oldId2) {
		this.oldId2 = oldId2;
	}

	public void setOldPageNo2(String oldPageNo2) {
		this.oldPageNo2 = oldPageNo2;
	}

	public void setPageTypes(PageInfo<CourseType> pageTypes) {
		this.pageTypes = pageTypes;
	}

	@Override
	public String toString() {
		return "CourseTypeLocalStorageParamsAndPageInfo [oldId1=" + oldId1
				+ ", oldPageNo1=" + oldPageNo1 + ", oldId2=" + oldId2
				+ ", oldPageNo2=" + oldPageNo2 + "]";
	}


	
	
	
	
	
	
}
