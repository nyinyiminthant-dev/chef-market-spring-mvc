package com.spring.model;

import java.util.Date;

import lombok.Data;

@Data
public class ProductOrder {
	
	private int id;
	private String o_code;
	private String address;
	private Date date_time;
	private int u_id;
	private int pay_id;

}
