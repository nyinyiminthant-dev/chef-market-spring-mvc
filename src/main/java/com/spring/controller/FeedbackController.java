package com.spring.controller;

import com.spring.model.Feedback;
import com.spring.model.UserBean;
import com.spring.repository.FeedbackRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class FeedbackController {

    @Autowired
    private FeedbackRepository feedbackRepo;

    // Display feedback form, ensuring user is logged in
    @GetMapping("/feedback")
    public String showFeedbackForm(Model model, HttpSession session) {
        UserBean loggedInUser = (UserBean) session.getAttribute("loggedInUser");
        
        if (loggedInUser == null) {
            return "redirect:/feedback_login"; 
        }

        model.addAttribute("feedback", new Feedback());
        return "feedbackForm"; 
    }

    // Handle general feedback submission
    @PostMapping("/submitFeedback")
    public String submitFeedback(
            @ModelAttribute("feedback") Feedback feedback, Model model, HttpSession session) {

        UserBean loggedInUser = (UserBean) session.getAttribute("loggedInUser");

        if (loggedInUser == null) {
            model.addAttribute("error", "Please log in to submit feedback.");
            return "redirect:/login"; 
        }

        // Associate feedback with logged-in user ID
        feedback.setU_id(loggedInUser.getId());
       
        int result = feedbackRepo.insertFeedback(feedback);
        if (result > 0) {
            model.addAttribute("message", "Feedback received successfully!");
            model.addAttribute("feedback", feedback); 
        } else {
            model.addAttribute("message", "Error submitting feedback.");
        }
        return "feedbackSuccess"; 
    }
    
    // Display ingredient detail along with related feedback
    @GetMapping("/detail/{ingredientId}")
    public String showIngredientDetail(
            @PathVariable("ingredientId") int ingredientId, Model model, HttpSession session) {

        List<Feedback> feedbackList = feedbackRepo.findFeedbackByIngredientId(ingredientId);
        model.addAttribute("feedbackList", feedbackList);

        UserBean loggedInUser = (UserBean) session.getAttribute("loggedInUser");
        model.addAttribute("isLoggedIn", loggedInUser != null);

        return "ingredientDetail";
    }

    // Handle feedback submission specific to an ingredient
    @PostMapping("/ingredient/{ingredientId}/submitFeedback")
    public String submitIngredientFeedback(
            @PathVariable("ingredientId") int ingredientId,
            @RequestParam("review") String review,
            HttpSession session, Model model) {

        UserBean loggedInUser = (UserBean) session.getAttribute("loggedInUser");

        if (loggedInUser == null) {
            model.addAttribute("loginPrompt", "Please log in to submit feedback.");
            return "redirect:/login";
        }

        // Create and populate feedback for the specific ingredient
        Feedback feedback = new Feedback();
        feedback.setReview(review);
        feedback.setU_id(loggedInUser.getId()); // Set user ID from session
        feedback.setIn_id(ingredientId); // Set ingredient ID

        int result = feedbackRepo.insertFeedback(feedback);
        if (result > 0) {
            System.out.println("Feedback submitted successfully.");
        } else {
            model.addAttribute("error", "There was an error submitting your feedback.");
            return "redirect:/detail/" + ingredientId;
        }

        // Redirect to ingredient detail page after submission
        return "redirect:/detail/" + ingredientId;
    }
}
