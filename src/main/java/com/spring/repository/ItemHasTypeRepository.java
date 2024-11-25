package com.spring.repository;

import java.sql.Connection; 
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.spring.model.*;

public class ItemHasTypeRepository {
	public int insertItemHasType(ItemHasTypeBean item) {
	    int i = 0;
	    Connection con = MyConnection.getConnection();
	    String sql = "INSERT INTO item_has_type (c_id, t_id, i_id) VALUES (?, ?, ?);"; 
	    try {
	        PreparedStatement ps = con.prepareStatement(sql);
	        ps.setInt(1, item.getC_id()); 
	        ps.setInt(2, item.getT_id()); 
	        ps.setInt(3, item.getI_id()); 
	        i = ps.executeUpdate();
	       // System.out.println("Insert Successful");
	    } catch (SQLException e) {
	    	e.printStackTrace();
	       // System.out.println("Insert Failed: " + e.getMessage());
	    }
	    return i;
	}


	public List<ItemsBean> getItemsByType(int t_id) {
	    List<ItemsBean> items = new ArrayList<>();
	    Connection con = MyConnection.getConnection();
	    String sql = "SELECT * FROM items WHERE t_id = ?"; 

	    try {
	        PreparedStatement ps = con.prepareStatement(sql);
	        ps.setInt(1, t_id);
	        ResultSet rs = ps.executeQuery();

	        while (rs.next()) {
	            ItemsBean item = new ItemsBean();
	            item.setId(rs.getInt("id"));
	            item.setI_code(rs.getString("i_code"));
	            item.setI_name(rs.getString("i_name"));
	            item.setT_id(rs.getInt("t_id"));
	            items.add(item);
	        }
	       // System.out.println("Get Items by Type successful, Items: " + items);
	    } catch (Exception e) {
	    	e.printStackTrace();
	       // System.out.println("Get Items by Type failed: " + e.getMessage());
	    }

	    return items;
	}

    
	public List<ItemHasTypeBean> displayItemshastypes() {
	    List<ItemHasTypeBean> itemhastypelist = new ArrayList<>();
	    Connection con = MyConnection.getConnection();
	    String sql = "SELECT iht.id, c.id AS c_id, c.c_name, t.id AS t_id, t.t_name, i.id AS i_id, i.i_name " +
	                 "FROM item_has_type iht " +
	                 "JOIN category c ON iht.c_id = c.id " +
	                 "JOIN type t ON iht.t_id = t.id " +
	                 "JOIN items i ON iht.i_id = i.id";
	    try {
	        PreparedStatement ps = con.prepareStatement(sql);
	        ResultSet rs = ps.executeQuery();
	        while (rs.next()) {
	            ItemHasTypeBean itemhastypebean = new ItemHasTypeBean();
	            itemhastypebean.setId(rs.getInt("id"));
	            itemhastypebean.setC_id(rs.getInt("c_id"));
	            itemhastypebean.setT_id(rs.getInt("t_id"));
	            itemhastypebean.setI_id(rs.getInt("i_id"));
	            itemhastypebean.setC_name(rs.getString("c_name"));
	            itemhastypebean.setT_name(rs.getString("t_name"));
	            itemhastypebean.setI_name(rs.getString("i_name"));

	            // Check if ingredient exists for this itemHasTypeBean
	            boolean ingredientExists = checkIfIngredientExists(itemhastypebean.getId());
	            itemhastypebean.setIngredientExists(ingredientExists);

	            itemhastypelist.add(itemhastypebean);
	        }
	       // System.out.println("Get itemhastypesuccessful");
	    } catch (Exception e) {
	    	e.printStackTrace();
	      //  System.out.println("Get itemshastypes error: " + e.getMessage());
	    }
	    return itemhastypelist;
	}


  

	  public ItemHasTypeBean getById(int id) {
		  ItemHasTypeBean ihtbean = null;
		  Connection con = MyConnection.getConnection();
		  String sql = "SELECT * FROM item_has_type WHERE id = ?";
		  try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				ihtbean = new ItemHasTypeBean();
				ihtbean.setId(rs.getInt("id"));
				
				//System.out.println("Get by id successful");
				
			}
		} catch (Exception e) {
			e.printStackTrace();
			//System.out.println("Get By Id Error : " + e.getMessage());
		}
		  return ihtbean;
	  }
	  public boolean checkIfIngredientExists(int itemHasTypeId) {
		    
		    String sql = "SELECT COUNT(*) FROM ingredient WHERE it_id = ?";
		    Connection con = MyConnection.getConnection();
		    try {
		        PreparedStatement ps = con.prepareStatement(sql);
		        ps.setInt(1, itemHasTypeId);
		        ResultSet rs = ps.executeQuery();
		        if (rs.next() && rs.getInt(1) > 0) {
		            return true; 
		        }
		    } catch (SQLException e) {
		    	e.printStackTrace();
		      //  System.out.println("Error checking ingredient existence: " + e.getMessage());
		    }
		    return false; 
		}

	  
	  public int updateItemHasType(ItemHasTypeBean item) {
		    int i = 0;
		    Connection con = MyConnection.getConnection();
		    String sql = "UPDATE item_has_type SET c_id = ?, t_id = ?, i_id = ? WHERE id = ?";

		    try {
		        PreparedStatement ps = con.prepareStatement(sql);
		        ps.setInt(1, item.getC_id());
		        ps.setInt(2, item.getT_id());
		        ps.setInt(3, item.getI_id());
		        ps.setInt(4, item.getId());
		        i = ps.executeUpdate();
		       // System.out.println("Update Successful");
		    } catch (SQLException e) {
		    	e.printStackTrace();
		      //  System.out.println("Update Failed: " + e.getMessage());
		    }
		    return i;
		}

}
