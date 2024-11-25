
package com.spring.controller;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.model.*;
import com.spring.repository.AdminRepository;

@Controller
public class LoginController {
	
	
	
		@Autowired
		private AdminRepository adminRepo;

	

	@PostMapping(value = "/dologin")
	public String doLogin(@Valid @ModelAttribute("admin") LoginBean login, BindingResult bindingResult, Model model, HttpSession session) {
	    if (bindingResult.hasErrors()) {
	        // Return to the login page if there are validation errors
	        return "adminlogin";
	    }

	    AdminRepository arepo = new AdminRepository();
	    AdminBean obj = arepo.loginAdmin(login);

	    if (obj == null) {
	        // Determine if the error is due to an invalid email or incorrect password
	        boolean emailExists = arepo.emailExists(login.getEmail());
	        
	        if (!emailExists) {
	        	 model.addAttribute("emailError", "Incorrect email");
	        } else {
	            model.addAttribute("passwordError", "Incorrect password.");
	        }
	        
	        return "adminlogin";
	    } 

	    // If login is successful, set session attributes and redirect based on role
	    session.setAttribute("adminEmail", obj.getEmail());
	    session.setAttribute("adID", obj.getId());
	    session.setAttribute("adFN", obj.getFirst_name());
	    session.setAttribute("adpsw", obj.getPassword());
	    model.addAttribute("admin", obj);
	    model.addAttribute("email", obj.getEmail());

	    switch (obj.getRole()) {
	        case "owner":
	            return "ologinsuccess";
	        case "Product-Admin":
	            return "ploginsuccess";
	        case "Sell-Admin":
	            return "sloginsuccess";
	        default:
	            return "adminlogin";
	    }
	}
	
	

	@GetMapping(value = "/showadmin")
	public String showAllAdmins(Model m) {
		List<AdminBean> list = adminRepo.getAdmin();

		if (list.size() > 0) {
			m.addAttribute("adminlist", list);

		} else {
			m.addAttribute("error", "No Admin");
		}
		return "showAdmins";
	}
	
	
	 @GetMapping("/deleteAdmin/{id}")
	public String deleteBook(@PathVariable("id") int id, RedirectAttributes redirectAttributes) {

		int adminDeleted = adminRepo.deleteAdmin(id);
		if (adminDeleted > 0) {
			redirectAttributes.addFlashAttribute("success", "Admin deleted successfully.");
		} else {
			redirectAttributes.addFlashAttribute("error", "Failed to delete the Admin.");
		}
		return "redirect:/showadmin";

	}

}

