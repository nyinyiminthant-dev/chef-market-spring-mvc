package com.spring.model;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ProductBean {


	  private int id;
	  private String p_code;
	    private String p_name;
	    private String p_size;
	    private double p_price;
	    private int p_quantity;
	    private String p_photo;
	    private MultipartFile mfphoto;
	    private int maxQuantity; 
	      
}
