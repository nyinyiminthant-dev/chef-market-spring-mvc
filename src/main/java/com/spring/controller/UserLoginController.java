package com.spring.controller;

import com.spring.model.CategoryBean;
import com.spring.model.Feedback;
import com.spring.model.IngredientBean;
import com.spring.model.ItemsBean;
import com.spring.model.ProductBean;
import com.spring.model.TypeBean;
import com.spring.model.UserBean;
import com.spring.repository.CategoryRepository;
import com.spring.repository.FeedbackRepository;
import com.spring.repository.IngredientRepository;
import com.spring.repository.ItemsRepository;
import com.spring.repository.ProductRepository;
import com.spring.repository.TypeRepository;
import com.spring.repository.UserRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class UserLoginController {
	
	@Autowired
	private UserRepository repo;
	
	@Autowired
	private ItemsRepository itemsRepo;
	
	@Autowired
	private TypeRepository typeRepo;
	
	@Autowired
	private CategoryRepository crepo;
	
	@Autowired
    private IngredientRepository ingrepo;
	
	@Autowired
	private UserRepository urepo;
	
	@Autowired
	private FeedbackRepository feedbackrepo;
    
    @GetMapping("/")
    public String showIndex(Model model,HttpSession session) {
    	List<CategoryBean> categories = crepo.getCategory(); 
        System.out.println("Categories: " + categories); 
        model.addAttribute("categories", categories);
        
        IngredientRepository ingrepo = new IngredientRepository();
    	List<IngredientBean> ingredients = ingrepo.showIngredients();
		model.addAttribute("ingredientList", ingredients);
		
		ProductRepository product = new ProductRepository();
		 List<ProductBean> products = product.showProduct();
	    model.addAttribute("productList", products);
	    
	   
        return "index";
    }
   
    
    @GetMapping(value = "/backfrompayment")
    public String backToHome(HttpServletRequest request, HttpSession session) {
        // Get the user ID from the old session
        Integer u_id = (Integer) session.getAttribute("uID");

        // Get the logged-in user object from the session
        Object loggedInUser = session.getAttribute("loggedInUser");

        // Invalidate the session to clear all attributes
        session.invalidate();

        // Create a new session after invalidation
        session = request.getSession(true);

        // If uID was present, re-set it in the new session
        if (u_id != null) {
            session.setAttribute("uID", u_id);
            System.out.println("User id: " + u_id);  // Print user ID
        }

        // If loggedInUser exists, set it in the new session and print the email
        if (loggedInUser != null) {
            session.setAttribute("loggedInUser", loggedInUser);
            // Assuming loggedInUser has an email field
            if (loggedInUser instanceof UserBean) {  // Adjust this check based on your model
                UserBean user = (UserBean) loggedInUser;  // Assuming User is the class for the logged-in user
                System.out.println("User email: " + user.getEmail());
            }
        }

        // Redirect to the home page
        return "redirect:/";
    }





    
    @GetMapping(value = "/types/{c_id}") 
    public String showTypesByCategory(@PathVariable("c_id") int c_id, Model model) {
        List<TypeBean> types = typeRepo.getTypesByCategory(c_id); 
        model.addAttribute("types", types); 
        model.addAttribute("categoryId", c_id); 
        return "types"; 
    }

    
    @GetMapping(value = "/items/{t_id}")
    public String showItemsByCategory(@PathVariable("t_id") int t_id, Model model) {
        List<ItemsBean> items = itemsRepo.getItemsByType(t_id);  
        model.addAttribute("items", items); 
        return "items"; 
    }
    
    @GetMapping("/items/{itemId}/ingredients")
    public String showIngredientsByItem(@PathVariable("itemId") int itemId, Model model) {
        List<IngredientBean> ingredients = ingrepo.getIngredientsByItemId(itemId);
        model.addAttribute("ingredients", ingredients);
        return "ingredients";
    }
    
    

    @GetMapping("/register")
    public ModelAndView showRegisterForm() {
        return new ModelAndView("sign-up", "userObj", new UserBean());
    }

    @PostMapping("/registerUser")
    public String registerUser(@ModelAttribute("userObj") UserBean user, Model m, HttpSession session, RedirectAttributes redirectAttrs, BindingResult bindingResult) {
    	
    	   if (bindingResult.hasErrors()) {
    	        return "sign-up"; // Return the form page with errors
    	    }
        boolean emailExists = repo.checkEmail(user.getEmail());
        if (emailExists) {
            m.addAttribute("error", "Email is already registered!");
            return "sign-up"; 
        }

        int registrationResult = repo.insertUser(user);
        if (registrationResult>0) {
            session.setAttribute("user", user); 
            redirectAttrs.addFlashAttribute("successMessage", "Registration in successfully!");
            return "redirect:/login"; 
        } else {
            m.addAttribute("error", "Registration failed. Please try again.");
            return "sign-up"; 
        }
    }

    @GetMapping("/login")
    public ModelAndView showLoginForm() {
        return new ModelAndView("login", "userObj", new UserBean());
    }
    
    @GetMapping("/feedback_login")
    public ModelAndView feedbackLoginForm() {
        UserBean user = new UserBean();
        user.setFeedbackstatus(true);
        return new ModelAndView("login", "loginObj", user);
    }

    
  

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }


    @PostMapping("/doLogin")
    public String doLogin(@ModelAttribute("userObj") UserBean user, Model m, HttpSession session, RedirectAttributes redirectAttrs) {
        // Check if the email exists
        boolean emailExists = repo.checkEmail(user.getEmail());
        
        if (!emailExists) {
            // Email does not exist, so add error and return to login page
            m.addAttribute("error", "Invalid Email!!");
            return "login";
        }
        
        // Email exists, now attempt to authenticate the user
        UserBean authenticatedUser = repo.loginUser(user);
        if (authenticatedUser == null) {
            // Authentication failed, incorrect password
            m.addAttribute("error", "Incorrect Password!!");
            return "login";
        }
        
        // Authentication succeeded, set session and proceed
        session.setAttribute("loggedInUser", authenticatedUser); 
        session.setAttribute("uID", authenticatedUser.getId());
        // Store the full user data
        if (authenticatedUser.isFeedbackstatus()) {
            return "redirect:/feedback";
        }
        
        // Successful login, redirect with success message
        redirectAttrs.addFlashAttribute("successMessage", "Logged in successfully!");
        return "redirect:/";
    }

    @GetMapping(value = "/showuser")
 	public String showAllCategory(Model m) {
 		List<UserBean> list = urepo.getUser();

 		if (list.size() > 0) {
 			m.addAttribute("userlist", list);

 		} else {
 			m.addAttribute("error", "No User");
 		}
 		return "showUser";
 	}
    
    @GetMapping(value = "/showusers")
 	public String showAllSellUsers(Model m) {
 		List<UserBean> list = urepo.getUser();

 		if (list.size() > 0) {
 			m.addAttribute("userlist", list);

 		} else {
 			m.addAttribute("error", "No User");
 		}
 		return "showSellUser";
 	}
    

    @GetMapping("/profile")
    public String showUserProfile(HttpSession session, Model model) {
        UserBean loggedInUser = (UserBean) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            model.addAttribute("user", loggedInUser);

            // Fetch user feedback from the database
            List<Feedback> userFeedback = feedbackrepo.findByUserId(loggedInUser.getId());
            model.addAttribute("feedbackList", userFeedback);
            
            return "profile";  // JSP page to show user profile
        } else {
            return "redirect:/login";  // Redirect to login if not logged in
        }
    }
    
  
}
