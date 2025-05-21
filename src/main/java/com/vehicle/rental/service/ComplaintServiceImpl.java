package com.vehicle.rental.service;

import com.vehicle.rental.dao.ComplaintDao;
import com.vehicle.rental.model.Complaint;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ComplaintServiceImpl implements ComplaintService {

    private final ComplaintDao complaintDao;
    
    @Autowired
    public ComplaintServiceImpl(ComplaintDao complaintDao) {
        this.complaintDao = complaintDao;
    }

    @Override
    public Complaint getComplaintById(int complaintId) {
        return complaintDao.findById(complaintId);
    }

    @Override
    public List<Complaint> getAllComplaints() {
        return complaintDao.findAll();
    }

    @Override
    public List<Complaint> getComplaintsByUserId(int userId) {
        return complaintDao.findByUserId(userId);
    }

    @Override
    public List<Complaint> getComplaintsByBookingId(int bookingId) {
        return complaintDao.findByBookingId(bookingId);
    }

    @Override
    public List<Complaint> getComplaintsByStatus(String status) {
        return complaintDao.findByStatus(status);
    }

    @Override
    public int submitComplaint(Complaint complaint) {
        // Set initial status
        complaint.setStatus("OPEN");
        return complaintDao.save(complaint);
    }

    @Override
    public boolean updateComplaint(Complaint complaint) {
        return complaintDao.update(complaint);
    }

    @Override
    public boolean updateComplaintStatus(int complaintId, String status) {
        return complaintDao.updateStatus(complaintId, status);
    }

    @Override
    public boolean respondToComplaint(int complaintId, String adminResponse, String status) {
        return complaintDao.updateAdminResponse(complaintId, adminResponse, status);
    }

    @Override
    public boolean deleteComplaint(int complaintId) {
        return complaintDao.delete(complaintId);
    }
}