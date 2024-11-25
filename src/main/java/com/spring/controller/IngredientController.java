package com.spring.controller;

import java.io.File;
import java.io.IOException;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.model.Feedback;
import com.spring.model.IngredientBean;
import com.spring.repository.*;

@Controller
public class IngredientController {

	@Autowired
	private TypeRepository trepo;

	@Autowired
	private ItemsRepository itrepo;

	@Autowired
	private IngredientRepository ingrepo;
	
	@Autowired
	private FeedbackRepository frepo;

	@GetMapping(value = "/showIngredientform")
	public ModelAndView showIngredient(ModelMap map) {
		IngredientBean bean = new IngredientBean();
		map.addAttribute("tbeans", trepo.getTypesByCategory(0));
		map.addAttribute("itbeans", itrepo.getItems());
		return new ModelAndView("addingredients", "ingredientObj", bean);
	}

	
	@PostMapping("/addIngredient")
	public String addIngredient(
			// Receive it_id from request parameter
			@Valid @ModelAttribute("ingredientObj") IngredientBean bean, BindingResult br, ModelMap map,
			RedirectAttributes redirectAttrs, HttpSession session) {

		// Set the it_id in the session if not present
		Integer itId = (Integer) session.getAttribute("it_id");
		if (itId != null) {
			bean.setIt_id(itId);
		}
		if (br.hasErrors()) {
			br.getFieldErrors().forEach(error -> System.out
					.println("Error in field " + error.getField() + ": " + error.getDefaultMessage()));
			map.addAttribute("message", "Please correct the errors below.");
			
			
			return "addingredients";
		}

		// Check if images are uploaded
		MultipartFile[] images = bean.getPhoto();
		if (images == null || images.length == 0 || images[0].isEmpty()) {
			map.addAttribute("message", "No images uploaded!");
			map.addAttribute("tbeans", trepo.getTypesByCategory(0));
			map.addAttribute("itbeans", itrepo.getItems());
			return "addingredients";
		}

		String uploadDir = "D:\\Manvanlesson\\ChefsMarket2\\src\\main\\webapp\\upload";
		File uploadFolder = new File(uploadDir);
		if (!uploadFolder.exists()) {
			uploadFolder.mkdirs();
		}

		try {
			// Process each image file and store paths
			StringBuilder photoPaths = new StringBuilder();
			for (MultipartFile image : images) {
				if (!image.isEmpty()) {
					String fileName = image.getOriginalFilename();
					File dest = new File(uploadDir + File.separator + fileName);
					image.transferTo(dest);

					// Accumulate photo paths with comma separation for multiple images
					if (photoPaths.length() > 0) {
						photoPaths.append(",");
					}
					photoPaths.append(fileName);
				}
			}
			bean.setPhotoPath(photoPaths.toString());

			// Insert ingredient record
			int i = ingrepo.insertIngredients(bean);
			if (i > 0) {
				session.removeAttribute("it_id");
				redirectAttrs.addFlashAttribute("successMessage", "Ingredient added successfully!");
				// Clear it_id after success
				return "redirect:/productAdmin";
			} else {
				map.addAttribute("message", "Failed to add ingredient!");
				return "addingredients";
			}
		} catch (IOException e) {
			e.printStackTrace();
			map.addAttribute("message", "Image upload failed due to an error.");
			return "addingredients";
		}
	}

	@GetMapping("/editith/{id}")
	public ModelAndView showEditIngredientForm(@PathVariable("id") int id, ModelMap map, HttpSession session) { // Added
																												// HttpSession
																												// parameter

		IngredientBean existingIngredient = ingrepo.getById(id);
		map.addAttribute("edit_ingredientobj", existingIngredient); // Ensure this attribute name is consistent
		map.addAttribute("tbeans", trepo.getTypesByCategory(0));
		map.addAttribute("itbeans", itrepo.getItems());

		// Store the ingredient ID in the session for later use
		session.setAttribute("ingredientId", id); // Added this line

		return new ModelAndView("edit_ingredient", "edit_ingredientobj", existingIngredient);
	}



