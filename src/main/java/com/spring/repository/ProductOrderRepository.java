package com.spring.repository;


import org.springframework.stereotype.Repository;

import com.spring.model.ProductOrder;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@Repository
public class ProductOrderRepository {

    

    // Method to save a new product order to the database
    public int saveProductOrder(ProductOrder order) {
        String sql = "INSERT INTO product_order (address, date_time, u_id, pay_id) VALUES (?, ?, ?, ?, ?)";
        int orderId = 0;

        try (Connection conn = MyConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {

            pstmt.setString(1, order.getO_code());
            pstmt.setString(2, order.getAddress());
            pstmt.setTimestamp(3, new java.sql.Timestamp(order.getDate_time().getTime()));
            pstmt.setInt(4, order.getU_id());
            pstmt.setInt(5, order.getPay_id());

            int affectedRows = pstmt.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet rs = pstmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        orderId = rs.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderId;
    }

    // Method to find a product order by ID
    public ProductOrder findProductOrderById(int id) {
        String sql = "SELECT * FROM product_order WHERE id = ?";
        ProductOrder order = null;

        try (Connection conn = MyConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    order = new ProductOrder();
                    order.setId(rs.getInt("id"));
                    order.setO_code(rs.getString("o_code"));
                    order.setAddress(rs.getString("address"));
                    order.setDate_time(rs.getTimestamp("date_time"));
                    order.setU_id(rs.getInt("u_id"));
                    order.setPay_id(rs.getInt("pay_id"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return order;
    }
}
