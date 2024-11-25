package com.spring.model;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;

import lombok.Data;

@Data
public class UserBean {
	
	private int id;
	private String u_code;
	 @NotEmpty(message = "First name is required.")
	    private String firstname;

	    @NotEmpty(message = "Last name is required.")
	    private String lastname;

	   
	    private String email;

	    @NotEmpty(message = "Password is required.")
	    private String password;

	    @NotEmpty(message = "Please confirm your password.")
	    private String confirmpassword;
	private boolean feedbackstatus;
	@NotEmpty(message="Please log in to add this item to your cart")
	
	
	private Boolean addToCartstatus;

}


