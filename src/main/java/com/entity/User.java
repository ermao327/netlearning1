package com.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.vo.UserResource;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import java.util.TreeSet;


public class User {
		private Integer id;
		private String login_name;
		private String nickname;
		private String password;
		private String role;
		private String email;
	    @JsonFormat(pattern = "yyyy年MM月dd日 HH:mm:ss",timezone = "GMT+8")
		private Date login_date;
	    @JsonFormat(pattern = "yyyy年MM月dd日 HH:mm:ss",timezone = "GMT+8")
		private Date create_date;
		private Integer status;
		
		//用户点过的赞的集合
		private Set<Praise> praises = new HashSet<Praise>();
		//用户发表过的评论集合
		private Set<Comment> comments = new HashSet<Comment>();
		//用户金币/积分变动集合
		private Set<GoldPoints> gps = new HashSet<GoldPoints>();
		//用户所持有的资源集合
		private Set<UserResource> uresources = new TreeSet<UserResource>();
		//用户总金币
		private Integer gold_count;
		//用户总积分
		private Integer point_count;
		
		public Set<Praise> getPraises() {
			return praises;
		}
		public void setPraises(Set<Praise> praises) {
			this.praises = praises;
		}
		public Set<Comment> getComments() {
			return comments;
		}
		public void setComments(Set<Comment> comments) {
			this.comments = comments;
		}
		public Set<GoldPoints> getGps() {
			return gps;
		}
		public void setGps(Set<GoldPoints> gps) {
			this.gps = gps;
		}
		public Set<UserResource> getUresources() {
			return uresources;
		}
		public void setUresources(Set<UserResource> uresources) {
			this.uresources = uresources;
		}
		public Integer getGold_count() {
			return gold_count;
		}
		public void setGold_count(Integer gold_count) {
			this.gold_count = gold_count;
		}
		public Integer getPoint_count() {
			return point_count;
		}
		public void setPoint_count(Integer point_count) {
			this.point_count = point_count;
		}
		public User(Integer id, String login_name, String nickname,
				String password, String role, String email, Date login_date,
				Date create_date, Integer status) {
			super();
			this.id = id;
			this.login_name = login_name;
			this.nickname = nickname;
			this.password = password;
			this.role = role;
			this.email = email;
			this.login_date = login_date;
			this.create_date = create_date;
			this.status = status;
		}
		public User() {
			super();
		}
		public Integer getId() {
			return id;
		}
		public void setId(Integer id) {
			this.id = id;
		}
		public String getLogin_name() {
			return login_name;
		}
		public void setLogin_name(String login_name) {
			this.login_name = login_name;
		}
		public String getNickname() {
			return nickname;
		}
		public void setNickname(String nickname) {
			this.nickname = nickname;
		}
		public String getPassword() {
			return password;
		}
		public void setPassword(String password) {
			this.password = password;
		}
		public String getRole() {
			return role;
		}
		public void setRole(String role) {
			this.role = role;
		}
		public String getEmail() {
			return email;
		}
		public void setEmail(String email) {
			this.email = email;
		}
		public Date getLogin_date() {
			return login_date;
		}
		public void setLogin_date(Date login_date) {
			this.login_date = login_date;
		}
		public Date getCreate_date() {
			return create_date;
		}
		public void setCreate_date(Date create_date) {
			this.create_date = create_date;
		}
		public Integer getStatus() {
			return status;
		}
		public void setStatus(Integer status) {
			this.status = status;
		}

	@Override
	public String toString() {
		return "User{" +
				"id=" + id +
				", login_name='" + login_name + '\'' +
				", nickname='" + nickname + '\'' +
				", password='" + password + '\'' +
				", role='" + role + '\'' +
				", email='" + email + '\'' +
				", login_date=" + login_date +
				", create_date=" + create_date +
				", status=" + status +
				", praises=" + praises +
				", comments=" + comments +
				", gps=" + gps +
				", uresources=" + uresources +
				", gold_count=" + gold_count +
				", point_count=" + point_count +
				'}';
	}
}
