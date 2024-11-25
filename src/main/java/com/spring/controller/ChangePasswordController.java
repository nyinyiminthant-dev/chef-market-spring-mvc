/*
 * package com.spring.controller;
 * 
 * import org.springframework.stereotype.Controller; import
 * org.springframework.ui.Model; import org.springframework.ui.ModelMap; import
 * org.springframework.validation.BindingResult; import
 * org.springframework.web.bind.annotation.GetMapping; import
 * org.springframework.web.bind.annotation.ModelAttribute; import
 * org.springframework.web.bind.annotation.PostMapping; import
 * org.springframework.web.bind.annotation.RequestParam; import
 * org.springframework.web.bind.annotation.SessionAttribute; import
 * com.spring.model.*; import com.spring.repository.AdminRepository;
 * 
 * 
 * @Controller public class ChangePasswordController {
 * 
 * private AdminRepository arepo;
 * 
 * ChangePasswordController(AdminRepository arepo) { this.arepo = arepo; }
 * 
 * @GetMapping(value = "/showChangePassword") public String
 * showChangePasswordPage(ModelMap map, @SessionAttribute("adminEmail") String
 * email) { AdminBean admin = arepo.getAdminByEmail(email);
 * map.addAttribute("admin", admin); return "change_password"; }
 * 
 * @PostMapping(value = "/pchangep") public String
 * editPassword(@ModelAttribute("admin") AdminBean admin, BindingResult br,
 * ModelMap map) { if (br.hasErrors()) { map.addAttribute("admin", admin);
 * return "admin/change_password"; }
 * 
 * 
 * AdminBean currentAdmin = arepo.getAdminByEmail(admin.getEmail()); if
 * (!currentAdmin.getPassword().equals(admin.getPassword())) { // Use the
 * correct field map.addAttribute("errorMessage",
 * "Current password is incorrect."); return "productAdmin"; }
 * 
 * // Update the password in the database int result =
 * arepo.changePassword(admin); if (result == 0) {
 * map.addAttribute("errorMessage",
 * "Failed to change password. Please try again."); } else {
 * map.addAttribute("successMessage", "Password changed successfully."); }
 * return "change_password"; }
 * 
 * @PostMapping("/change-password") public String
 * handleChangePassword(@RequestParam("email") String email,
 * 
 * @RequestParam("password") String password, Model model) { boolean isUpdated =
 * arepo.updatePassword(email, password); if (isUpdated) {
 * model.addAttribute("message", "Password updated successfully!");
 * model.addAttribute("admin", new LoginBean()); return "login";
 * 
 * } else { model.addAttribute("error", "Failed to update password."); return
 * "change_password"; } } }
 */