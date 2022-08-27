package com.entity;

import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;


public class GoldPoints implements Comparable<GoldPoints>{
	private Integer id;
	private Integer user_id;//积分金币所属用户id
	private User user;
	private Integer point_count;//'使用或获得的积分数'
	private Integer gold_count;//'使用或获得的金币数'
	private String info;//'操作的内容简单说明'
	@JSONField(format="yyyy-MM-dd HH:mm:ss")
	@JsonFormat(pattern = "yyyy年MM月dd日 HH:mm:ss",timezone = "GMT+8")
	private Date create_date;//'操作时间'
	public GoldPoints() {
	}
	public GoldPoints(Integer user_id, Integer point_count, Integer gold_count,
			String info, Date create_date) {
		this.user_id = user_id;
		this.point_count = point_count;
		this.gold_count = gold_count;
		this.info = info;
		this.create_date = create_date;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
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
	public Integer getPoint_count() {
		return point_count;
	}
	public void setPoint_count(Integer point_count) {
		this.point_count = point_count;
	}
	public Integer getGold_count() {
		return gold_count;
	}
	public void setGold_count(Integer gold_count) {
		this.gold_count = gold_count;
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
	@Override
	public String toString() {
		return "GoldPoints [id=" + id + ", user_id=" + user_id + ", user="
				+ user + ", point_count=" + point_count + ", gold_count="
				+ gold_count + ", info=" + info + ", create_date="
				+ create_date + "]";
	}
	@Override
	public int compareTo(GoldPoints o) {
		return (this.create_date.after(o.create_date))?-1:1;
	}
	public GoldPoints(Integer user_id, Integer point_count, String info,
			Date create_date) {
		super();
		this.user_id = user_id;
		this.point_count = point_count;
		this.info = info;
		this.create_date = create_date;
	}	
}
