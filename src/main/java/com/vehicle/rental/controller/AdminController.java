package com.vehicle.rental.controller;

import com.vehicle.rental.model.Booking;
import com.vehicle.rental.model.Complaint;
import com.vehicle.rental.model.User;
import com.vehicle.rental.model.Vehicle;
import com.vehicle.rental.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/admin")
public class AdminController {

    private final UserService userService;
    private final VehicleService vehicleService;
    private final BookingService bookingService;
    private final VideoService videoService;
    private final ComplaintService complaintService;
    
    private final String uploadDir = "src/main/webapp/uploads/vehicles/";
    
    @Autowired
    public AdminController(UserService userService, VehicleService vehicleService, 
                          BookingService bookingService, VideoService videoService, 
                          ComplaintService complaintService) {
        this.userService = userService;
        this.vehicleService = vehicleService;
        this.bookingService = bookingService;
        this.videoService = videoService;
        this.complaintService = complaintService;
        
        // Create upload directory if it doesn't exist
        File directory = new File(uploadDir);
        if (!directory.exists()) {
            directory.mkdirs();
        }
    }
    
    // Check if user is admin
    private boolean isAdmin(HttpSession session) {
        String role = (String) session.getAttribute("role");
        return "ADMIN".equals(role);
    }
    
    @GetMapping("/dashboard")
    public String dashboard(Model model, HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/access-denied";
        }
        
        // Get counts for dashboard
        int userCount = userService.getAllUsers().size();
        int vehicleCount = vehicleService.getAllVehicles().size();
        int bookingCount = bookingService.getAllBookings().size();
        int complaintCount = complaintService.getAllComplaints().size();
        
        model.addAttribute("userCount", userCount);
        model.addAttribute("vehicleCount", vehicleCount);
        model.addAttribute("bookingCount", bookingCount);
        model.addAttribute("complaintCount", complaintCount);
        
        // Get recent bookings
        List<Booking> recentBookings = bookingService.getAllBookings().stream()
                .limit(5)
                .toList();
        model.addAttribute("recentBookings", recentBookings);
        
        // Get open complaints
        List<Complaint> openComplaints = complaintService.getComplaintsByStatus("OPEN").stream()
                .limit(5)
                .toList();
        model.addAttribute("openComplaints", openComplaints);
        
