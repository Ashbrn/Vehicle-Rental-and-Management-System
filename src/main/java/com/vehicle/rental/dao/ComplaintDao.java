package com.vehicle.rental.dao;

import com.vehicle.rental.model.Complaint;
import java.util.List;

public interface ComplaintDao {
    Complaint findById(int complaintId);
    List<Complaint> findAll();
    List<Complaint> findByUserId(int userId);
    List<Complaint> findByBookingId(int bookingId);
    List<Complaint> findByStatus(String status);
    int save(Complaint complaint);
    boolean update(Complaint complaint);
    boolean updateStatus(int complaintId, String status);
    boolean updateAdminResponse(int complaintId, String adminResponse, String status);
    boolean delete(int complaintId);
}