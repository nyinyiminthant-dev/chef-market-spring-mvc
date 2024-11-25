
package com.spring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.model.AdminBean;

import com.spring.repository.AdminRepository;

@Controller
public class AdminRegistrationController {

    private final AdminRepository adminRepository;

    // Constructor for Dependency Injection
    public AdminRegistrationController(AdminRepository adminRepository) {
        this.adminRepository = adminRepository;
    }

   
    @RequestMapping(value = "/admin_register", method = RequestMethod.GET)
    public String showRegistrationForm(Model model) {
        model.addAttribute("admin", new AdminBean());
        return "adminregister"; // This returns the JSP form "register.jsp"
    }

    @RequestMapping(value = "/admin_register", method = RequestMethod.POST)
    public String registerAdmin(@ModelAttribute("admin") AdminBean admin, Model model, RedirectAttributes redirectAttrs) {
       
        // Validate email uniqueness
        if (adminRepository.emailExists(admin.getEmail())) {
            model.addAttribute("errorMessage", "Email already exists. Please use a different email.");
            model.addAttribute("admin", admin); // Retain entered data
            return "adminregister"; // Reload registration page with error message
        }

        // Register the admin
       boolean isRegistered = adminRepository.registerAdmin(admin);

        if (isRegistered) {
           
            model.addAttribute("admin", new AdminBean());
            redirectAttrs.addFlashAttribute("successMessage", "  Successfully Registered!");
            return "redirect:showadmin";
          
        } else {
            model.addAttribute("errorMessage", "Sorry, your data exceeds more than allowed length!");
            model.addAttribute("admin", admin); // Retain entered data
            return "adminregister"; // Reload registration page with error message
        }

        
    }
}

