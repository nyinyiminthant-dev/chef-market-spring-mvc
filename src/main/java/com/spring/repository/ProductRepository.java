package com.spring.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.spring.model.*;



public class ProductRepository {
	
	 public boolean isDuplicateProductName(String name) {
	        Connection con = MyConnection.getConnection();
	        String query = "SELECT COUNT(*) FROM product WHERE LOWER(p_name) = LOWER(?)"; // Case insensitive check
	        try (PreparedStatement ps = con.prepareStatement(query)) {
	            ps.setString(1, name);
	            ResultSet rs = ps.executeQuery();
	            if (rs.next() && rs.getInt(1) > 0) {
	                return true;
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return false;
	    }

	    public boolean isDuplicateProductPhoto(String photo) {
	        Connection con = MyConnection.getConnection();
	        String query = "SELECT COUNT(*) FROM product WHERE p_photo = ?"; // Check for existing photo
	        try (PreparedStatement ps = con.prepareStatement(query)) {
	            ps.setString(1, photo);
	            ResultSet rs = ps.executeQuery();
	            if (rs.next() && rs.getInt(1) > 0) {
	                return true;
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return false;
	    }

    public boolean isDuplicateProduct(String name, String photo) {
        Connection con = MyConnection.getConnection();
        String query = "SELECT COUNT(*) FROM product WHERE p_name = ? AND p_photo = ?";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, name);
            ps.setString(2, photo);
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                return true; 
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public int addProduct(String name, String size, Double price, Integer quantity, String photo) {
        int i = 0;
        Connection con = MyConnection.getConnection();
        try {
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO product (p_name, p_size, p_price, p_quantity, p_photo) VALUES (?, ?, ?, ?, ?)"
            );
            ps.setString(1, name);
            ps.setString(2, size);
            ps.setDouble(3, price);
            ps.setInt(4, quantity);
            ps.setString(5, photo);
            i = ps.executeUpdate();
        } catch (SQLException e) {
        	e.printStackTrace();
           // System.out.println("Product Insert Error: " + e.getMessage());
        }
        return i;
    }
    public List<ProductBean> showAllProducts() {
        List<ProductBean> photoList = new ArrayList<>();
        Connection con =MyConnection.getConnection();
        String query = "SELECT DISTINCT id, p_name, p_size, p_price, p_quantity, p_photo FROM product where status<>0";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductBean bean = new ProductBean();
                bean.setId(rs.getInt("id"));
                bean.setP_name(rs.getString("p_name"));
                bean.setP_size(rs.getString("p_size"));
                bean.setP_price(rs.getDouble("p_price"));
                bean.setP_quantity(rs.getInt("p_quantity"));
                bean.setP_photo(rs.getString("p_photo"));
                photoList.add(bean);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return photoList;
    }
    public List<ProductBean> showProduct() {
        List<ProductBean> photoList = new ArrayList<>();
        Connection con = MyConnection.getConnection();
        String query = "SELECT DISTINCT id,p_code, p_name, p_size, p_price, p_quantity, p_photo FROM product where status<>0";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
            	ProductBean bean = new ProductBean();
                bean.setId(rs.getInt("id"));
                bean.setP_code(rs.getString("p_code"));
                bean.setP_name(rs.getString("p_name"));
                bean.setP_size(rs.getString("p_size"));
                bean.setP_price(rs.getDouble("p_price"));
                bean.setP_quantity(rs.getInt("p_quantity"));
                bean.setP_photo(rs.getString("p_photo"));
                photoList.add(bean);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return photoList;
    }
    
    public ProductBean findProductById(int id) {
        ProductBean product = null;
        Connection con = MyConnection.getConnection();
        String query = "SELECT p_name, p_size, p_price, p_quantity, p_photo FROM product WHERE id = ?";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                product = new ProductBean();
                product.setId(id);
                product.setP_name(rs.getString("p_name"));
                product.setP_size(rs.getString("p_size"));
                product.setP_price(rs.getDouble("p_price"));
                product.setP_quantity(rs.getInt("p_quantity"));
                product.setP_photo(rs.getString("p_photo"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return product;
    }
    
    public int getAvailableQuantity(int productId) {
        int availableQuantity = 0;
        try {
            Connection connection = MyConnection.getConnection();
            String query = "SELECT p_quantity FROM product WHERE id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, productId);
            ResultSet resultSet = preparedStatement.executeQuery();
            
            if (resultSet.next()) {
                availableQuantity = resultSet.getInt("p_quantity");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return availableQuantity;
    }
    
    
    public ProductBean getProductById(int id) {
        ProductBean product = null;
        String query = "SELECT * FROM product WHERE id = ?";
        
        try (Connection con = MyConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                product = new ProductBean();
                product.setId(rs.getInt("id"));
                product.setP_name(rs.getString("p_name"));
                product.setP_size(rs.getString("p_size"));
                product.setP_price(rs.getDouble("p_price"));
                product.setP_quantity(rs.getInt("p_quantity"));
                product.setP_photo(rs.getString("p_photo"));
                product.setMaxQuantity(rs.getInt("p_quantity")); // Set maxQuantity based on stock quantity
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving product by ID: " + e.getMessage());
        }
        return product;
    }

    public int updateProduct(ProductBean product) {
        int i = 0;
        String query = "UPDATE product SET p_name = ?, p_size = ?, p_price = ?, p_quantity = ?, p_photo = ? WHERE id = ?";

        try (Connection con =MyConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, product.getP_name());
            ps.setString(2, product.getP_size());
            ps.setDouble(3, product.getP_price());
            ps.setInt(4, product.getP_quantity());
            ps.setString(5, product.getP_photo());
            ps.setInt(6, product.getId());

            System.out.println("Executing query: " + query);
            System.out.println("With parameters: " + product.getP_name() + ", " + product.getP_size() +
                    ", " + product.getP_price() + ", " + product.getP_quantity() + ", " +
                    product.getP_photo() + ", ID: " + product.getId());

            i = ps.executeUpdate();
           // System.out.println("Update result: " + i); 
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return i; 
    }

    public int deleteProduct(int id) {
        int i = 0;
        Connection con =MyConnection.getConnection();
        try {
            PreparedStatement ps = con.prepareStatement("UPDATE product SET status=0 where id=?");
            ps.setInt(1, id);
            i = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return i;
    }
    
    

    // Retrieve items currently in the cart
    public List<ProductBean> getCartItems() {
        List<ProductBean> cartItems = new ArrayList<>();
        String query = "SELECT ci.product_id, ci.quantity, p.p_name, p.p_price, p.p_photo FROM cart_items ci " +
                       "JOIN product p ON ci.product_id = p.id"; // Adjust to match your actual cart structure

        try (Connection con = MyConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ProductBean product = new ProductBean();
                product.setId(rs.getInt("product_id"));
                product.setP_name(rs.getString("p_name"));
                product.setP_price(rs.getDouble("p_price"));
                product.setP_quantity(rs.getInt("quantity"));
                product.setP_photo(rs.getString("p_photo"));
                product.setMaxQuantity(rs.getInt("quantity")); // Set based on available quantity in the cart
                cartItems.add(product);
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving cart items: " + e.getMessage());
        }
        return cartItems;
    }
    
    // Update quantity of a specific product in the cart
    public void updateCart(int productId, int quantity) {
        String query = "UPDATE order SET quantity = ? WHERE p_id = ?";
        try (Connection con = MyConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, quantity);
            ps.setInt(2, productId);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error updating cart quantity: " + e.getMessage());
        }
    }
    
    

    	 
    	
    
    public int addProduct(ProductBean product) {
        String query = "INSERT INTO product (id, p_name, p_size, p_price, p_quantity, p_photo) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = MyConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, product.getId());
            ps.setString(2, product.getP_name());
            ps.setString(3, product.getP_size());
            ps.setDouble(4, product.getP_price());
            ps.setInt(5, product.getP_quantity());
            ps.setString(6, product.getP_photo());
            return ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Product Insert Error: " + e.getMessage());
            return 0;
        }
    }

    
    

    public int getProductQuantityById(int productId) {
        String query = "SELECT p_quantity FROM product WHERE id = ?";
        int quantity = 0;

        try (Connection con = MyConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, productId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    quantity = rs.getInt("p_quantity");
                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching product quantity: " + e.getMessage());
        }

        return quantity;
    }
    
    
    
    public boolean updateProductQuantity(int productId, int updatedQuantity) {
        String query = "UPDATE product SET p_quantity = ? WHERE id = ?";
        boolean isUpdated = false;

        try (Connection con = MyConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, updatedQuantity);
            ps.setInt(2, productId);

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                isUpdated = true;
            }
        } catch (SQLException e) {
            System.err.println("Error updating product quantity: " + e.getMessage());
        }

        return isUpdated;
    }
    
    
    
}




