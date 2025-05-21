package com.vehicle.rental.controller;

import com.vehicle.rental.model.Booking;
import com.vehicle.rental.model.Complaint;
import com.vehicle.rental.service.BookingService;
import com.vehicle.rental.service.ComplaintService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/complaints")
public class ComplaintController {

    private final ComplaintService complaintService;
    private final BookingService bookingService;
    
    @Autowired
    public ComplaintController(ComplaintService complaintService, BookingService bookingService) {
        this.complaintService = complaintService;
        this.bookingService = bookingService;
    }
    
    @GetMapping
    public String listComplaints(Model model, HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (userId == null) {
            return "redirect:/user/login";
        }
        
        List<Complaint> complaints = complaintService.getComplaintsByUserId(userId);
        model.addAttribute("complaints", complaints);
        
        return "complaints/list";
    }
    
    @GetMapping("/{complaintId}")
    public String viewComplaint(@PathVariable int complaintId, Model model, HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (userId == null) {
            return "redirect:/user/login";
        }
        
        Complaint complaint = complaintService.getComplaintById(complaintId);
        
        if (complaint == null || complaint.getUserId() != userId) {
            return "redirect:/complaints";
        }
        
        model.addAttribute("complaint", complaint);
        
        return "complaints/view";
    }
    
    @GetMapping("/create")
    public String showComplaintForm(Model model, HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (userId == null) {
            return "redirect:/user/login";
        }
        
        // Get user's bookings for the dropdown
        List<Booking> userBookings = bookingService.getBookingsByUserId(userId);
        model.addAttribute("bookings", userBookings);
        model.addAttribute("complaint", new Complaint());
        
        return "complaints/create";
    }
    
    @PostMapping("/create")
    public String submitComplaint(
            @ModelAttribute Complaint complaint,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (userId == null) {
            return "redirect:/user/login";
        }
        
        // Set user ID from session
        complaint.setUserId(userId);
        
        int complaintId = complaintService.submitComplaint(complaint);
        
        if (complaintId > 0) {
            redirectAttributes.addFlashAttribute("success", "Complaint submitted successfully");
            return "redirect:/complaints/" + complaintId;
        } else {
            redirectAttributes.addFlashAttribute("error", "Failed to submit complaint");
            return "redirect:/complaints/create";
        }
    }
    
    @GetMapping("/booking/{bookingId}")
    public String createComplaintForBooking(@PathVariable int bookingId, Model model, HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (userId == null) {
            return "redirect:/user/login";
        }
        
        Booking booking = bookingService.getBookingById(bookingId);
        
        if (booking == null || booking.getUserId() != userId) {
            return "redirect:/bookings";
        }
        
        Complaint complaint = new Complaint();
        complaint.setBookingId(bookingId);
        
        model.addAttribute("booking", booking);
        model.addAttribute("complaint", complaint);
        
        return "complaints/create-for-booking";
    }
    
    @PostMapping("/booking/{bookingId}")
    public String submitComplaintForBooking(
            @PathVariable int bookingId,
            @ModelAttribute Complaint complaint,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (userId == null) {
            return "redirect:/user/login";
        }
        
        Booking booking = bookingService.getBookingById(bookingId);
        
        if (booking == null || booking.getUserId() != userId) {
            return "redirect:/bookings";
        }
        
        // Set user ID and booking ID
        complaint.setUserId(userId);
        complaint.setBookingId(bookingId);
        
        int complaintId = complaintService.submitComplaint(complaint);
        
        if (complaintId > 0) {
            redirectAttributes.addFlashAttribute("success", "Complaint submitted successfully");
            return "redirect:/complaints/" + complaintId;
        } else {
            redirectAttributes.addFlashAttribute("error", "Failed to submit complaint");
            return "redirect:/complaints/booking/" + bookingId;
        }
    }
}