package com.vehicle.rental.controller;

import com.vehicle.rental.model.Vehicle;
import com.vehicle.rental.service.VehicleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/vehicles")
public class VehicleController {

    private final VehicleService vehicleService;
    
    @Autowired
    public VehicleController(VehicleService vehicleService) {
        this.vehicleService = vehicleService;
    }
    
    @GetMapping
    public String listVehicles(Model model) {
        List<Vehicle> vehicles = vehicleService.getAvailableVehicles();
        model.addAttribute("vehicles", vehicles);
        model.addAttribute("vehicleTypes", vehicleService.getAllVehicleTypes());
        model.addAttribute("vehicleBrands", vehicleService.getAllVehicleBrands());
        
        return "vehicles/list";
    }
    
    @GetMapping("/{vehicleId}")
    public String viewVehicle(@PathVariable int vehicleId, Model model, HttpSession session) {
        Vehicle vehicle = vehicleService.getVehicleById(vehicleId);
        
        if (vehicle == null) {
            return "redirect:/vehicles";
        }
        
        model.addAttribute("vehicle", vehicle);
        
        // Check if user is logged in
        Integer userId = (Integer) session.getAttribute("userId");
        model.addAttribute("isLoggedIn", userId != null);
        
        return "vehicles/view";
    }
    
    @GetMapping("/filter")
    public String filterVehicles(
            @RequestParam(required = false) String type,
            @RequestParam(required = false) String brand,
            @RequestParam(required = false) Double minPrice,
            @RequestParam(required = false) Double maxPrice,
            Model model) {
        
        List<Vehicle> filteredVehicles;
        
        if (type != null && !type.isEmpty()) {
            filteredVehicles = vehicleService.getVehiclesByType(type);
        } else if (brand != null && !brand.isEmpty()) {
            filteredVehicles = vehicleService.getVehiclesByBrand(brand);
        } else if (minPrice != null && maxPrice != null) {
            filteredVehicles = vehicleService.getVehiclesByPriceRange(minPrice, maxPrice);
        } else {
            filteredVehicles = vehicleService.getAvailableVehicles();
        }
        
        model.addAttribute("vehicles", filteredVehicles);
        model.addAttribute("vehicleTypes", vehicleService.getAllVehicleTypes());
        model.addAttribute("vehicleBrands", vehicleService.getAllVehicleBrands());
        model.addAttribute("selectedType", type);
        model.addAttribute("selectedBrand", brand);
        model.addAttribute("minPrice", minPrice);
        model.addAttribute("maxPrice", maxPrice);
        
        return "vehicles/list";
    }
    
    @GetMapping("/search")
    public String searchVehicles(@RequestParam String query, Model model) {
        // This is a simple implementation. In a real application, you would implement a more sophisticated search.
        List<Vehicle> allVehicles = vehicleService.getAllVehicles();
        
        // Filter vehicles based on the query
        List<Vehicle> searchResults = allVehicles.stream()
                .filter(v -> v.getBrand().toLowerCase().contains(query.toLowerCase()) ||
                        v.getModel().toLowerCase().contains(query.toLowerCase()) ||
                        v.getType().toLowerCase().contains(query.toLowerCase()) ||
                        v.getDescription() != null && v.getDescription().toLowerCase().contains(query.toLowerCase()))
                .toList();
        
        model.addAttribute("vehicles", searchResults);
        model.addAttribute("vehicleTypes", vehicleService.getAllVehicleTypes());
        model.addAttribute("vehicleBrands", vehicleService.getAllVehicleBrands());
        model.addAttribute("searchQuery", query);
        
        return "vehicles/list";
    }
}