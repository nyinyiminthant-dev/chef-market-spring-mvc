package com.spring.model;

import lombok.Data;

@Data
public class PaymentBean {
private int id;
private String pay_code;
private double amount;
private String method;

}
