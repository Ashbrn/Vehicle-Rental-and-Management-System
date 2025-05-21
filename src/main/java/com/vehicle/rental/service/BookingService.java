package com.vehicle.rental.service;

import com.vehicle.rental.model.Booking;
import java.time.LocalDate;
import java.util.List;

public interface BookingService {
    Booking getBookingById(int bookingId);
    List<Booking> getAllBookings();
    List<Booking> getBookingsByUserId(int userId);
    List<Booking> getBookingsByVehicleId(int vehicleId);
    List<Booking> getBookingsByStatus(String status);
    List<Booking> getActiveBookings();
    boolean isVehicleAvailable(int vehicleId, LocalDate startDate, LocalDate endDate);
    int createBooking(Booking booking);
    boolean updateBooking(Booking booking);
    boolean updateBookingStatus(int bookingId, String status);
    boolean updatePaymentStatus(int bookingId, String paymentStatus, String paymentMethod, String transactionId);
    boolean cancelBooking(int bookingId);
}