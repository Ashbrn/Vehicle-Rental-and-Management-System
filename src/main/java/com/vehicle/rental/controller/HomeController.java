package com.vehicle.rental.controller;

import com.vehicle.rental.service.VehicleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;

@Controller
public class HomeController {

    private final VehicleService vehicleService;
    
    @Autowired
    public HomeController(VehicleService vehicleService) {
        this.vehicleService = vehicleService;
    }
    
    @GetMapping("/")
    public String home(Model model, HttpSession session) {
        // Add featured vehicles to the model
        model.addAttribute("featuredVehicles", vehicleService.getAvailableVehicles());
        model.addAttribute("vehicleTypes", vehicleService.getAllVehicleTypes());
        model.addAttribute("vehicleBrands", vehicleService.getAllVehicleBrands());
        
        // For testing purposes, set a default user ID in the session
        session.setAttribute("userId", 1);
        session.setAttribute("username", "user1");
        session.setAttribute("fullName", "Rahul Sharma");
        session.setAttribute("role", "USER");
        
        return "index";
    }
    
    @GetMapping("/about")
    public String about() {
        return "about";
    }
    
    @GetMapping("/contact")
    public String contact() {
        return "contact";
    }
    
    @GetMapping("/terms")
    public String terms() {
        return "terms";
    }
    
    @GetMapping("/privacy")
    public String privacy() {
        return "privacy";
    }
    
    @GetMapping("/access-denied")
    public String accessDenied() {
        return "access-denied";
    }
}