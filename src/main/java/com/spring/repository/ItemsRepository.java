package com.spring.repository;

import java.sql.Connection; 
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import java.util.List;


import com.spring.model.ItemsBean;


public class ItemsRepository {

	public int insertItems(ItemsBean ibean) {
		int i =0;
		Connection con = MyConnection.getConnection();
		String sql = "INSERT INTO items (i_name,t_id) VALUES (?,?)";
		try {
              PreparedStatement ps = con.prepareStatement(sql);
              ps.setString(1, ibean.getI_name());
              ps.setInt(2, ibean.getT_id());
              i = ps.executeUpdate();
             // System.out.println("Insert Items Successful");
              
		} catch (Exception e) {
			e.printStackTrace();
			//System.out.println("Insert Items Fail");
		}
		return i;
	}
	
	public List<ItemsBean> getItems() {
		List<ItemsBean> ibeans = new ArrayList<ItemsBean>();
		Connection con = MyConnection.getConnection();
		 String sql = "SELECT i.id, i.i_code, i.i_name, t.id AS t_id, t.t_code FROM items i INNER JOIN type t ON i.t_id = t.id";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				ItemsBean ibean = new ItemsBean();
				ibean.setId(rs.getInt("id"));
				ibean.setI_code(rs.getString("i_code"));
				ibean.setI_name(rs.getString("i_name"));
				ibean.setT_code(rs.getString("t_code"));
				ibeans.add(ibean);
			}
		} catch (Exception e) {
			e.printStackTrace();
			//System.out.println("Get Items Successful");
		}
		return ibeans;
	}

	

	public List<ItemsBean> getItemsByType(Integer t_id) {
	    List<ItemsBean> itemsList = new ArrayList<>();
	    String sql = "SELECT * FROM items WHERE t_id = ?"; 

	    try (Connection con = MyConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {
	        
	        ps.setInt(1, t_id);
	        
	        try (ResultSet rs = ps.executeQuery()) {
	            while (rs.next()) {
	                ItemsBean item = new ItemsBean();
	                item.setId(rs.getInt("id")); 
	                item.setI_code(rs.getString("i_code")); 
	                item.setI_name(rs.getString("i_name"));  
	                item.setT_id(rs.getInt("t_id")); 
	                itemsList.add(item);
	            }
	        }
	    } catch (SQLException e) {
	    	e.printStackTrace();
	       // System.out.println("Error fetching items by type: " + e.getMessage());
	    }

	    return itemsList;
	}
	

	  
	   
	}



