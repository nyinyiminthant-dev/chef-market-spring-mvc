package com.spring.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.spring.model.PaymentBean;

public class PaymentRepo {
	public List<PaymentBean> getPayment() {
		List<PaymentBean> paybeans = new ArrayList<PaymentBean>();
		Connection con = MyConnection.getConnection();
		String sql = "SELECT * from payment";

		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				PaymentBean pbean = new PaymentBean();
				pbean.setId(rs.getInt("id"));
				pbean.setPay_code(rs.getString("pay_code"));
				pbean.setAmount(rs.getDouble("amount"));
				pbean.setMethod(rs.getString("method"));
				paybeans.add(pbean);
			}
			// System.out.println("Get successful");
		} catch (Exception e) {
			e.printStackTrace();
			//System.out.println("Get payment Fail : " + e.getMessage());
		}
		return paybeans;
	}
	
	

	public int savePayment(double amount, String method) {
	    String sql = "INSERT INTO payment (amount, method) VALUES (?, ?)";
	    int generatedId = 0;

	    try (Connection conn = MyConnection.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

	        pstmt.setDouble(1, amount);
	        pstmt.setString(2, method);

	        int rowsAffected = pstmt.executeUpdate();
	        if (rowsAffected > 0) {
	            System.out.println("Payment data inserted successfully.");

	            // Retrieve the generated payment ID
	            try (ResultSet rs = pstmt.getGeneratedKeys()) {
	                if (rs.next()) {
	                    generatedId = rs.getInt(1);
	                   // System.out.println("Generated Payment ID: " + generatedId);
	                }
	            }
	        } else {
	            System.out.println("No rows affected. Insertion failed.");
	        }

	    } catch (SQLException e) {
	       // System.err.println("SQLException occurred during payment insertion.");
	        e.printStackTrace();
	    }

	    return generatedId; // Return the generated payment ID
	}


   
    public PaymentBean findPaymentById(int id) {
        String sql = "SELECT * FROM payment WHERE id = ?";
        PaymentBean payment = null;

        try (Connection conn = MyConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id); 
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    payment = new PaymentBean();
                    payment.setId(rs.getInt("id")); // Set the ID
                    payment.setPay_code(rs.getString("pay_code")); // Set the payment code
                    payment.setAmount(rs.getDouble("amount")); // Set the amount
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Consider using a logger instead of printStackTrace
        }

        return payment; // Return the found payment or null if not found
    }

    
    public boolean processPayment(PaymentBean payment) {
        // Validate the payment details
        if (payment == null) {
           // System.out.println("PaymentBean is null");
            return false; 
        }
        
       
        if (payment.getAmount() <= 0) {
           // System.out.println("Invalid payment amount: " + payment.getAmount());
            return false; 
        }
        
        // Check if the payment code is valid
        if (payment.getPay_code() == null || payment.getPay_code().isEmpty()) {
           // System.out.println("Invalid payment code: " + payment.getPay_code());
            return false; 
        }
        
        
        boolean isPaymentSuccessful = simulatePaymentProcessing(payment);
        
        if (isPaymentSuccessful) {
          //  System.out.println("Payment processed successfully: " + payment);
            return true; 
        } else {
           // System.out.println("Payment processing failed: " + payment);
            return false; 
        }
    }

    
    private boolean simulatePaymentProcessing(PaymentBean payment) {
        
        return true;
    }

}
