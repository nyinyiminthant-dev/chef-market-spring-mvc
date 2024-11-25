package com.spring.repository;


import org.springframework.stereotype.Repository;

import com.spring.model.OrderDetail;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@Repository
public class OrderDetailRepository {


    // Method to save a new order detail to the database
    public int saveOrderDetail(OrderDetail orderDetail) {
        String sql = "INSERT INTO order_detail (o_id,p_id,quantity, price) VALUES (?,?,?,?)";
        int orderDetailId = 0;

        try (Connection conn = MyConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {

            pstmt.setInt(1, orderDetail.getO_id());
            pstmt.setInt(2, orderDetail.getP_id());
            pstmt.setInt(3, orderDetail.getQuantity());
            pstmt.setDouble(4, orderDetail.getPrice());

            int affectedRows = pstmt.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet rs = pstmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        orderDetailId = rs.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderDetailId;
    }

    // Method to find all order details by order ID
    public List<OrderDetail> findOrderDetailsByOrderId(int orderId) {
        String sql = "SELECT * FROM order_detail WHERE o_id = ?";
        List<OrderDetail> orderDetails = new ArrayList<>();

        try (Connection conn = MyConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, orderId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    OrderDetail orderDetail = new OrderDetail();
                    orderDetail.setId(rs.getInt("id"));
                    orderDetail.setO_id(rs.getInt("o_id"));
                    orderDetail.setP_id(rs.getInt("p_id"));
                    orderDetail.setQuantity(rs.getInt("quantity"));
                    orderDetail.setPrice(rs.getInt("price"));
                    orderDetails.add(orderDetail);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderDetails;
    }
}
