package com.spring.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.model.TypeBean;
import com.spring.repository.*;


@Controller
public class TypeController {
	@Autowired
	private CategoryRepository crepo;
	
	@Autowired
	private TypeRepository typeRepository;

	@GetMapping(value="/showaddtype")
	public ModelAndView addType(ModelMap map) {
	    TypeBean tbean = new TypeBean();
	    map.addAttribute("cbeans", crepo.getCategory()); 
	    ModelAndView mv = new ModelAndView("add_type", "typelist", tbean);
	    return mv;
	}

	@PostMapping(value = "/addtype")
	public String addedType(@Valid @ModelAttribute("typelist") TypeBean tbean, BindingResult br,
	        ModelMap map, RedirectAttributes redirectAttrs) {
	    TypeRepository trepo = new TypeRepository();
	    System.out.println("Category ID: " + tbean.getC_id());
	    System.out.println("Type Name: " + tbean.getT_name());
	    
	    if (br.hasErrors()) {
	        map.addAttribute("tbeans", trepo.getTypes());
	        map.addAttribute("typelist", tbean); 
	        map.addAttribute("cbeans", crepo.getCategory());
	        map.addAttribute("cerror", "Please select a category.");
	        map.addAttribute("error", "Please fill the type");    
	         
	        return "add_type";
	    }
	    
	    if (tbean.getC_id() == null || tbean.getC_id() == 0) {
	    	map.addAttribute("cbeans", crepo.getCategory());
	    	
	    	 map.addAttribute("cerror", "Please select a category.");
	        return "add_type";
	    }
	    int i = trepo.insertType(tbean);
	    if (i == 0) {
	    	map.addAttribute("cbeans", crepo.getCategory());
	        map.addAttribute("tbeans", trepo.getTypes());
	        map.addAttribute("typelist", tbean);
	        return "add_type";
	    } else {
	        redirectAttrs.addFlashAttribute("successMessage", "Type added successfully!");
	        return "redirect:/showaddtype";
	    }
	}
	
	

	 @GetMapping(value = "/showtype")
	 	public String showAllCategory(ModelMap map) {
	 		List<TypeBean> list = typeRepository.getTypes();

	 		if (list.size() > 0) {
	 			map.addAttribute("typelist", list);

	 		} else {
	 			map.addAttribute("error", "No Type");
	 		}
	 		return "showTypeList";
	 	}
	

}
