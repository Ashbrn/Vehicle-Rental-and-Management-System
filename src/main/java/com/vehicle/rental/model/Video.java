package com.vehicle.rental.model;

import java.time.LocalDateTime;

public class Video {
    private int videoId;
    private int bookingId;
    private String videoType;
    private String videoUrl;
    private LocalDateTime uploadTime;
    private String notes;
    
    // For displaying booking details in views
    private Booking booking;
    
    // Default constructor
    public Video() {
    }
    
    // Constructor with essential fields
    public Video(int bookingId, String videoType, String videoUrl) {
        this.bookingId = bookingId;
        this.videoType = videoType;
        this.videoUrl = videoUrl;
    }
    
    // Getters and Setters
    public int getVideoId() {
        return videoId;
    }
    
    public void setVideoId(int videoId) {
        this.videoId = videoId;
    }
    
    public int getBookingId() {
        return bookingId;
    }
    
    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }
    
    public String getVideoType() {
        return videoType;
    }
    
    public void setVideoType(String videoType) {
        this.videoType = videoType;
    }
    
    public String getVideoUrl() {
        return videoUrl;
    }
    
    public void setVideoUrl(String videoUrl) {
        this.videoUrl = videoUrl;
    }
    
    public LocalDateTime getUploadTime() {
        return uploadTime;
    }
    
    public void setUploadTime(LocalDateTime uploadTime) {
        this.uploadTime = uploadTime;
    }
    
    public String getNotes() {
        return notes;
    }
    
    public void setNotes(String notes) {
        this.notes = notes;
    }
    
    public Booking getBooking() {
        return booking;
    }
    
    public void setBooking(Booking booking) {
        this.booking = booking;
    }
    
    @Override
    public String toString() {
        return "Video{" +
                "videoId=" + videoId +
                ", bookingId=" + bookingId +
                ", videoType='" + videoType + '\'' +
                ", videoUrl='" + videoUrl + '\'' +
                ", uploadTime=" + uploadTime +
                '}';
    }
}