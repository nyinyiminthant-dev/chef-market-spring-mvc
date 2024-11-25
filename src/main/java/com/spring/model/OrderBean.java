package com.spring.model;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class OrderBean {
private int id;
private String o_code;
private String u_firstname;
private String u_lastname;
private String u_email;
private String p_code;
private String pay_code;
private String p_name;
private int quantity;
private String address;
private Date o_date;
private double price;
private String st_date;
private String end_date;
private Date date_time;  
private int u_id;    // User ID (foreign key with user table database)          
private int pay_id;  // Pay ID (foreign key with payment table database)     
private List<ProductBean> products;
private double amount;
private String method;
 
private int p_id;




}
