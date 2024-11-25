package com.spring.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.spring.model.PaymentBean;
import com.spring.repository.PaymentRepo;

@Controller
public class PaymentController {
	@Autowired
	private PaymentRepo payrepo;
	
	@GetMapping(value = "/showpayment")
 	public String showAllCategory(Model m) {
 		List<PaymentBean> list = payrepo.getPayment();

 		if (list.size() > 0) {
 			m.addAttribute("paylist", list);

 		} else {
 			m.addAttribute("error", "No Payment");
 		}
 		return "showPayment";
 	}
}
