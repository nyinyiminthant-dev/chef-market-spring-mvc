
package com.spring.repository;

import java.sql.Connection;  
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;


import com.spring.model.*;



@Repository
public class AdminRepository {

	public boolean registerAdmin(AdminBean admin) {
        boolean isRegistered = false;
        String sql = "INSERT INTO admin (first_name, last_name, email, password, role) VALUES (?, ?, ?, ?, ?)";

        try (Connection con =MyConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            // Set the values for the prepared statement
            ps.setString(1, admin.getFirst_name());
            ps.setString(2, admin.getLast_name());
            ps.setString(3, admin.getEmail());
            ps.setString(4, admin.getPassword());
            ps.setString(5, admin.getRole());
           

            // Execute the insert query
            int result = ps.executeUpdate();
            if (result > 0) {
                isRegistered = true;
               // System.out.println("Admin registered successfully.");
            }

        } catch (SQLException e) {
            if ("22001".equals(e.getSQLState())) {
               // System.out.println("Error: Data exceeds allowed length.");
            } else {
            	e.getMessage();
               // System.out.println("Error registering admin: " + e.getMessage());
            }
        }

        return isRegistered;
    }

    // Method to check if email exists
    public boolean emailExists(String email) {
        boolean exists = false;
        String sql = "SELECT COUNT(*) FROM admin WHERE email = ?";

        try (Connection con = MyConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                exists = rs.getInt(1) > 0; // If count is greater than 0, the email exists
            }

        } catch (SQLException e) {
        	e.getMessage();
           // System.out.println("Error checking email existence: " + e.getMessage());
        }

        return exists;
    }

    // Method to validate the password for a given email
    public boolean isValidPassword(String email, String password) {
        boolean isValid = false;
        String sql = "SELECT password FROM admin WHERE email = ?";

        try (Connection con = MyConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("password");

                // Check if the stored password matches the provided password
                isValid = storedPassword.equals(password); // Handle hashed passwords here if necessary
            }

        } catch (SQLException e) {
        	e.getMessage();
           // System.out.println("Error validating password: " + e.getMessage());
        }

        return isValid;
    }

	public boolean checkEmail(String email) {
		boolean check = false;
		Connection con = MyConnection.getConnection();
		String sql = "SELECT * FROM admin WHERE email =?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, email);
			
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				check = true;
			}
			//System.out.println("Check email is success");
		} catch (Exception e) {
			e.getMessage();
			//System.out.println("Check email is not success "+ e.getMessage());
		}
		return check;
	}
	
	public AdminBean loginAdmin(LoginBean bean) {
		AdminBean admin = null;
		Connection con = MyConnection.getConnection();
		String sql = "select * from admin where email =? and password=? ";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, bean.getEmail());
			ps.setString(2, bean.getPassword());
			
			
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				admin = new AdminBean();
				admin.setId(rs.getInt("id"));
				admin.setFirst_name(rs.getString("first_name"));
				admin.setEmail(rs.getString("email"));
				admin.setPassword(rs.getString("password"));
				admin.setRole(rs.getString("role"));
			}
			
			//System.out.println("Login is success");
		} catch (Exception e) {
			e.getMessage();
			//System.out.println("login admin error : " + e.getMessage());
		}
		return admin;
	}
    
	
	public AdminBean getAdminByEmail(String email) {
	    AdminBean admin = null;
	    String sql = "SELECT * FROM admin WHERE email = ?";
	    
	    try (Connection con = MyConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {
	        
	        ps.setString(1, email);
	        ResultSet rs = ps.executeQuery();
	        
	        if (rs.next()) {
	            admin = new AdminBean();
	            admin.setEmail(rs.getString("email"));
	            admin.setFirst_name(rs.getString("first_name"));
	            admin.setPassword(rs.getString("password"));
	            admin.setRole(rs.getString("role"));
	            admin.setA_photo(rs.getString("a_photo"));
	           
	        }
	    } catch (SQLException e) {
	    	e.getMessage();
	      //  System.out.println("Error retrieving admin: " + e.getMessage());
	    }
	    
	    return admin;
	}

	public int updateAdminProfile(AdminBean admin) {
	    int i = 0;
	    // Fixed the SQL statement by adding a comma
	    String sql = "UPDATE admin SET first_name = ?, password = ?, a_photo = ? WHERE email = ?";
	    try (Connection con = MyConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {

	        ps.setString(1, admin.getFirst_name());
	        ps.setString(2, admin.getPassword());
	        ps.setString(3, admin.getA_photo());
	        ps.setString(4, admin.getEmail());

	        i = ps.executeUpdate();
	      //  System.out.println("Update profile is successful");
	    } catch (SQLException e) {
	    	e.getMessage();
	       // System.out.println("Error updating admin: " + e.getMessage());
	    }
	    return i;
	}


	
	  
	 
	 public List<AdminBean> getAdmin () {
			List<AdminBean> admin_beans   = new ArrayList<AdminBean>();
			Connection con = MyConnection.getConnection();
			String sql = "SELECT * FROM admin WHERE status <>0";
			try {
			   PreparedStatement ps = con.prepareStatement(sql);
			   ResultSet rs = ps.executeQuery();
			   while(rs.next()) {
				   AdminBean abean = new AdminBean();
				   abean.setId(rs.getInt("id"));
				   abean.setA_code(rs.getString("a_code"));
				   abean.setFirst_name(rs.getString("first_name"));
				   abean.setLast_name(rs.getString("last_name"));
				   abean.setEmail(rs.getString("email"));
				   abean.setRole(rs.getString("role"));
				   admin_beans.add(abean);
				   
			   }
			  // System.out.println("Get successful");
			} catch (Exception e) {
				e.getMessage();
				//System.out.println("Get Admin Fail : " + e.getMessage());
			}
			return admin_beans;
		}

	 public int deleteAdmin(int id) {
			int i = 0;
			Connection con = MyConnection.getConnection();

			try {
				PreparedStatement ps = con.prepareStatement("update admin set status=0 where id =?");

				ps.setInt(1, id);

				i = ps.executeUpdate();
			} catch (SQLException e) {
				e.getMessage();
			//	System.out.println("update  admin : " + e.getMessage());

			}

			return i;
	 }
	 

	 
	 
	 

}

