package com.spring.model;

import java.util.List;

import javax.validation.constraints.NotBlank;


import lombok.Data;

@Data
public class CategoryBean {
  private int id;
  private String c_code;
  
  
  @NotBlank(message = "Category name is required.")
  private String c_name;

  
  
  private List<TypeBean> types;
}
