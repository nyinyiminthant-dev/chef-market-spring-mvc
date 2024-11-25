package com.spring.model;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import lombok.Data;

@Data
public class ItemsBean {

    private int id;

    private String i_code;

    @NotEmpty(message = "Fill the Item name")
    private String i_name;

    @NotNull(message = "Type must be selected")
    private Integer t_id;

    @NotNull(message = "Category must be selected")
    private Integer c_id; 
    private String t_code;
}
