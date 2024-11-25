package com.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.repository.UserRepository;
import com.spring.model.*;

@Controller

public class ForgotPasswordController {
	
	    @Autowired
	    private UserRepository UserRepository;
	    
	    @GetMapping(value ="/forgot-password")
		public String doforget(@ModelAttribute("passwordObj") UserBean bean,BindingResult br) {
			return "forget-password";
		
		}

	    @PostMapping("/forgot-password")
	    public String handleForgotPassword(@RequestParam("email") String email, Model model) {
	        UserBean user = UserRepository.findByEmail(email);
	        if (user != null) {
	            model.addAttribute("userId", user.getId());
	            model.addAttribute("email", email); // Add email to the model
	            return "change-password";  // Redirect to the change password page
	        } else {
	            model.addAttribute("error", "Email not found!");
	            return "forget-password";  // Reload the forgot password page
	        }
	    }


	    @PostMapping("/change-password")
	    public String handleChangePassword(@RequestParam("newPassword") String newPassword,
	                                       @RequestParam("email") String email,  // Add email as a request parameter
	                                       Model model,RedirectAttributes redirectAttrs) {
	        boolean isUpdated = UserRepository.updatePassword(newPassword, email);  // Pass email to the method
	        if (isUpdated) {
	            model.addAttribute("message", "Password updated successfully!");
	            model.addAttribute("userObj", new UserBean());
	            
	            redirectAttrs.addFlashAttribute("successMessage", "Password updated successfully!");
	            return "redirect:/login";   // Redirect to the login page
	        } else {
	           
	            
	            return "change-password";  // Reload the change password page
	        }
	    }

	}

