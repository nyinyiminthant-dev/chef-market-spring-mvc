package com.spring.model;

import lombok.Data;

@Data
public class Feedback {
    private int id;
    private String f_code; 
    private String review;
    private int u_id; 
    private int in_id; 
    private String firstname;
    private String lastname;
}


