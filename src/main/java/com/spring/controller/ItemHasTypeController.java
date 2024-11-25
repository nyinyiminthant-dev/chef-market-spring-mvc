package com.spring.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.model.IngredientBean;
import com.spring.model.ItemHasTypeBean;
import com.spring.repository.*;

@Controller
public class ItemHasTypeController {

    @Autowired
    private TypeRepository typeRepository;

    @Autowired
    private ItemsRepository itemsRepository;

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private ItemHasTypeRepository itemHasTypeRepository;

    @GetMapping(value = "/showAddItemHasType")
    public ModelAndView showItemHasTypesForm(ModelMap map) {
        ItemHasTypeBean itemHasTypeBean = new ItemHasTypeBean();

       
        map.addAttribute("command", itemHasTypeBean);

        
        map.addAttribute("cbeans", categoryRepository.getCategory());
        map.addAttribute("tbeans", typeRepository.getTypesByCategory(0));
        map.addAttribute("itemslist", itemsRepository.getItemsByType(0));

       
        List<ItemHasTypeBean> itemHasTypeList = itemHasTypeRepository.displayItemshastypes();
        for (ItemHasTypeBean iht : itemHasTypeList) {
            boolean ingredientExists = itemHasTypeRepository.checkIfIngredientExists(iht.getId());
            iht.setIngredientExists(ingredientExists);
        }
        map.addAttribute("itemhastypelist", itemHasTypeList);

        return new ModelAndView("addItemHasType", map);
    }

    @PostMapping("/addItemHasType")
    public ModelAndView addItemHasType(@ModelAttribute("command") @Valid ItemHasTypeBean itemHasType,
                                       BindingResult result, ModelMap map, RedirectAttributes redirectAttrs) {

        if (result.hasErrors()) {
            if (result.hasFieldErrors("t_id")) {
                map.addAttribute("terror", "Please select a type.");
            }
            if (result.hasFieldErrors("i_id")) {
                map.addAttribute("error", "Please select an item.");
            }

            map.addAttribute("cbeans", categoryRepository.getCategory());

            Integer c_id = itemHasType.getC_id();
            if (c_id != null) {
                map.addAttribute("tbeans", typeRepository.getTypesByCategory(c_id));
            }

            Integer t_id = itemHasType.getT_id();
            if (t_id != null) {
                map.addAttribute("itemslist", itemsRepository.getItemsByType(t_id));
            } else {
                map.addAttribute("itemslist", new ArrayList<>());
            }

            return new ModelAndView("addItemHasType", map);
        }

        int i = itemHasTypeRepository.insertItemHasType(itemHasType);
        if (i > 0) {
            redirectAttrs.addFlashAttribute("successMessage", "Ingredient added successfully! Now you can add ingredient in the ingredient list");
        } else {
            redirectAttrs.addFlashAttribute("errorMessage", "Failed to add type.");
        }

        return new ModelAndView("redirect:/showAddItemHasType");
    }

	/*
	 * @GetMapping(value = "/addith/{id}") public ModelAndView
	 * addIngredient(@PathVariable int id) { ItemHasTypeBean ihtbean =
	 * itemHasTypeRepository.getById(id); ModelAndView mv = new
	 * ModelAndView("addingredients", "ingredientObj", new IngredientBean());
	 * mv.addObject("ihtbean", ihtbean); return mv; }
	 */
    
    @GetMapping(value = "/addith/{id}")
    public ModelAndView addIngredient(@PathVariable int id,HttpSession session) {
		session.setAttribute("it_id", id); 
        ItemHasTypeBean ihtbean = itemHasTypeRepository.getById(id);
        ModelAndView mv = new ModelAndView("addingredients", "ingredientObj", new IngredientBean());
        mv.addObject("ihtbean", ihtbean);
  
        return mv;
    }
    
  


}
