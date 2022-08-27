package com.entity;

import java.util.Date;

public class UserRescource {
		private Integer id;
		private User user;
		private Resource resource;
		private Date create_date;
		private Date update_date;
		private String create_datestr;
		private String update_datestr;
		
		
		public String getCreate_datestr() {
			return create_datestr;
		}
		public void setCreate_datestr(String create_datestr) {
			this.create_datestr = create_datestr;
		}
		public String getUpdate_datestr() {
			return update_datestr;
		}
		public void setUpdate_datestr(String update_datestr) {
			this.update_datestr = update_datestr;
		}
		public UserRescource(Integer id, User user, Resource resource,
				Date create_date, Date update_date, String create_datestr,
				String update_datestr) {
			super();
			this.id = id;
			this.user = user;
			this.resource = resource;
			this.create_date = create_date;
			this.update_date = update_date;
			this.create_datestr = create_datestr;
			this.update_datestr = update_datestr;
		}
		public UserRescource() {
			super();
		}
		public Integer getId() {
			return id;
		}
		public void setId(Integer id) {
			this.id = id;
		}
		public User getUser() {
			return user;
		}
		public void setUser(User user) {
			this.user = user;
		}
		public Resource getResource() {
			return resource;
		}
		public void setResource(Resource resource) {
			this.resource = resource;
		}
		public Date getCreate_date() {
			return create_date;
		}
		public void setCreate_date(Date create_date) {
			this.create_date = create_date;
		}
		public Date getUpdate_date() {
			return update_date;
		}
		public void setUpdate_date(Date update_date) {
			this.update_date = update_date;
		}
		@Override
		public String toString() {
			return "UserRescource [id=" + id + ", user=" + user + ", resource="
					+ resource + ", create_date=" + create_date
					+ ", update_date=" + update_date + ", create_datestr="
					+ create_datestr + ", update_datestr=" + update_datestr
					+ "]";
		}
		
}
