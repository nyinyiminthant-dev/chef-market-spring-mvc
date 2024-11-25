package com.spring.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.spring.model.*;

public class UserRepository {

    public int insertUser(UserBean bean) {
        int result = 0;
        Connection con = MyConnection.getConnection();

        try { 
            PreparedStatement ps = con.prepareStatement("INSERT INTO users (firstname, lastname, email, password) VALUES (?, ?, ?, ?)");
            ps.setString(1, bean.getFirstname());
            ps.setString(2, bean.getLastname());
            ps.setString(3, bean.getEmail());
            ps.setString(4, bean.getPassword());

            result = ps.executeUpdate();

        } catch (SQLException e) {
            System.out.println("Error inserting user: " + e.getMessage());
        }

        return result;
    }

    public boolean checkEmail(String email) {
        boolean exists = false;
        String sql = "SELECT * FROM users WHERE email = ?";
        
        try (Connection con = MyConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
             
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    exists = true;
                }
            }
        } catch (SQLException e) {
        	e.printStackTrace();
           // System.out.println("Error checking email: " + e.getMessage());
        }
       // System.out.println("Email exists: " + exists); // Debugging output
        return exists;
    }

    public UserBean loginUser(UserBean bean) {
        UserBean user = null;
        String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
        
        try (Connection con = MyConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
             
            ps.setString(1, bean.getEmail());
            ps.setString(2, bean.getPassword());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    user = new UserBean();
                    user.setId(rs.getInt("id"));
                    user.setFirstname(rs.getString("firstname"));
                    user.setLastname(rs.getString("lastname"));
                    user.setEmail(rs.getString("email"));
                    user.setPassword(rs.getString("password"));
                }
            }
        } catch (SQLException e) {
        	e.printStackTrace();
           // System.out.println("Error logging in user: " + e.getMessage());
        }
      //  System.out.println("User authenticated: " + (user != null)); // Debugging output
        return user;
    }

    
    public boolean registerUser(UserBean user) {
        Connection con = MyConnection.getConnection();
        String sql = "INSERT INTO users (firstname, lastname, email, password) VALUES (?, ?, ?, ?)";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, user.getFirstname());
            ps.setString(2, user.getLastname());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPassword());

            int rowsInserted = ps.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            System.out.println("Error registering user: " + e.getMessage());
        }
        return false;
    }
    
    public List<UserBean> getUser () {
		List<UserBean> user_beans   = new ArrayList<UserBean>();
		Connection con = MyConnection.getConnection();
		String sql = "SELECT * FROM users";
		try {
		   PreparedStatement ps = con.prepareStatement(sql);
		   ResultSet rs = ps.executeQuery();
		   while(rs.next()) {
			   UserBean ubean = new UserBean();
			   ubean.setId(rs.getInt("id"));
			   ubean.setU_code(rs.getString("u_code"));
			   ubean.setFirstname(rs.getString("firstname"));
			   ubean.setLastname(rs.getString("lastname"));
			   ubean.setEmail(rs.getString("email"));
			   
			   user_beans.add(ubean);
			   
		   }
		  // System.out.println("Get successful");
		} catch (Exception e) {
			System.out.println("Get User Fail : " + e.getMessage());
		}
		return user_beans;
	}
    
    public int getuserById(int id) {
    	int i = 0;
    	
    	Connection con = MyConnection.getConnection();
    	String query = "SELECT id from users where id=?";
    	try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				UserBean ubean = new UserBean();
				ubean.setId(rs.getInt("id"));
			}
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
    	
    	
    	return i;
    }
    
    
    public boolean updatePassword(String newPassword, String email) {
        try (Connection connection = MyConnection.getConnection()) {
            String query = "UPDATE users SET password = ? WHERE email = ?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setString(1, newPassword);
            stmt.setString(2, email);  // Set the email parameter

            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public UserBean findByEmail(String email) {
        try (Connection connection = MyConnection.getConnection()) {
            String query = "SELECT * FROM users WHERE email = ?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                UserBean user = new UserBean();
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                return user;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
