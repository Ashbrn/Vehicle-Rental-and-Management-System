package com.vehicle.rental.dao;

import com.vehicle.rental.model.Booking;
import java.time.LocalDate;
import java.util.List;

public interface BookingDao {
    Booking findById(int bookingId);
    List<Booking> findAll();
    List<Booking> findByUserId(int userId);
    List<Booking> findByVehicleId(int vehicleId);
    List<Booking> findByStatus(String status);
    List<Booking> findActiveBookings();
    boolean isVehicleAvailable(int vehicleId, LocalDate startDate, LocalDate endDate);
    int save(Booking booking);
    boolean update(Booking booking);
    boolean updateStatus(int bookingId, String status);
    boolean updatePaymentStatus(int bookingId, String paymentStatus, String paymentMethod, String transactionId);
    boolean delete(int bookingId);
}