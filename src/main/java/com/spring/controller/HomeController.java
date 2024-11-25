package com.spring.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.model.*;
import com.spring.repository.*;



@Controller
public class HomeController {
	
	@GetMapping(value="/adlogin")
	
	public String showLogin(HttpSession session, HttpServletRequest request) {
	    // Check if the session already contains "adminEmail" attribute
	    if (session.getAttribute("adminEmail") == null) {
	        // Check if the user is already on the login page, avoid redirect loop
	        String requestURI = request.getRequestURI();
	        if (!requestURI.equals(request.getContextPath() + "/productadmin")) {
	            // Redirect to login page only if the user is not already there
	            return ("redirect:/producdadmin");
	        }
	    }
	    
	    // If logged in, proceed to the admin page
	   return "redirect:/productAdmin";
	}

	
	
	@GetMapping(value="/productadmin")
	public ModelAndView showLogin() {
		AdminBean abean = new AdminBean();
		ModelAndView mv = new ModelAndView("adminlogin","admin",abean);
		return mv;
	}
	
	@GetMapping(value = "/productAdmin")
	public String showHome (ModelMap map, HttpSession session) {
		ItemsRepository irepo = new ItemsRepository();
		List<ItemsBean> ibeans = irepo.getItems();
		map.addAttribute("ibeans", ibeans);
		
		TypeRepository trepo =new TypeRepository();
		List<TypeBean> tbeans = trepo.getTypes();
		map.addAttribute("tbeans", tbeans);
		
		CategoryRepository crepo = new CategoryRepository();
		List<CategoryBean> cbeans = crepo.getCategory();
		map.addAttribute("cbeans", cbeans);
		
		ItemHasTypeRepository itemHasTypeRepository = new ItemHasTypeRepository();
		List<ItemHasTypeBean>  itemhastypelist = itemHasTypeRepository.displayItemshastypes();
    	map.addAttribute("itemhastypelist", itemhastypelist);
    	
    	IngredientRepository ingrepo = new IngredientRepository();
    	List<IngredientBean> ingredients = ingrepo.showIngredients();
		map.addAttribute("ingredientList", ingredients);
		
		
		
		
		  
		 String adminEmail = (String) session.getAttribute("adminEmail");
		    
		    if (adminEmail != null) {
		        AdminRepository adminRepo = new AdminRepository();  // Assuming you have an AdminRepository to fetch admin data
		        AdminBean adminBean = adminRepo.getAdminByEmail(adminEmail);  // Fetch admin data by email
		        
		        // Add the adminBean to the model so you can access it in the JSP
		        map.addAttribute("admin", adminBean);
		    }
		return "productAdmin";
	}
	
	 
	  
	  @GetMapping(value="/goowner")
	  public String showOwner () {
		  return "owner_view";
	  }
	  @GetMapping(value="/gosell_admin")
	  public String showSellAdmin () {
		  return "sell_admin_view";
	  }
	  
	  
	  @GetMapping(value="/adminlogout")
	    public String logout(ModelMap map) {
		  CategoryRepository crepo = new CategoryRepository();
	    	List<CategoryBean> categories = crepo.getCategory(); 
	        System.out.println("Categories: " + categories); 
	        map.addAttribute("categories", categories);
	        return "index";
	    }
}
