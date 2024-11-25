package com.spring.controller;

import java.io.IOException;  

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.stereotype.Controller;


import com.spring.model.AdminBean;
import com.spring.repository.AdminRepository;

import java.io.File;

@Controller
public class AdminProfileController {

    @Autowired
    private AdminRepository adminRepository;

    @GetMapping("/changeProfile")
    public String showChangeProfileForm(ModelMap map,@SessionAttribute("adminEmail") String email) {
        AdminBean adminBean = adminRepository.getAdminByEmail(email); 
        
        map.addAttribute("admin", adminBean);
        return "adminProfile"; 
    }
  
    @GetMapping("/schangeProfile")
    public String sellshowChangeProfileForm(ModelMap map,@SessionAttribute("adminEmail") String email) {
        AdminBean adminBean = adminRepository.getAdminByEmail(email); 
        
        map.addAttribute("admin", adminBean);
        return "sadminProfile"; 
    }
    
    
    @PostMapping("/updateProfile")
    public String updateProfile(@ModelAttribute("admin") AdminBean admin, Model model, RedirectAttributes redirectAttrs) {
        // Retrieve uploaded files
        MultipartFile[] images = admin.getPhoto();

        // Define upload directory path
        String uploadDir = "D:\\Manvanlesson\\ChefsMarket2\\src\\main\\webapp\\upload";
        File uploadFolder = new File(uploadDir);
        if (!uploadFolder.exists()) {
            uploadFolder.mkdirs();
        }

        try {
            // Check if images are uploaded
            StringBuilder photoPaths = new StringBuilder();
            boolean photoUploaded = false;

            if (images != null && images.length > 0 && !images[0].isEmpty()) {
                // Process each uploaded image
                for (MultipartFile image : images) {
                    if (!image.isEmpty()) {
                        String fileName = image.getOriginalFilename();
                        File dest = new File(uploadDir + File.separator + fileName);
                        image.transferTo(dest);  // Save file to the specified path

                        // Append file name to photo paths
                        if (photoPaths.length() > 0) {
                            photoPaths.append(",");
                        }
                        photoPaths.append(fileName);
                    }
                }
                // Set new photo path in AdminBean
                admin.setA_photo(photoPaths.toString());
                photoUploaded = true;
            }

            // Update admin profile in the repository
            if (!photoUploaded) {
                // Retrieve the existing photo path if no new photo is uploaded
                AdminBean existingAdmin = adminRepository.getAdminByEmail(admin.getEmail());
                admin.setA_photo(existingAdmin.getA_photo());
            }
            
          
            int updateResult = adminRepository.updateAdminProfile(admin);
            if (updateResult > 0) {
                redirectAttrs.addFlashAttribute("successMessage", "Profile updated successfully");
            } else {
                redirectAttrs.addFlashAttribute("errorMessage", "Error updating profile");
            }
        } catch (IOException e) {
            model.addAttribute("message", "Error uploading image: " + e.getMessage());
            return "adminProfile";  // Adjust to your JSP page for profile update
        }

        return "redirect:/productAdmin";  // Redirect to the profile page after updating
    }

    
    @PostMapping("/supdateProfile")
    public String supdateProfile(@ModelAttribute("admin") AdminBean admin, Model model, RedirectAttributes redirectAttrs) {
        // Retrieve uploaded files
        MultipartFile[] images = admin.getPhoto();

        // Define upload directory path
        String uploadDir = "D:\\Manvanlesson\\ChefsMarket2\\src\\main\\webapp\\upload";
        File uploadFolder = new File(uploadDir);
        if (!uploadFolder.exists()) {
            uploadFolder.mkdirs();
        }

        try {
            // Check if images are uploaded
            StringBuilder photoPaths = new StringBuilder();
            boolean photoUploaded = false;

            if (images != null && images.length > 0 && !images[0].isEmpty()) {
                // Process each uploaded image
                for (MultipartFile image : images) {
                    if (!image.isEmpty()) {
                        String fileName = image.getOriginalFilename();
                        File dest = new File(uploadDir + File.separator + fileName);
                        image.transferTo(dest);  // Save file to the specified path

                        // Append file name to photo paths
                        if (photoPaths.length() > 0) {
                            photoPaths.append(",");
                        }
                        photoPaths.append(fileName);
                    }
                }
                // Set new photo path in AdminBean
                admin.setA_photo(photoPaths.toString());
                photoUploaded = true;
            }

            // Update admin profile in the repository
            if (!photoUploaded) {
                // Retrieve the existing photo path if no new photo is uploaded
                AdminBean existingAdmin = adminRepository.getAdminByEmail(admin.getEmail());
                admin.setA_photo(existingAdmin.getA_photo());
            }
            
          
            int updateResult = adminRepository.updateAdminProfile(admin);
            if (updateResult > 0) {
                redirectAttrs.addFlashAttribute("successMessage", "Profile updated successfully");
            } else {
                redirectAttrs.addFlashAttribute("errorMessage", "Error updating profile");
            }
        } catch (IOException e) {
            model.addAttribute("message", "Error uploading image: " + e.getMessage());
            return "adminProfile";  // Adjust to your JSP page for profile update
        }

        return "redirect:/gosell_admin";  // Redirect to the profile page after updating
    }
}