        return "admin/dashboard";
    }
    
    // User Management
    @GetMapping("/users")
    public String listUsers(Model model, HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/access-denied";
        }
        
        List<User> users = userService.getAllUsers();
        model.addAttribute("users", users);
        
        return "admin/users/list";
    }
    
    @GetMapping("/users/{userId}")
    public String viewUser(@PathVariable int userId, Model model, HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/access-denied";
        }
        
        User user = userService.getUserById(userId);
        
        if (user == null) {
            return "redirect:/admin/users";
        }
        
        model.addAttribute("user", user);
        
        // Get user's bookings
        List<Booking> userBookings = bookingService.getBookingsByUserId(userId);
        model.addAttribute("bookings", userBookings);
        
        // Get user's complaints
        List<Complaint> userComplaints = complaintService.getComplaintsByUserId(userId);
        model.addAttribute("complaints", userComplaints);
        
        return "admin/users/view";
    }
    
    // Vehicle Management
    @GetMapping("/vehicles")
    public String listVehicles(Model model, HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/access-denied";
        }
        
        List<Vehicle> vehicles = vehicleService.getAllVehicles();
        model.addAttribute("vehicles", vehicles);
        
        return "admin/vehicles/list";
    }
    
    @GetMapping("/vehicles/add")
    public String showAddVehicleForm(Model model, HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/access-denied";
        }
        
        model.addAttribute("vehicle", new Vehicle());
        
        return "admin/vehicles/add";
    }
    
    @PostMapping("/vehicles/add")
    public String addVehicle(
            @ModelAttribute Vehicle vehicle,
            @RequestParam MultipartFile imageFile,
            RedirectAttributes redirectAttributes,
            HttpSession session) {
        
        if (!isAdmin(session)) {
            return "redirect:/access-denied";
        }
        
        // Check if registration number already exists
        if (vehicleService.isRegistrationNumberExists(vehicle.getRegistrationNumber())) {
            redirectAttributes.addFlashAttribute("error", "Registration number already exists");
            return "redirect:/admin/vehicles/add";
        }
        
        // Handle image upload
        if (!imageFile.isEmpty()) {
            try {
                // Generate unique filename
                String originalFilename = imageFile.getOriginalFilename();
                String fileExtension = "";
                if (originalFilename != null && originalFilename.contains(".")) {
                    fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
                }
                String newFilename = UUID.randomUUID().toString() + fileExtension;
                
                // Save file to disk
                Path filePath = Paths.get(uploadDir + newFilename);
                Files.write(filePath, imageFile.getBytes());
                
                // Set image URL in vehicle
                vehicle.setImageUrl("/uploads/vehicles/" + newFilename);
            } catch (IOException e) {
                e.printStackTrace();
                redirectAttributes.addFlashAttribute("error", "Failed to upload image");
                return "redirect:/admin/vehicles/add";
            }
        }
        
        // Set availability to true by default
        vehicle.setAvailability(true);
        
        int vehicleId = vehicleService.addVehicle(vehicle);
        
        if (vehicleId > 0) {
            redirectAttributes.addFlashAttribute("success", "Vehicle added successfully");
            return "redirect:/admin/vehicles";
        } else {
            redirectAttributes.addFlashAttribute("error", "Failed to add vehicle");
            return "redirect:/admin/vehicles/add";
        }
    }
    
    @GetMapping("/vehicles/{vehicleId}/edit")
    public String showEditVehicleForm(@PathVariable int vehicleId, Model model, HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/access-denied";
        }
        
        Vehicle vehicle = vehicleService.getVehicleById(vehicleId);
        
        if (vehicle == null) {
            return "redirect:/admin/vehicles";
        }
        
        model.addAttribute("vehicle", vehicle);
        
        return "admin/vehicles/edit";
    }
    
    @PostMapping("/vehicles/{vehicleId}/edit")
    public String updateVehicle(
            @PathVariable int vehicleId,
            @ModelAttribute Vehicle vehicle,
            @RequestParam(required = false) MultipartFile imageFile,
            RedirectAttributes redirectAttributes,
            HttpSession session) {
        
        if (!isAdmin(session)) {
            return "redirect:/access-denied";
        }
        
        Vehicle existingVehicle = vehicleService.getVehicleById(vehicleId);
        
        if (existingVehicle == null) {
            return "redirect:/admin/vehicles";
        }
        
        // Check if registration number already exists and is not the same as the current one
        if (!existingVehicle.getRegistrationNumber().equals(vehicle.getRegistrationNumber()) &&
                vehicleService.isRegistrationNumberExists(vehicle.getRegistrationNumber())) {
            redirectAttributes.addFlashAttribute("error", "Registration number already exists");
            return "redirect:/admin/vehicles/" + vehicleId + "/edit";
        }
        
        // Handle image upload
        if (imageFile != null && !imageFile.isEmpty()) {
            try {
                // Delete old image if exists
                if (existingVehicle.getImageUrl() != null) {
                    String oldFilePath = existingVehicle.getImageUrl().replace("/uploads/vehicles/", uploadDir);
                    File oldFile = new File(oldFilePath);
                    if (oldFile.exists()) {
                        oldFile.delete();
                    }
                }
                
                // Generate unique filename
                String originalFilename = imageFile.getOriginalFilename();
                String fileExtension = "";
                if (originalFilename != null && originalFilename.contains(".")) {
                    fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
                }
                String newFilename = UUID.randomUUID().toString() + fileExtension;
                
                // Save file to disk
                Path filePath = Paths.get(uploadDir + newFilename);
                Files.write(filePath, imageFile.getBytes());
                
                // Set image URL in vehicle
                vehicle.setImageUrl("/uploads/vehicles/" + newFilename);
            } catch (IOException e) {
                e.printStackTrace();
                redirectAttributes.addFlashAttribute("error", "Failed to upload image");
                return "redirect:/admin/vehicles/" + vehicleId + "/edit";
            }
        } else {
            // Keep existing image URL
            vehicle.setImageUrl(existingVehicle.getImageUrl());
        }
        
        // Set vehicle ID
        vehicle.setVehicleId(vehicleId);
        
        if (vehicleService.updateVehicle(vehicle)) {
            redirectAttributes.addFlashAttribute("success", "Vehicle updated successfully");
            return "redirect:/admin/vehicles";
        } else {
            redirectAttributes.addFlashAttribute("error", "Failed to update vehicle");
            return "redirect:/admin/vehicles/" + vehicleId + "/edit";
        }
    }
    
    @GetMapping("/vehicles/{vehicleId}/delete")
    public String deleteVehicle(@PathVariable int vehicleId, RedirectAttributes redirectAttributes, HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/access-denied";
        }
        
        Vehicle vehicle = vehicleService.getVehicleById(vehicleId);
        
        if (vehicle == null) {
            return "redirect:/admin/vehicles";
        }
        
        // Delete image file if exists
        if (vehicle.getImageUrl() != null) {
            String filePath = vehicle.getImageUrl().replace("/uploads/vehicles/", uploadDir);
            File file = new File(filePath);
            if (file.exists()) {
                file.delete();
            }
        }
        
        if (vehicleService.deleteVehicle(vehicleId)) {
            redirectAttributes.addFlashAttribute("success", "Vehicle deleted successfully");
        } else {
            redirectAttributes.addFlashAttribute("error", "Failed to delete vehicle");
        }
        
        return "redirect:/admin/vehicles";
    }
    
    // Booking Management
    @GetMapping("/bookings")
    public String listBookings(Model model, HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/access-denied";
        }
        
        List<Booking> bookings = bookingService.getAllBookings();
        model.addAttribute("bookings", bookings);
        
        return "admin/bookings/list";
    }
    
    @GetMapping("/bookings/{bookingId}")
    public String viewBooking(@PathVariable int bookingId, Model model, HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/access-denied";
        }
        
        Booking booking = bookingService.getBookingById(bookingId);
        
        if (booking == null) {
            return "redirect:/admin/bookings";
        }
        
        model.addAttribute("booking", booking);
        
        // Get videos for this booking
        model.addAttribute("pickupVideos", videoService.getVideosByBookingIdAndType(bookingId, "PICKUP"));
        model.addAttribute("returnVideos", videoService.getVideosByBookingIdAndType(bookingId, "RETURN"));
        
        return "admin/bookings/view";
    }
    
    @PostMapping("/bookings/{bookingId}/update-status")
    public String updateBookingStatus(
            @PathVariable int bookingId,
            @RequestParam String status,
            RedirectAttributes redirectAttributes,
            HttpSession session) {
        
        if (!isAdmin(session)) {
            return "redirect:/access-denied";
        }
        
        if (bookingService.updateBookingStatus(bookingId, status)) {
            redirectAttributes.addFlashAttribute("success", "Booking status updated successfully");
        } else {
            redirectAttributes.addFlashAttribute("error", "Failed to update booking status");
        }
        
        return "redirect:/admin/bookings/" + bookingId;
    }
    
    // Complaint Management
    @GetMapping("/complaints")
    public String listComplaints(Model model, HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/access-denied";
        }
        
        List<Complaint> complaints = complaintService.getAllComplaints();
        model.addAttribute("complaints", complaints);
        
        return "admin/complaints/list";
    }
    
    @GetMapping("/complaints/{complaintId}")
    public String viewComplaint(@PathVariable int complaintId, Model model, HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/access-denied";
        }
        
        Complaint complaint = complaintService.getComplaintById(complaintId);
        
        if (complaint == null) {
            return "redirect:/admin/complaints";
        }
        
        model.addAttribute("complaint", complaint);
        
        return "admin/complaints/view";
    }
    
    @PostMapping("/complaints/{complaintId}/respond")
    public String respondToComplaint(
            @PathVariable int complaintId,
            @RequestParam String adminResponse,
            @RequestParam String status,
            RedirectAttributes redirectAttributes,
            HttpSession session) {
        
        if (!isAdmin(session)) {
            return "redirect:/access-denied";
        }
        
        if (complaintService.respondToComplaint(complaintId, adminResponse, status)) {
            redirectAttributes.addFlashAttribute("success", "Response submitted successfully");
        } else {
            redirectAttributes.addFlashAttribute("error", "Failed to submit response");
        }
        
        return "redirect:/admin/complaints/" + complaintId;
    }
    
    // Reports
    @GetMapping("/reports")
    public String showReports(Model model, HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/access-denied";
        }
        
        // Get data for reports
        List<Booking> allBookings = bookingService.getAllBookings();
        List<Vehicle> allVehicles = vehicleService.getAllVehicles();
        List<Complaint> allComplaints = complaintService.getAllComplaints();
        
        model.addAttribute("bookings", allBookings);
        model.addAttribute("vehicles", allVehicles);
        model.addAttribute("complaints", allComplaints);
        
        return "admin/reports";
    }
}