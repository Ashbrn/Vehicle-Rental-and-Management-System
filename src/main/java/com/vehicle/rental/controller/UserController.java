package com.vehicle.rental.controller;

import com.vehicle.rental.model.User;
import com.vehicle.rental.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class UserController {

    private final UserService userService;
    
    @Autowired
    public UserController(UserService userService) {
        this.userService = userService;
    }
    
    @GetMapping("/register")
    public String showRegisterForm(Model model) {
        model.addAttribute("user", new User());
        return "user/register";
    }
    
    @PostMapping("/register")
    public String registerUser(@ModelAttribute User user, RedirectAttributes redirectAttributes) {
        // Validate user input
        if (userService.isUsernameExists(user.getUsername())) {
            redirectAttributes.addFlashAttribute("error", "Username already exists");
            return "redirect:/user/register";
        }
        
        if (userService.isEmailExists(user.getEmail())) {
            redirectAttributes.addFlashAttribute("error", "Email already exists");
            return "redirect:/user/register";
        }
        
        if (userService.isDrivingLicenseExists(user.getDrivingLicense())) {
            redirectAttributes.addFlashAttribute("error", "Driving license already registered");
            return "redirect:/user/register";
        }
        
        // Set default role
        user.setRole("USER");
        
        // Register user
        int userId = userService.registerUser(user);
        
        if (userId > 0) {
            redirectAttributes.addFlashAttribute("success", "Registration successful. Please login.");
            return "redirect:/user/login";
        } else {
            redirectAttributes.addFlashAttribute("error", "Registration failed. Please try again.");
            return "redirect:/user/register";
        }
    }
    
    @GetMapping("/login")
    public String showLoginForm() {
        return "user/login";
    }
    
    @PostMapping("/login")
    public String loginUser(@RequestParam String username, @RequestParam String password, 
                           HttpSession session, RedirectAttributes redirectAttributes) {
        if (userService.authenticateUser(username, password)) {
            User user = userService.getUserByUsername(username);
            
            // Store user info in session
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("username", user.getUsername());
            session.setAttribute("fullName", user.getFullName());
            session.setAttribute("role", user.getRole());
            
            if ("ADMIN".equals(user.getRole())) {
                return "redirect:/admin/dashboard";
            } else {
                return "redirect:/";
            }
        } else {
            redirectAttributes.addFlashAttribute("error", "Invalid username or password");
            return "redirect:/user/login";
        }
    }
    
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
    
    @GetMapping("/profile")
    public String showProfile(Model model, HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (userId == null) {
            return "redirect:/user/login";
        }
        
        User user = userService.getUserById(userId);
        model.addAttribute("user", user);
        
        return "user/profile";
    }
    
    @PostMapping("/profile/update")
    public String updateProfile(@ModelAttribute User user, HttpSession session, RedirectAttributes redirectAttributes) {
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (userId == null) {
            return "redirect:/user/login";
        }
        
        // Set user ID from session
        user.setUserId(userId);
        
        // Get existing user to preserve password and role
        User existingUser = userService.getUserById(userId);
        user.setPassword(existingUser.getPassword());
        user.setRole(existingUser.getRole());
        
        if (userService.updateUser(user)) {
            // Update session attributes
            session.setAttribute("fullName", user.getFullName());
            
            redirectAttributes.addFlashAttribute("success", "Profile updated successfully");
        } else {
            redirectAttributes.addFlashAttribute("error", "Failed to update profile");
        }
        
        return "redirect:/user/profile";
    }
}