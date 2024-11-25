package com.spring.repository;

import java.sql.Connection; 
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.spring.model.*;

public class TypeRepository {

	public int insertType(TypeBean tbean) {
		int i = 0;
		Connection con = MyConnection.getConnection();
	
		String sql = "INSERT INTO type (t_name, c_id) VALUES (?, ?)";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, tbean.getT_name());
			ps.setInt(2, tbean.getC_id());
			
			i = ps.executeUpdate();
			//System.out.println("Insert type  successful");
		} catch (Exception e) {
			System.out.println("Insert type Fail");
		}
		
		return i;
	}
	

	public List<TypeBean> getTypes() {
	    List<TypeBean> tbeans = new ArrayList<TypeBean>();
	    Connection con = MyConnection.getConnection();
	    // Updated SQL query to retrieve c_code directly
	    String sql = "SELECT t.id, t.t_code, t.t_name, c.id AS c_id, c.c_code FROM type t INNER JOIN category c ON t.c_id = c.id"; 

	    try {
	        PreparedStatement ps = con.prepareStatement(sql);
	        ResultSet rs = ps.executeQuery();
	        
	        while (rs.next()) {
	            TypeBean tbean = new TypeBean();
	            tbean.setId(rs.getInt("id"));
	            tbean.setT_code(rs.getString("t_code"));
	            tbean.setT_name(rs.getString("t_name"));
	            tbean.setC_code(rs.getString("c_code")); // No changes needed here if using the correct query
	            tbean.setC_id(rs.getInt("c_id")); // Sets the category ID
	            tbeans.add(tbean);
	        }
	      //s System.out.println("Get Types Successful");
	    } catch (Exception e) {
	        System.out.println("Get Types Fail : " + e.getMessage());
	    }
	    return tbeans;
	}


	public boolean typeExists(String t_name) {
	    boolean exists = false;
	    Connection con = MyConnection.getConnection();
	    String sql = "SELECT COUNT(*) FROM type WHERE t_name = ?";
	    try {
	        PreparedStatement ps = con.prepareStatement(sql);
	        ps.setString(1, t_name);
	        ResultSet rs = ps.executeQuery();
	        if (rs.next() && rs.getInt(1) > 0) {
	            exists = true;
	        }
	    } catch (Exception e) {
	    	e.printStackTrace();
	       // System.out.println("Type exists check failed: " + e.getMessage());
	    }
	    return exists;
	}
	
	public List<TypeBean> getTypesByCategory(int c_id) {
	    List<TypeBean> tbeans = new ArrayList<>();
	    Connection con = MyConnection.getConnection();
	    String sql = "SELECT * FROM type WHERE c_id = ?";

	    try {
	        PreparedStatement ps = con.prepareStatement(sql);
	        ps.setInt(1, c_id);
	        ResultSet rs = ps.executeQuery();

	        while (rs.next()) {
	            TypeBean tbean = new TypeBean();
	            tbean.setId(rs.getInt("id"));
	            tbean.setT_name(rs.getString("t_name"));
	            tbeans.add(tbean);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return tbeans;
	}


}
