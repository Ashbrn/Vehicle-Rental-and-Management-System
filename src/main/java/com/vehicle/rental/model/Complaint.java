package com.vehicle.rental.model;

import java.time.LocalDateTime;

public class Complaint {
    private int complaintId;
    private int userId;
    private Integer bookingId; // Optional, can be null
    private String subject;
    private String description;
    private String status;
    private String adminResponse;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    
    // For displaying user and booking details in views
    private User user;
    private Booking booking;
    
    // Default constructor
    public Complaint() {
    }
    
    // Constructor with essential fields
    public Complaint(int userId, Integer bookingId, String subject, String description) {
        this.userId = userId;
        this.bookingId = bookingId;
        this.subject = subject;
        this.description = description;
        this.status = "OPEN";
    }
    
    // Getters and Setters
    public int getComplaintId() {
        return complaintId;
    }
    
    public void setComplaintId(int complaintId) {
        this.complaintId = complaintId;
    }
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public Integer getBookingId() {
        return bookingId;
    }
    
    public void setBookingId(Integer bookingId) {
        this.bookingId = bookingId;
    }
    
    public String getSubject() {
        return subject;
    }
    
    public void setSubject(String subject) {
        this.subject = subject;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public String getAdminResponse() {
        return adminResponse;
    }
    
    public void setAdminResponse(String adminResponse) {
        this.adminResponse = adminResponse;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    public User getUser() {
        return user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    
    public Booking getBooking() {
        return booking;
    }
    
    public void setBooking(Booking booking) {
        this.booking = booking;
    }
    
    @Override
    public String toString() {
        return "Complaint{" +
                "complaintId=" + complaintId +
                ", userId=" + userId +
                ", bookingId=" + bookingId +
                ", subject='" + subject + '\'' +
                ", status='" + status + '\'' +
                ", createdAt=" + createdAt +
                '}';
    }
}