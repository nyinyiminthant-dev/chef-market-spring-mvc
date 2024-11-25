package com.spring.model;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class IngredientBean {

	private int id;
	private String in_code;
	 @NotBlank(message = "Item name is required.")
	private String item_name;
	
    @NotBlank(message = "Ingredient name is required.")
	 private String in_name;
	
    @NotBlank(message = "Instruction is required.")
	private String instruction;
    
    @NotNull(message = "Please upload at least one image")
	private MultipartFile[] photo;
	private String photoPath;
	

 

	 

	private Integer t_id;
	
	private String remark;
	@NotNull(message = "Items must be selected")
	private int it_id;
	
	private String c_name;
	private String t_name;
	private String i_name;
}
