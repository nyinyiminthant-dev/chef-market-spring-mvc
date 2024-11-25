package com.spring.model;

import javax.validation.constraints.NotEmpty;

import lombok.Data;

@Data
public class LoginBean {
	@NotEmpty(message="Please fill the email")
  private String email;
	@NotEmpty(message="Please fill the password")
  private String password;
}
