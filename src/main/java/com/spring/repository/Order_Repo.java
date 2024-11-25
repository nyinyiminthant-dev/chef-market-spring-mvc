package com.spring.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import java.sql.Statement;

import com.spring.model.OrderBean;
import com.spring.model.OrderDetail;
import com.spring.model.ProductBean;
import com.spring.model.ProductOrder;


public class Order_Repo {
	public List<OrderBean> showOrder() {
		List<OrderBean> obeans = new ArrayList<>();
		Connection con = MyConnection.getConnection();
		String sql = "SELECT o.id AS product_order_id, o.o_code, " + "o.adress, o.date_time, o.u_id, o.pay_id, "
				+ "pay.pay_code AS payment_code, u.firstname, " + "u.lastname AS users_name, u.email, "
				+ "pay.id AS payment_id, u.id AS users_id " + "FROM product_order o "
				+ "INNER JOIN payment pay ON pay.id = o.pay_id " + "INNER JOIN users u ON u.id = o.u_id";

		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				OrderBean obean = new OrderBean();
				obean.setId(rs.getInt("product_order_id"));
				obean.setO_code(rs.getString("o_code"));
				obean.setAddress(rs.getString("adress"));
				obean.setO_date(rs.getTimestamp("date_time"));

				obean.setPay_code(rs.getString("payment_code"));
				obean.setU_firstname(rs.getString("firstname"));
				obean.setU_lastname(rs.getString("users_name"));
				obean.setU_email(rs.getString("email"));
				obeans.add(obean);
			}
			//System.out.println("Get successful");
		} catch (Exception e) {
			e.printStackTrace();
			//System.out.println("Get Order Fail: " + e.getMessage());
		}
		return obeans;
	}

	public List<OrderBean> showOrderDetails() {
		List<OrderBean> obeans = new ArrayList<>();
		Connection con = MyConnection.getConnection();

		String sql = "SELECT od.id AS order_details_id, od.quantity, od.price, "
				+ "od.p_id, od.o_id, o.o_code AS product_order_code, "
				+ "p.p_name AS product_p_name, p.p_code AS product_p_code, "
				+ "p.id AS product_id, o.id AS product_order_id " + "FROM order_details od "
				+ "INNER JOIN product p ON p.id = od.p_id " + "INNER JOIN product_order o ON o.id = od.o_id";

		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				OrderBean obean = new OrderBean();
				obean.setId(rs.getInt("order_details_id"));
				obean.setO_code(rs.getString("product_order_code"));
				obean.setP_code(rs.getString("product_p_code"));
				obean.setP_name(rs.getString("product_p_name"));
				obean.setQuantity(rs.getInt("quantity"));
				obean.setPrice(rs.getDouble("price"));

				obeans.add(obean);
			}
			//System.out.println("Get successful");
		} catch (Exception e) {
			e.printStackTrace();
			//System.out.println("Get Order Fail: " + e.getMessage());
		}
		return obeans;
	}

	public List<OrderBean> findOrdersByEmailAndDateRange(String email, java.sql.Date startDate, java.sql.Date endDate) {
		List<OrderBean> orders = new ArrayList<>();
		String sql = "SELECT o.id AS product_order_id, o.o_code, " + "o.adress, o.date_time, o.u_id, o.pay_id, "
				+ "pay.pay_code AS payment_code, u.firstname, " + "u.lastname AS users_name, u.email, "
				+ "pay.id AS payment_id, u.id AS users_id " + "FROM product_order o "
				+ "INNER JOIN payment pay ON pay.id = o.pay_id " + "INNER JOIN users u ON u.id = o.u_id "
				+ "WHERE u.email = ? AND o.date_time BETWEEN ? AND ?";

		try (Connection con = MyConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setString(1, email);
			ps.setDate(2, startDate);
			ps.setDate(3, endDate);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				OrderBean obean = new OrderBean();
				obean.setId(rs.getInt("product_order_id"));
				obean.setO_code(rs.getString("o_code"));
				obean.setAddress(rs.getString("adress"));
				obean.setO_date(rs.getTimestamp("date_time"));
				obean.setPay_code(rs.getString("payment_code"));
				obean.setU_firstname(rs.getString("firstname"));
				obean.setU_lastname(rs.getString("users_name"));
				obean.setU_email(rs.getString("email"));
				orders.add(obean);
			}
			//System.out.println("Orders retrieved successfully");
		} catch (Exception e) {
			e.printStackTrace();
			//System.out.println("Error retrieving orders: " + e.getMessage());
		}

		return orders;
	}

	public List<OrderBean> findWithProductCodeOrderDetails(String productCode) {
		List<OrderBean> orders = new ArrayList<>();
		String sql = "SELECT od.id AS order_details_id, od.quantity, od.price, "
				+ "od.p_id, od.o_id, o.o_code, o.date_time AS product_order_code, "
				+ "p.p_name AS product_p_name, p.p_code AS product_p_code, "
				+ "p.id AS product_id, o.id AS product_order_id " + "FROM order_details od "
				+ "INNER JOIN product p ON p.id = od.p_id " + "INNER JOIN product_order o ON o.id = od.o_id "
				+ "WHERE p.p_code = ?";

		try (Connection con = MyConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setString(1, productCode);
			

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				OrderBean obean = new OrderBean();
				obean.setId(rs.getInt("order_details_id"));
				obean.setO_code(rs.getString("product_order_code"));
				obean.setP_code(rs.getString("product_p_code"));
				obean.setP_name(rs.getString("product_p_name"));
				obean.setQuantity(rs.getInt("quantity"));
				obean.setPrice(rs.getDouble("price"));
				orders.add(obean);
			}
			//System.out.println("Products retrieved successfully");
		} catch (Exception e) {
			e.printStackTrace();
			//System.out.println("Error retrieving products: " + e.getMessage());
		}

		return orders;
	}

	
	public List<OrderBean> findWithDateOrderDetails(java.sql.Date startDate, java.sql.Date endDate) {
	    List<OrderBean> orders = new ArrayList<>();
	    String sql = "SELECT od.id AS order_details_id, od.quantity, od.price, "
	            + "od.p_id, od.o_id, o.o_code, o.date_time AS product_order_code, "
	            + "p.p_name AS product_p_name, p.p_code AS product_p_code, "
	            + "p.id AS product_id, o.id AS product_order_id "
	            + "FROM order_details od "
	            + "INNER JOIN product p ON p.id = od.p_id "
	            + "INNER JOIN product_order o ON o.id = od.o_id "
	            + "WHERE o.date_time BETWEEN ? AND ?"; // Fixed SQL

	    try (Connection con = MyConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
	        ps.setDate(1, startDate); // Corrected parameter index
	        ps.setDate(2, endDate);   // Corrected parameter index
	        
	        ResultSet rs = ps.executeQuery();

	        while (rs.next()) {
	            OrderBean obean = new OrderBean();
	            obean.setId(rs.getInt("order_details_id"));
	            obean.setO_code(rs.getString("product_order_code"));
	            obean.setP_code(rs.getString("product_p_code"));
	            obean.setP_name(rs.getString("product_p_name"));
	            obean.setQuantity(rs.getInt("quantity"));
	            obean.setPrice(rs.getDouble("price"));
	            orders.add(obean);
	        }
	        //System.out.println("Products retrieved successfully");
	    } catch (Exception e) {
	    	e.printStackTrace();
	       // System.out.println("Error retrieving products: " + e.getMessage());
	    }

	    return orders;
	}

	
	private static final Logger LOGGER = Logger.getLogger(Order_Repo.class.getName());

  


    public List<OrderBean> getOrdersByUserId(int userId) {
        List<OrderBean> orders = new ArrayList<>();
        String orderQuery = "SELECT * FROM product_order WHERE u_id = ?";
        String orderDetailsQuery = "SELECT p.id, p.p_name, od.quantity, od.price FROM order_details od JOIN product p ON od.p_id = p.id WHERE od.o_id = ?";

        try (Connection con = MyConnection.getConnection();
             PreparedStatement orderPs = con.prepareStatement(orderQuery)) {

            orderPs.setInt(1, userId);
            try (ResultSet orderRs = orderPs.executeQuery()) {
                while (orderRs.next()) {
                    OrderBean order = new OrderBean();
                    order.setO_code(orderRs.getString("o_code"));
                    order.setU_id(orderRs.getInt("u_id"));
                    order.setDate_time(orderRs.getTimestamp("date_time"));
                    order.setPrice(orderRs.getDouble("price"));
                    order.setAddress(orderRs.getString("adress"));
                    order.setPay_id(orderRs.getInt("pay_id"));

                    List<ProductBean> products = new ArrayList<>();
                    try (PreparedStatement orderDetailsPs = con.prepareStatement(orderDetailsQuery)) {
                        orderDetailsPs.setInt(1, orderRs.getInt("id")); // Use order ID for details
                        try (ResultSet productRs = orderDetailsPs.executeQuery()) {
                            while (productRs.next()) {
                                ProductBean product = new ProductBean();
                                product.setId(productRs.getInt("id"));
                                product.setP_name(productRs.getString("p_name"));
                                product.setP_price(productRs.getDouble("price"));
                                product.setP_quantity(productRs.getInt("quantity"));
                                products.add(product);
                            }
                        }
                    }
                    order.setProducts(products);
                    orders.add(order);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching orders", e);
        }
        return orders;
    }
    
    public int insertProductOrder(String address, int u_id, int pay_id) {
        String sql = "INSERT INTO product_order (adress, u_id, pay_id) VALUES (?, ?, ?)";
        int generatedOrderId = 0;

        try (Connection con = MyConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, address);
            ps.setInt(2, u_id);
            ps.setInt(3, pay_id);

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Product order inserted successfully.");

                // Retrieve the generated order ID
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        generatedOrderId = rs.getInt(1);
                       // System.out.println("Generated Order ID: " + generatedOrderId);
                    }
                }
            } else {
                System.out.println("No rows affected when inserting product order.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return generatedOrderId; // Return the generated order ID
    }


    
    
    public int saveOrderDetails(int o_id, int p_id, int quantity, double price) {
        String sql = "INSERT INTO order_details (o_id, p_id, quantity, price) VALUES (?, ?, ?, ?)";
        int rowsAffected = 0;

        try (Connection con = MyConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, o_id);
            ps.setInt(2, p_id);
            ps.setInt(3, quantity);
            ps.setDouble(4, price);

            rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
              //  System.out.println("Product order details inserted successfully.");
            } else {
                System.out.println("Failed to insert product into order details.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return rowsAffected;
    }


}
