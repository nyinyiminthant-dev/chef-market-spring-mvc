package com.spring.repository;

import java.sql.Connection;   
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.spring.model.CategoryBean;
 



public class CategoryRepository {

	public int insertCategory(CategoryBean cbean) {
		int i = 0;
		Connection con = MyConnection.getConnection();
		String sql = "INSERT INTO category (c_name) VALUES  (?)";
	    try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, cbean.getC_name());
			i=ps.executeUpdate();
			//System.out.println("Insert Food Successful");
		} catch (Exception e) {
			e.getMessage();
			//System.out.println("Insert Food Fail : " + e.getMessage());
		}
		return i;
	}
	
	
	
	public List<CategoryBean> getCategory () {
	    List<CategoryBean> cbeans   = new ArrayList<CategoryBean>();
	    Connection con = MyConnection.getConnection();
	    String sql = "SELECT * FROM category WHERE is_delete = 0";
	    try {
	       PreparedStatement ps = con.prepareStatement(sql);
	       ResultSet rs = ps.executeQuery();
	       while(rs.next()) {
	         CategoryBean cbean = new CategoryBean();
	         cbean.setId(rs.getInt("id"));
	         cbean.setC_code(rs.getString("c_code"));
	         cbean.setC_name(rs.getString("c_name"));
	         cbeans.add(cbean);
	         
	       }
	      // System.out.println("Get successful");
	    } catch (Exception e) {
	    	e.getMessage();
	      //System.out.println("Get Category Fail : " + e.getMessage());
	    }
	    return cbeans;
	  } 
	

	
	 public boolean categoryExists(String c_name) {
	        boolean exists = false;
	        Connection con = MyConnection.getConnection();
	        String sql = "SELECT COUNT(*) FROM category WHERE c_name = ?";
	        try {
	            PreparedStatement ps = con.prepareStatement(sql);
	            ps.setString(1, c_name);
	            ResultSet rs = ps.executeQuery();
	            if (rs.next() && rs.getInt(1) > 0) {
	                exists = true;
	            }
	        } catch (Exception e) {
	        	e.getMessage();
	           // System.out.println("Category exists check failed: " + e.getMessage());
	        }
	        return exists;
	    }
	 

	  public CategoryBean getById(int id) {
		  CategoryBean cbean = null;
		  Connection con = MyConnection.getConnection();
		  String sql = "SELECT * FROM category WHERE id = ?";
		  try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				cbean = new CategoryBean();
				cbean.setId(rs.getInt("id"));
				cbean.setC_name(rs.getString("c_name"));
				//System.out.println("Get by id successful");
				
			}
		} catch (Exception e) {
			e.getMessage();
			//System.out.println("Get By Id Error : " + e.getMessage());
		}
		  return cbean;
	  }
	  
	  public int editCategory(CategoryBean cbean) {
		  int i = 0;
		  Connection con = MyConnection.getConnection();
		  String sql = "UPDATE category SET c_name = ? WHERE id = ?";
		  try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, cbean.getC_name());
			ps.setInt(2, cbean.getId());
			i = ps.executeUpdate();
		} catch (Exception e) {
			e.getMessage();
		//	System.out.println("Update Error : " + e.getMessage());
		}
		  return i;
	  }
	  
	  public int solfDelete(int id) {
		  int i = 0;
		  Connection con = MyConnection.getConnection();
		  String sql = "UPDATE category SET is_delete=1 WHERE id = ?";
		  try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, id);
			i = ps.executeUpdate();
		//	System.out.println("Deletecategory Successful");
		} catch (Exception e) {
			e.getMessage();
			//System.out.println("Delete category Error : " + e.getMessage());
		}
		  return i;
	  }
	  
	    public List<CategoryBean> getDeletedCategory() {
	        List<CategoryBean> cbeans = new ArrayList<CategoryBean>();
	        Connection con = MyConnection.getConnection();
	        String sql = "SELECT * FROM category WHERE is_delete = 1"; 
	        try {
	            PreparedStatement ps = con.prepareStatement(sql);
	            ResultSet rs = ps.executeQuery();
	            while (rs.next()) {
	            	CategoryBean cbean = new CategoryBean();
	            	cbean.setId(rs.getInt("id"));
	                cbean.setC_name(rs.getString("c_name"));
	                cbeans.add(cbean);
	            }
	        } catch (Exception e) {
	        	e.getMessage();
	            //System.out.println("Error fetching deleted category: " + e.getMessage());
	        }
	        return cbeans;
	    }
	    public int restoreCategory(int id) {
	        int result = 0;
	        Connection con = MyConnection.getConnection();
	        String sql = "UPDATE category SET is_delete = 0 WHERE id = ?";
	        try {
	            PreparedStatement ps = con.prepareStatement(sql);
	            ps.setInt(1, id);
	            result = ps.executeUpdate(); 
	        } catch (Exception e) {
	        	e.getMessage();
	            //System.out.println("Category Restore Error: " + e.getMessage());
	        }
	        return result;
	    }
	  
}
