package com.vehicle.rental.controller;

import com.vehicle.rental.model.Booking;
import com.vehicle.rental.model.Vehicle;
import com.vehicle.rental.service.BookingService;
import com.vehicle.rental.service.VehicleService;
import com.vehicle.rental.service.VideoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;

@Controller
@RequestMapping("/bookings")
public class BookingController {

    private final BookingService bookingService;
    private final VehicleService vehicleService;
    private final VideoService videoService;
    
    @Autowired
    public BookingController(BookingService bookingService, VehicleService vehicleService, VideoService videoService) {
        this.bookingService = bookingService;
        this.vehicleService = vehicleService;
        this.videoService = videoService;
    }
    
    @GetMapping
    public String listBookings(Model model, HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (userId == null) {
            return "redirect:/user/login";
        }
        
        List<Booking> bookings = bookingService.getBookingsByUserId(userId);
        model.addAttribute("bookings", bookings);
        
        return "bookings/list";
    }
    
    @GetMapping("/{bookingId}")
    public String viewBooking(@PathVariable int bookingId, Model model, HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (userId == null) {
            return "redirect:/user/login";
        }
        
        Booking booking = bookingService.getBookingById(bookingId);
        
        if (booking == null || booking.getUserId() != userId) {
            return "redirect:/bookings";
        }
        
        model.addAttribute("booking", booking);
        
        // Get videos for this booking
        model.addAttribute("pickupVideos", videoService.getVideosByBookingIdAndType(bookingId, "PICKUP"));
        model.addAttribute("returnVideos", videoService.getVideosByBookingIdAndType(bookingId, "RETURN"));
        
        return "bookings/view";
    }
    
    @GetMapping("/create/{vehicleId}")
    public String showBookingForm(
            @PathVariable int vehicleId, 
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate,
            @RequestParam(required = false) BigDecimal totalAmount,
            Model model, 
            HttpSession session) {
        
        // For testing purposes, use a hardcoded user ID that we know exists in the database
        Integer userId = 1; // Use user_id 1 from data.sql
        
        // Store the user ID in the session for future requests
        session.setAttribute("userId", userId);
        
        if (userId == null) {
            return "redirect:/user/login";
        }
        
        Vehicle vehicle = vehicleService.getVehicleById(vehicleId);
        
        if (vehicle == null || !vehicle.isAvailability()) {
            return "redirect:/vehicles";
        }
        
        model.addAttribute("vehicle", vehicle);
        model.addAttribute("minDate", LocalDate.now());
        model.addAttribute("maxDate", LocalDate.now().plusMonths(3));
        
        // Pass the selected dates and total amount if they were provided
        if (startDate != null) {
            model.addAttribute("selectedStartDate", startDate);
        }
        
        if (endDate != null) {
            model.addAttribute("selectedEndDate", endDate);
        }
        
        if (totalAmount != null) {
            model.addAttribute("calculatedTotal", totalAmount);
        }
        
        return "bookings/create";
    }
    
    @PostMapping("/create/{vehicleId}")
    public String createBooking(
            @PathVariable int vehicleId,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        
        // For testing purposes, use a hardcoded user ID that we know exists in the database
        Integer userId = 1; // Use user_id 1 from data.sql
        
        System.out.println("Using hardcoded user ID: " + userId);
        
        // Store the user ID in the session for future requests
        session.setAttribute("userId", userId);
        
        if (userId == null) {
            return "redirect:/user/login";
        }
        
        Vehicle vehicle = vehicleService.getVehicleById(vehicleId);
        
        if (vehicle == null || !vehicle.isAvailability()) {
            redirectAttributes.addFlashAttribute("error", "Vehicle is not available for booking");
            return "redirect:/vehicles";
        }
        
        // Validate dates
        if (startDate.isBefore(LocalDate.now())) {
            redirectAttributes.addFlashAttribute("error", "Start date cannot be in the past");
            return "redirect:/bookings/create/" + vehicleId;
        }
        
        if (endDate.isBefore(startDate)) {
            redirectAttributes.addFlashAttribute("error", "End date cannot be before start date");
            return "redirect:/bookings/create/" + vehicleId;
        }
        
        // Check if vehicle is available for the selected dates
        if (!bookingService.isVehicleAvailable(vehicleId, startDate, endDate)) {
            redirectAttributes.addFlashAttribute("error", "Vehicle is not available for the selected dates");
            return "redirect:/bookings/create/" + vehicleId;
        }
        
        // Calculate total amount
        long days = ChronoUnit.DAYS.between(startDate, endDate) + 1;
        BigDecimal totalAmount = vehicle.getPricePerDay().multiply(BigDecimal.valueOf(days));
        
        // Create booking
        Booking booking = new Booking();
        booking.setUserId(userId);
        booking.setVehicleId(vehicleId);
        booking.setStartDate(startDate);
        booking.setEndDate(endDate);
        booking.setTotalAmount(totalAmount);
        
        int bookingId = bookingService.createBooking(booking);
        
        if (bookingId > 0) {
            redirectAttributes.addFlashAttribute("success", "Booking created successfully");
            return "redirect:/bookings/" + bookingId;
        } else {
            redirectAttributes.addFlashAttribute("error", "Failed to create booking");
            return "redirect:/bookings/create/" + vehicleId;
        }
    }
    
