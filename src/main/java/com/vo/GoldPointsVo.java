package com.vo;

public class GoldPointsVo {
	private Integer id;
	private Integer user_id;
	private Integer sum_point_count;
	private Integer sum_gold_count;
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
	public Integer getSum_point_count() {
		return sum_point_count;
	}
	public void setSum_point_count(Integer sum_point_count) {
		this.sum_point_count = sum_point_count;
	}
	public Integer getSum_gold_count() {
		return sum_gold_count;
	}
	public void setSum_gold_count(Integer sum_gold_count) {
		this.sum_gold_count = sum_gold_count;
	}
	public GoldPointsVo() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Override
	public String toString() {
		return "GoldPointsVo{" +
				"id=" + id +
				", user_id=" + user_id +
				", sum_point_count=" + sum_point_count +
				", sum_gold_count=" + sum_gold_count +
				'}';
	}

	public GoldPointsVo(Integer id, Integer user_id, Integer sum_point_count, Integer sum_gold_count) {
		super();
		this.id = id;
		this.user_id = user_id;
		this.sum_point_count = sum_point_count;
		this.sum_gold_count = sum_gold_count;
	}
	
}
