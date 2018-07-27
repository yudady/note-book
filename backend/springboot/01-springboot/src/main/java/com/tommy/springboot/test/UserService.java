package com.tommy.springboot.test;

public class UserService {

	private User user;

	public void test() {
		System.out.println(user.getName() + "--------------------");
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
}