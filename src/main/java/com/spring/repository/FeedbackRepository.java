package com.spring.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.spring.model.Feedback;

public class FeedbackRepository {

    
	public int insertFeedback(Feedback feedback) {
	    int result = 0;       
	    String sql = "INSERT INTO feedback (review, u_id, in_id) VALUES (?, ?, ?);";

	    try (Connection con = MyConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {
	        
	        ps.setString(1, feedback.getReview());
	        ps.setInt(2, feedback.getU_id());
	        ps.setInt(3, feedback.getIn_id());
	        
	        result = ps.executeUpdate();
	       // System.out.println("Feedback inserted successfully.");

	    } catch (SQLException e) {
	    	e.getMessage();
	       // System.out.println("Error inserting feedback: " + e.getMessage());
	    }

	    return result;
	}

    
    // Method to find feedback by user ID
    public List<Feedback> findByUserId(int userId) {
        List<Feedback> feedbackList = new ArrayList<>();
        String query = "SELECT * from feedback where u_id = ?";

        try (Connection connection = MyConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setInt(1, userId);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                Feedback feedback = new Feedback();
                feedback.setId(resultSet.getInt("id"));
                feedback.setF_code(resultSet.getString("f_code"));
                feedback.setReview(resultSet.getString("review"));
                feedback.setU_id(resultSet.getInt("u_id"));
                feedback.setIn_id(resultSet.getInt("in_id"));
                feedbackList.add(feedback);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return feedbackList;
    }
    
    public List<Feedback> findFeedbackByIngredientId(int ingredientId) {
        List<Feedback> feedbackList = new ArrayList<>();
        String query = "SELECT f.id, f.review, f.u_id, f.in_id, u.id, u.firstname, u.lastname "
                + "FROM feedback f "
                + "JOIN users u ON f.u_id = u.id "
                + "WHERE f.in_id = ?";

        try (Connection connection = MyConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setInt(1, ingredientId);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Feedback feedback = new Feedback();
                    feedback.setId(resultSet.getInt("id"));
                    feedback.setReview(resultSet.getString("review"));
                    feedback.setU_id(resultSet.getInt("u_id"));
                    feedback.setIn_id(resultSet.getInt("in_id"));
                    feedback.setFirstname(resultSet.getString("firstname"));
                    feedback.setLastname(resultSet.getString("lastname"));
                    feedbackList.add(feedback);
                }
            }
        } catch (SQLException e) {
          //  System.err.println("Error retrieving feedback for ingredient ID " + ingredientId);
            e.printStackTrace();
        }

        return feedbackList;
    }
    
    public int saveFeedback(Feedback feedback) {
        int result = 0;
        String sql = "INSERT INTO feedback (review, u_id, in_id) VALUES (?, ?, ?);";
        
        try (Connection con = MyConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
             
            ps.setString(1, feedback.getReview());
            ps.setInt(2, feedback.getU_id());  // User ID
            ps.setInt(3, feedback.getIn_id()); // Ingredient ID
            
            result = ps.executeUpdate();
           // System.out.println("Feedback saved successfully.");

        } catch (SQLException e) {
        	e.printStackTrace();
          //  System.out.println("Error saving feedback: " + e.getMessage());
        }

        return result;
    }
}
