
package com.spring.model;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class AdminBean {
    private int id;

    private String a_code;
    @NotBlank(message = "{admin.first_name.notBlank}")
    @Size(max = 30, message = "{admin.first_name.size}")
    @Pattern(regexp = "^[A-Za-z]+$", message = "{admin.first_name.pattern}")
    private String first_name;

    @NotBlank(message = "{admin.last_name.notBlank}")
    @Size(max = 30, message = "{admin.last_name.size}")
    @Pattern(regexp = "^[A-Za-z ]+$", message = "{admin.last_name.pattern}")
    private String last_name;

    @NotBlank(message = "{admin.email.notBlank}")
    @Size(max = 50, message = "{admin.email.size}")
    @Pattern(regexp = "^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$", message = "{admin.email.valid}")  // Updated regex for email
    private String email;

    @NotBlank(message = "{admin.password.notBlank}")
    @Size(max = 100, message = "{admin.password.size}")
    @Pattern(
    	    regexp = "^(?=.*[0-9])(?=.*[a-z])(?=.*[.,!?;:+\\-%=<>\u0024€£¥@#&*_^~|()\\[\\]{}\"'\\\\]).{8,}$", 
    	    message = "{admin.password.pattern}"
    	)
  // Updated regex for password
    private String password;
  

 	private MultipartFile[] photo;
 	private String a_photo;
    private String role;
    private String status;
   
}