    @GetMapping("/{bookingId}/cancel")
    public String cancelBooking(@PathVariable int bookingId, HttpSession session, RedirectAttributes redirectAttributes) {
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (userId == null) {
            return "redirect:/user/login";
        }
        
        Booking booking = bookingService.getBookingById(bookingId);
        
        if (booking == null || booking.getUserId() != userId) {
            return "redirect:/bookings";
        }
        
        // Check if booking can be cancelled
        if (!"PENDING".equals(booking.getStatus()) && !"CONFIRMED".equals(booking.getStatus())) {
            redirectAttributes.addFlashAttribute("error", "Booking cannot be cancelled");
            return "redirect:/bookings/" + bookingId;
        }
        
        if (bookingService.cancelBooking(bookingId)) {
            redirectAttributes.addFlashAttribute("success", "Booking cancelled successfully");
        } else {
            redirectAttributes.addFlashAttribute("error", "Failed to cancel booking");
        }
        
        return "redirect:/bookings";
    }
    
    @GetMapping("/{bookingId}/upload-video")
    public String showVideoUploadForm(@PathVariable int bookingId, Model model, HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (userId == null) {
            return "redirect:/user/login";
        }
        
        Booking booking = bookingService.getBookingById(bookingId);
        
        if (booking == null || booking.getUserId() != userId) {
            return "redirect:/bookings";
        }
        
        model.addAttribute("booking", booking);
        
        return "bookings/upload-video";
    }
    
    @PostMapping("/{bookingId}/upload-video")
    public String uploadVideo(
            @PathVariable int bookingId,
            @RequestParam String videoType,
            @RequestParam MultipartFile videoFile,
            @RequestParam(required = false) String notes,
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
        
        if (videoFile.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Please select a video file");
            return "redirect:/bookings/" + bookingId + "/upload-video";
        }
        
        // Check file type
        String contentType = videoFile.getContentType();
        if (contentType == null || !contentType.startsWith("video/")) {
            redirectAttributes.addFlashAttribute("error", "Only video files are allowed");
            return "redirect:/bookings/" + bookingId + "/upload-video";
        }
        
        int videoId = videoService.uploadVideo(bookingId, videoType, videoFile, notes);
        
        if (videoId > 0) {
            redirectAttributes.addFlashAttribute("success", "Video uploaded successfully");
        } else {
            redirectAttributes.addFlashAttribute("error", "Failed to upload video");
        }
        
        return "redirect:/bookings/" + bookingId;
    }
    
    @GetMapping("/{bookingId}/payment")
    public String showPaymentForm(@PathVariable int bookingId, Model model, HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (userId == null) {
            return "redirect:/user/login";
        }
        
        Booking booking = bookingService.getBookingById(bookingId);
        
        if (booking == null || booking.getUserId() != userId) {
            return "redirect:/bookings";
        }
        
        if (!"PENDING".equals(booking.getStatus()) && !"CONFIRMED".equals(booking.getStatus())) {
            return "redirect:/bookings/" + bookingId;
        }
        
        model.addAttribute("booking", booking);
        
        return "bookings/payment";
    }
    
    @PostMapping("/{bookingId}/payment")
    public String processPayment(
            @PathVariable int bookingId,
            @RequestParam String paymentMethod,
            @RequestParam String transactionId,
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
        
        if (bookingService.updatePaymentStatus(bookingId, "PAID", paymentMethod, transactionId)) {
            // Update booking status to CONFIRMED
            bookingService.updateBookingStatus(bookingId, "CONFIRMED");
            redirectAttributes.addFlashAttribute("success", "Payment processed successfully");
        } else {
            redirectAttributes.addFlashAttribute("error", "Failed to process payment");
        }
        
        return "redirect:/bookings/" + bookingId;
    }
    
    @GetMapping("/{bookingId}/invoice")
    public String viewInvoice(@PathVariable int bookingId, Model model, HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (userId == null) {
            return "redirect:/user/login";
        }
        
        Booking booking = bookingService.getBookingById(bookingId);
        
        if (booking == null || booking.getUserId() != userId) {
            return "redirect:/bookings";
        }
        
        model.addAttribute("booking", booking);
        
        return "bookings/invoice";
    }
}