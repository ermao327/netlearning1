package com.vo;

//模糊查询时用到的用户类

public class UserBackVo {
	
	private Integer id;
	private String login_name;
	private String nickname;
	private String password;
	private String role;
	private String email;
	private String login_date;
	private Integer status;
	private String create_date;
	private String login_start_date;
	private String login_end_date;
	private String create_start_date;
	private String create_end_date;
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
	public String getLogin_date() {
		return login_date;
	}
	public void setLogin_date(String login_date) {
		this.login_date = login_date;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getCreate_date() {
		return create_date;
	}
	public void setCreate_date(String create_date) {
		this.create_date = create_date;
	}
	public String getLogin_start_date() {
		return login_start_date;
	}
	public void setLogin_start_date(String login_start_date) {
		this.login_start_date = login_start_date;
	}
	public String getLogin_end_date() {
		return login_end_date;
	}
	public void setLogin_end_date(String login_end_date) {
		this.login_end_date = login_end_date;
	}
	public String getCreate_start_date() {
		return create_start_date;
	}
	public void setCreate_start_date(String create_start_date) {
		this.create_start_date = create_start_date;
	}
	public String getCreate_end_date() {
		return create_end_date;
	}
	public void setCreate_end_date(String create_end_date) {
		this.create_end_date = create_end_date;
	}

	@Override
	public String toString() {
		return "UserBackVo{" +
				"id=" + id +
				", login_name='" + login_name + '\'' +
				", nickname='" + nickname + '\'' +
				", password='" + password + '\'' +
				", role='" + role + '\'' +
				", email='" + email + '\'' +
				", login_date='" + login_date + '\'' +
				", status=" + status +
				", create_date='" + create_date + '\'' +
				", login_start_date='" + login_start_date + '\'' +
				", login_end_date='" + login_end_date + '\'' +
				", create_start_date='" + create_start_date + '\'' +
				", create_end_date='" + create_end_date + '\'' +
				'}';
	}
}