	@PostMapping("/updateIngredient")
	public String updateIngredient(
	        @Valid @ModelAttribute("edit_ingredientobj") IngredientBean ingredientBean,
	        BindingResult result,
	        ModelMap map,
	        RedirectAttributes redirectAttrs,
	        HttpSession session,
	        @RequestParam(value = "newImages", required = false) MultipartFile[] newImages) {

	    // Retrieve ID from session
	    Integer id = (Integer) session.getAttribute("ingredientId");
	    if (id == null) {
	        // Handle case where no ID is found in session, possibly redirect or show error
	        return "redirect:/productAdmin"; // Example redirect
	    }

	    // Validation check
	    if (result.hasErrors()) {
	        map.addAttribute("message", "Please correct the errors below.");
	        map.addAttribute("tbeans", trepo.getTypesByCategory(0));
	        map.addAttribute("itbeans", itrepo.getItems());
	        return "edit_ingredient"; // Return to the edit form to retry
	    }

	    // Set the existing ID to the ingredientBean
	    ingredientBean.setId(id);

	 // Check if images are uploaded
	 		MultipartFile[] images = ingredientBean.getPhoto();
	 		if (images == null || images.length == 0 || images[0].isEmpty()) {
	 			map.addAttribute("message", "No images uploaded!");
	 			map.addAttribute("tbeans", trepo.getTypesByCategory(0));
	 			map.addAttribute("itbeans", itrepo.getItems());
	 			return "addingredients";
	 		}

	 		String uploadDir = "D:\\Manvanlesson\\ChefsMarket2\\src\\main\\webapp\\upload";
	 		File uploadFolder = new File(uploadDir);
	 		if (!uploadFolder.exists()) {
	 			uploadFolder.mkdirs();
	 		}

	 		try {
	 			// Process each image file and store paths
	 			StringBuilder photoPaths = new StringBuilder();
	 			for (MultipartFile image : images) {
	 				if (!image.isEmpty()) {
	 					String fileName = image.getOriginalFilename();
	 					File dest = new File(uploadDir + File.separator + fileName);
	 					image.transferTo(dest);

	 					// Accumulate photo paths with comma separation for multiple images
	 					if (photoPaths.length() > 0) {
	 						photoPaths.append(",");
	 					}
	 					photoPaths.append(fileName);
	 				}
	 			}
	 			ingredientBean.setPhotoPath(photoPaths.toString());

	        // Call the repository method to update the ingredient
	        int updated = ingrepo.updateIngredient(ingredientBean);
	        if (updated > 0) {
	            redirectAttrs.addFlashAttribute("successMessage", "Ingredient updated successfully!");
	            return "redirect:/productAdmin"; // Redirect after a successful update
	        } else {
	            map.addAttribute("message", "Failed to update ingredient!");
	            return "edit_ingredient"; // Return to the edit form in case of failure
	        }
	    } catch (IOException e) {
	        e.printStackTrace();
	        map.addAttribute("message", "Image upload failed!");
	        return "edit_ingredient"; // Return to the edit form if an error occurs
	    }
	}
	
	
	   @GetMapping(value = "/showingredient")
	 	public String showAllIngredient(ModelMap map) {
	 		List<IngredientBean> list = ingrepo.showIngredients();

	 		if (list.size() > 0) {
	 			map.addAttribute("ingredientList", list);

	 		} else {
	 			map.addAttribute("error", "No Ingredient");
	 		}
	 		return "showIngregients";
	 	}

	   
	   @GetMapping("/showIngredients")
	   public String showIngredients(ModelMap map) {
	     List<IngredientBean> ingredients = ingrepo.showIngredients();
	     map.addAttribute("ingredientList", ingredients);
	     return "ingredientList";
	   }
	   
	   @GetMapping("/ingredientDetail")
	   public String showIngredientDetail(@RequestParam("id") int id, ModelMap map) {
	     IngredientBean ingredient = ingrepo.getById(id);

	     if (ingredient == null) {
	       map.addAttribute("error", "Ingredient not found");
	       return "error";
	     }
	     
	      List<Feedback> feedbackList = frepo.findFeedbackByIngredientId(id);
	         map.addAttribute("feedbackList", feedbackList);
	         map.addAttribute("ingredient", ingredient);
	     return "ingredientDetail";
	   }
	    
	    @GetMapping("/search")
	    public String searchIngredients(@RequestParam("query") String query, ModelMap map) {
	        List<IngredientBean> filteredIngredients = ingrepo.searchIngredientsByName(query);

	        if (filteredIngredients.isEmpty()) {
	            map.addAttribute("message", "No ingredients found for your search: " + query);
	        } else {
	            map.addAttribute("ingredients", filteredIngredients);
	        }

	        return "ingredientResults"; // Name of the JSP file (ingredientResults.jsp)
	    }
	    
}
