package com.entity;

import java.util.Date;

public class Praise {
		private Integer id;
		private User user;
		private Comment comment;
		private Date create_date;
		public Praise(Integer id, User user, Comment comment, Date create_date) {
			super();
			this.id = id;
			this.user = user;
			this.comment = comment;
			this.create_date = create_date;
		}
		public Praise() {
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
		public Comment getComment() {
			return comment;
		}
		public void setComment(Comment comment) {
			this.comment = comment;
		}
		public Date getCreate_date() {
			return create_date;
		}
		public void setCreate_date(Date create_date) {
			this.create_date = create_date;
		}

	@Override
	public String toString() {
		return "Praise{" +
				"id=" + id +
				", user=" + user +
				", comment=" + comment +
				", create_date=" + create_date +
				'}';
	}
}
