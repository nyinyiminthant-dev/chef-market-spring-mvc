package com.spring.controller;

import java.util.List; 

import javax.validation.Valid; 

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.model.CategoryBean;
import com.spring.repository.CategoryRepository;




@Controller
public class CategoryController {

	private CategoryRepository crepo;

	public CategoryController(CategoryRepository crepo) {
		this.crepo = crepo;
	}
	
	@GetMapping(value="/addcategory")
	public ModelAndView showCategory() {
		CategoryBean cbean = new CategoryBean();
		ModelAndView mv = new ModelAndView("add_category","categorylist", cbean);
		return mv;
	}
	
	@PostMapping(value = "/addcategory")
	public String addedCategory(@Valid @ModelAttribute("categorylist") CategoryBean cbean, BindingResult br,
	        ModelMap map, RedirectAttributes redirectAttrs) {
	
		if (br.hasErrors()) {
			   map.addAttribute("cbeans", crepo.getCategory());
		        map.addAttribute("categorylist", cbean); 
		        map.addAttribute("error", "Please fill the category");
		        return "add_category";
		}

	

	    if (crepo.categoryExists(cbean.getC_name())) {
	        map.addAttribute("cbeans", crepo.getCategory());
	        map.addAttribute("categorylist", cbean);
	        map.addAttribute("error", "Category already exists!");
	        return "add_category"; 
	    }
	    int i = crepo.insertCategory(cbean);
	    if (i == 0) {
	        map.addAttribute("cbeans", crepo.getCategory());
	        map.addAttribute("categorylist", cbean);
	        return "add_category";
	    } else {
	    	redirectAttrs.addFlashAttribute("successMessage", "Category added successfully!");
	    	return "redirect:/addcategory"; 
	    }
	}
	
	

	  @GetMapping(value="/edit/{id}")
	  public ModelAndView showEdit(@PathVariable int id) {
		  CategoryBean cbean = crepo.getById(id);
		  ModelAndView mv = new ModelAndView("edit_category","cbean",cbean);
		  
		  return mv;
	  }
	  
	  @PostMapping(value="/editcategory/{id}")
	  public String editBook(@ModelAttribute("cbean")CategoryBean cbean,BindingResult br, ModelMap map) {
		  if (br.hasErrors()) {
			map.addAttribute("cbean", cbean);
			
			return "edit_category";
		}
		  
		
		  int i = crepo.editCategory(cbean);
		  if (i==0) {
			map.addAttribute("cbean", cbean);
			return "edit_category";
		} else {
			
			 return "redirect:/productAdmin";
		}
	  }
	  
	  
	  @GetMapping(value="delete/{id}")
	  public String deleteBook(@PathVariable int id) {
		  crepo.solfDelete(id);
		  return "redirect:/productAdmin";
	  }
	  
	  
	  

		@GetMapping("/restore/{id}")
		public String restoreBook(@PathVariable int id) {
		    crepo.restoreCategory(id); 
		    return "redirect:/restore";  
		}

		@GetMapping("/restore")
		public String toRestore(ModelMap map) {
			
		    List<CategoryBean> deletedcategory = crepo.getDeletedCategory();
		    map.addAttribute("recategory", deletedcategory); 
		    return "restore_category";
		}

     @GetMapping(value="/gohome") 
     public String goHome () {
    	 return "redirect:/productAdmin";
     }
     
     @GetMapping(value = "/showcategory")
  	public String showAllCategory(ModelMap mmap) {
  		List<CategoryBean> list = crepo.getCategory();

  		if (list.size() > 0) {
  			mmap.addAttribute("categorylist", list);

  		} else {
  			mmap.addAttribute("error", "No Admin");
  		}
  		return "showCategoryList";
  	}
}
