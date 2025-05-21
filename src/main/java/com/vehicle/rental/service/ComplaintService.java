package com.vehicle.rental.service;

import com.vehicle.rental.model.Complaint;
import java.util.List;

public interface ComplaintService {
    Complaint getComplaintById(int complaintId);
    List<Complaint> getAllComplaints();
    List<Complaint> getComplaintsByUserId(int userId);
    List<Complaint> getComplaintsByBookingId(int bookingId);
    List<Complaint> getComplaintsByStatus(String status);
    int submitComplaint(Complaint complaint);
    boolean updateComplaint(Complaint complaint);
    boolean updateComplaintStatus(int complaintId, String status);
    boolean respondToComplaint(int complaintId, String adminResponse, String status);
    boolean deleteComplaint(int complaintId);
}