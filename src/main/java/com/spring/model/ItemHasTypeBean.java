package com.spring.model;

import javax.validation.constraints.NotNull;

import lombok.Data;

@Data
public class ItemHasTypeBean {

	private int id;

	

	@NotNull(message = "Type must be selected")
	private Integer t_id;

	@NotNull(message = "Select Item and Add")
	private Integer i_id;
	
	@NotNull(message = "Category must be selected")
	private Integer c_id;
	
	private String c_name;
	private String t_name;
	private String i_name;

	
	
	 private boolean ingredientExists;

	    // Other existing fields and methods

	    public boolean isIngredientExists() {
	        return ingredientExists;
	    }

	    public void setIngredientExists(boolean ingredientExists) {
	        this.ingredientExists = ingredientExists;
	    }

}
