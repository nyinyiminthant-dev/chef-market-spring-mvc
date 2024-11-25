package com.spring.model;

import lombok.Data;

@Data
public class OrderDetail {
	
	private int id;
	private int o_id;
	private int p_id;
	private int quantity;
	private double price;

}
