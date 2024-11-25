package com.spring.repository;

import java.sql.Connection;
import java.sql.DriverManager;

public class MyConnection {

	public static Connection getConnection() {
		Connection con = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/chef_market", "root", "pizza4428");

		} catch (Exception e) {
			e.getMessage();
		}
		return con;
	}
}
