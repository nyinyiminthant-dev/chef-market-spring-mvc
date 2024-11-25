package com.spring.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.spring.model.IngredientBean;

@Repository("ingrepo")
@Service("ingrepo")
public class IngredientRepository {

	  public void saveIngredient(IngredientBean ingredient) {
	        String sql = "INSERT INTO ingredient (in_name, instruction, photo, it_id) VALUES (?, ?, ?,?)";
	        
	        Connection con = MyConnection.getConnection();
	        try {
				PreparedStatement ps = con.prepareStatement(sql);
				
				ps.setString(1, ingredient.getIn_name());
				ps.setString(2, ingredient.getInstruction());
				ps.setInt(4 , ingredient.getIt_id());
				
				ps.executeUpdate();
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
	                                 
	    }
	    
    
    
    public int insertIngredients(IngredientBean ibean) {
        int i = 0;
        Connection con = MyConnection.getConnection();
        String sql = "INSERT INTO ingredient (item_name,in_name, instruction, photo,remark,it_id) VALUES (?,?,?,?,?,?)";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, ibean.getItem_name());
            ps.setString(2, ibean.getIn_name());
            ps.setString(3, ibean.getInstruction()); // Make sure this is added
            ps.setString(4, ibean.getPhotoPath());
            ps.setString(5, ibean.getRemark());
            ps.setInt(6 , ibean.getIt_id());
        
            i = ps.executeUpdate();
           // System.out.println("Insert Items Successful");
        } catch (Exception e) {
           // System.out.println("Insert Items Fail");
            e.printStackTrace(); // Log the exception for debugging
            
            
          //  System.out.println("Item Name: " + ibean.getItem_name());
           // System.out.println("Ingredient Name: " + ibean.getIn_name());
           // System.out.println("Instruction: " + ibean.getInstruction());
           // System.out.println("Photo Path: " + ibean.getPhotoPath());
           // System.out.println("Remark: " + ibean.getRemark());
           // System.out.println("Type ID: " + ibean.getIt_id());

        }
        return i;
    }
    
    public List<IngredientBean> showIngredient() {
        List<IngredientBean> ibeans = new ArrayList<>();
        Connection con = MyConnection.getConnection(); 
        String sql = "SELECT * FROM ingredient"; // Ensure this query includes the item_name column

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                IngredientBean ibean = new IngredientBean();
                ibean.setId(rs.getInt("id"));
                ibean.setIn_code(rs.getString("in_code")); 
                ibean.setIn_name(rs.getString("in_name"));
                ibean.setInstruction(rs.getString("instruction"));
                ibean.setPhotoPath(rs.getString("photo")); 
                ibean.setIt_id(rs.getInt("it_id"));

                // Assuming there's a column for item_name in your database
                ibean.setItem_name(rs.getString("item_name")); // Add this line to set item_name
                
                ibeans.add(ibean);
            }
          //  System.out.println("Get successful");
        } catch (Exception e) {
        	e.printStackTrace();
          //  System.out.println("Get Ingredient Fail: " + e.getMessage());
        }
        return ibeans;
    }

  


    public IngredientBean getById(int id) {
        IngredientBean ingredient = null;
        String sql = "SELECT * FROM ingredient WHERE id = ?";
        
        Connection con = MyConnection.getConnection();
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                ingredient = new IngredientBean();
                ingredient.setId(rs.getInt("id"));
                ingredient.setIn_code(rs.getString("in_code"));
                ingredient.setIn_name(rs.getString("in_name"));
                ingredient.setInstruction(rs.getString("instruction"));
                ingredient.setPhotoPath(rs.getString("photo"));
                ingredient.setRemark(rs.getString("remark"));
                ingredient.setItem_name(rs.getString("item_name"));
                ingredient.setIt_id(rs.getInt("it_id"));
            }
           // System.out.println("Ingredient fetched successfully by ID: " + id);
        } catch (SQLException e) {
           // System.out.println("Failed to fetch ingredient by ID: " + e.getMessage());
            e.printStackTrace();
        }
        return ingredient;
    }
    

    public int updateIngredient(IngredientBean ingredient) {
        int rowsUpdated = 0;
        String sql = "UPDATE ingredient SET item_name = ?, in_name = ?, instruction = ?, photo = ?, remark = ? WHERE it_id = ?";
        Connection con = MyConnection.getConnection();
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, ingredient.getItem_name());
            ps.setString(2, ingredient.getIn_name());
            ps.setString(3, ingredient.getInstruction());
            ps.setString(4, ingredient.getPhotoPath());
            ps.setString(5, ingredient.getRemark());
          
            ps.setInt(6, ingredient.getId());
            rowsUpdated = ps.executeUpdate();
           // System.out.println("Ingredient updated successfully");
        } catch (SQLException e) {
          //  System.out.println("Failed to update ingredient: " + e.getMessage());
            e.printStackTrace();
        }
        return rowsUpdated;
    }

    public List<IngredientBean> showIngredients() {
        List<IngredientBean> ibeans = new ArrayList<>();
        Connection con = MyConnection.getConnection(); 
        String sql = "SELECT ing.id AS ingredient_id, ing.in_code, ing.item_name, ing.in_name, " +
                     "ing.instruction, ing.remark,ing.photo, ing.it_id, t.t_name AS type_name, " +
                     "i.i_name AS item_name, c.c_name AS category_name, " +
                     "i.id AS item_id, c.id AS category_id, t.id AS type_id " +
                     "FROM ingredient ing " +
                     "INNER JOIN item_has_type iht ON ing.it_id = iht.id " +
                     "INNER JOIN items i ON iht.i_id = i.id " +
                     "INNER JOIN type t ON iht.t_id = t.id " +
                     "INNER JOIN category c ON iht.c_id = c.id";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                IngredientBean ibean = new IngredientBean();
                ibean.setId(rs.getInt("ingredient_id"));  
                ibean.setIn_code(rs.getString("in_code"));  // Adjust this if i_code is in another table
                ibean.setItem_name(rs.getString("item_name"));
                ibean.setIn_name(rs.getString("in_name"));
                ibean.setInstruction(rs.getString("instruction"));
                ibean.setPhotoPath(rs.getString("photo")); 
                ibean.setRemark(rs.getString("remark"));
                ibean.setIt_id(rs.getInt("it_id"));
                ibean.setC_name(rs.getString("category_name"));
                ibean.setT_name(rs.getString("type_name"));
                ibean.setI_name(rs.getString("item_name"));

                ibeans.add(ibean);
            }
          //  System.out.println("Get successful");
        } catch (Exception e) {
        	e.printStackTrace();
           // System.out.println("Get Ingredient Fail: " + e.getMessage());
        }
        return ibeans;
    }


    
    public List<IngredientBean> getIngredientsByItemId(int itemId) {
        List<IngredientBean> ingredients = new ArrayList<>();
        Connection con = MyConnection.getConnection();
        String sql = "SELECT id, in_code, in_name, instruction, photo, it_id FROM chef_market.ingredient WHERE it_id = ?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, itemId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                IngredientBean ibean = new IngredientBean();
                ibean.setId(rs.getInt("id"));
                ibean.setIn_code(rs.getString("in_code"));
                ibean.setIn_name(rs.getString("in_name"));
                ibean.setInstruction(rs.getString("instruction"));
                ibean.setPhotoPath(rs.getString("photo")); // Assuming photo is stored as a path
                ibean.setIt_id(rs.getInt("it_id"));
                
                ingredients.add(ibean);
            }
            //System.out.println("Ingredients retrieved successfully for itemId: " + itemId);
        } catch (Exception e) {
        	e.printStackTrace();
           // System.out.println("Failed to retrieve ingredients for itemId " + itemId + ": " + e.getMessage());
        }
        return ingredients;
    }
    

	public List<IngredientBean> searchIngredientsByName(String name) {
		List<IngredientBean> ibeans = new ArrayList<>();
		Connection con = MyConnection.getConnection();
		String sql = "SELECT * FROM chef_market.ingredient WHERE item_name LIKE ?";

		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, "%" + name + "%"); // Use LIKE for partial matches
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				IngredientBean ibean = new IngredientBean();
				ibean.setId(rs.getInt("id"));
				ibean.setIn_code(rs.getString("in_code"));
				ibean.setItem_name(rs.getString("item_name"));
				ibean.setIn_name(rs.getString("in_name"));
				ibean.setInstruction(rs.getString("instruction"));
				ibean.setPhotoPath(rs.getString("photo"));
				ibean.setIt_id(rs.getInt("it_id"));

				ibeans.add(ibean);
			}
			//System.out.println("Search successful");
		} catch (Exception e) {
			e.printStackTrace();
			//System.out.println("Search Ingredient Fail: " + e.getMessage());
		}
		return ibeans;
	}

}

