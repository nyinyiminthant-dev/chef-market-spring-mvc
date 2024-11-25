package com.spring.controller;

import java.util.ArrayList;  
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.model.*;
import com.spring.repository.*;

@Controller
public class ItemsController {

	private ItemsRepository irepo;

	public ItemsController(ItemsRepository irepo) {
		this.irepo = irepo;
	}

	@Autowired
	private TypeRepository trepo;

	@Autowired
	private CategoryRepository crepo;

	@GetMapping(value = "showadditems")
	public ModelAndView addItems(ModelMap map) {

		ItemsBean ibean = new ItemsBean();
		map.addAttribute("cbeans", crepo.getCategory());
		map.addAttribute("tbeans", trepo.getTypesByCategory(0));
		ModelAndView mv = new ModelAndView("add_items", "itemslist", ibean);
		return mv;
	}

	@PostMapping("/showadditems")
	public String addItemsWithCategory(@Valid @ModelAttribute("itemslist") ItemsBean ibean, BindingResult br,
			ModelMap map,RedirectAttributes redirectAttrs) {
		map.addAttribute("cbeans", crepo.getCategory());

		
		if (ibean.getC_id() != null) {
			map.addAttribute("tbeans", trepo.getTypesByCategory(ibean.getC_id()));
		} else {
			map.addAttribute("tbeans", new ArrayList<>()); 
		}

		if (br.hasErrors()) {
			return "add_items";
		}
		int i = irepo.insertItems(ibean);
		if (i == 0) {
			map.addAttribute("tbeans", trepo.getTypes());
			map.addAttribute("ibeans", irepo.getItems());
			map.addAttribute("itemslist", ibean);
			return "add_items";
		} else {
			redirectAttrs.addFlashAttribute("successMessage", "Type added successfully!");
			return "redirect:/showadditems";
		}
	}

	@PostMapping(value = "/additem")
	public String addedType(@Valid @ModelAttribute("itemslist") ItemsBean ibean, BindingResult br, ModelMap map,
			RedirectAttributes redirectAttrs) {
		TypeRepository trepo = new TypeRepository();
		System.out.println("Type ID: " + ibean.getT_id());
		System.out.println("Item Name: " + ibean.getI_name());

		if (br.hasErrors()) {
			map.addAttribute("ibeans", irepo.getItems());
			map.addAttribute("itemslist", ibean);
			map.addAttribute("tbeans", trepo.getTypes());
			map.addAttribute("terror", "Please select a type.");
			map.addAttribute("error", "Please fill the item");

			return "add_items";
		}

		if (ibean.getT_id() == null || ibean.getT_id() == 0) {
			map.addAttribute("tbeans", trepo.getTypes());

			map.addAttribute("terror", "Please select a type.");
			return "add_items";
		}
		int i = irepo.insertItems(ibean);
		if (i == 0) {
			map.addAttribute("tbeans", trepo.getTypes());
			map.addAttribute("ibeans", irepo.getItems());
			map.addAttribute("itemslist", ibean);
			return "add_items";
		} else {
			redirectAttrs.addFlashAttribute("successMessage", "Type added successfully!");
			return "redirect:/showadditems";
		}
	}

	@GetMapping("/getTypesByCategory")
	@ResponseBody
	public List<TypeBean> getTypesByCategory(@RequestParam int c_id) {
		return trepo.getTypesByCategory(c_id);
	}
	
	@GetMapping(value = "/showitem")
 	public String showAllItems(ModelMap map) {
 		List<ItemsBean> list = irepo.getItems();

 		if (list.size() > 0) {
 			map.addAttribute("itemlist", list);

 		} else {
 			map.addAttribute("error", "No Items");
 		}
 		return "showItemList";
 	}

}
