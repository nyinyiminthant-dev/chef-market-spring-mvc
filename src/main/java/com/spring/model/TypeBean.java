package com.spring.model;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import lombok.Data;

@Data
public class TypeBean {

	private int id;
	private String t_code;
	@NotEmpty(message = "type name cannot be empty")
	private String t_name;
	 @NotNull(message = "Category must be selected") 
	    private Integer c_id;
	 
	 private String c_code;
}
