package com.vehicle.rental.service;

import com.vehicle.rental.dao.BookingDao;
import com.vehicle.rental.dao.VehicleDao;
import com.vehicle.rental.model.Booking;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;

@Service
public class BookingServiceImpl implements BookingService {

    private final BookingDao bookingDao;
    private final VehicleDao vehicleDao;
    
    @Autowired
    public BookingServiceImpl(BookingDao bookingDao, VehicleDao vehicleDao) {
        this.bookingDao = bookingDao;
        this.vehicleDao = vehicleDao;
    }

    @Override
    public Booking getBookingById(int bookingId) {
        return bookingDao.findById(bookingId);
    }

    @Override
    public List<Booking> getAllBookings() {
        return bookingDao.findAll();
    }

    @Override
    public List<Booking> getBookingsByUserId(int userId) {
        return bookingDao.findByUserId(userId);
    }

    @Override
    public List<Booking> getBookingsByVehicleId(int vehicleId) {
        return bookingDao.findByVehicleId(vehicleId);
    }

    @Override
    public List<Booking> getBookingsByStatus(String status) {
        return bookingDao.findByStatus(status);
    }

    @Override
    public List<Booking> getActiveBookings() {
        return bookingDao.findActiveBookings();
    }

    @Override
    public boolean isVehicleAvailable(int vehicleId, LocalDate startDate, LocalDate endDate) {
        return bookingDao.isVehicleAvailable(vehicleId, startDate, endDate);
    }

    @Override
    @Transactional
    public int createBooking(Booking booking) {
        // Set initial status
        booking.setStatus("PENDING");
        booking.setPaymentStatus("PENDING");
        
        // Save booking
        int bookingId = bookingDao.save(booking);
        
        // Update vehicle availability
        vehicleDao.updateAvailability(booking.getVehicleId(), false);
        
        return bookingId;
    }

    @Override
    public boolean updateBooking(Booking booking) {
        return bookingDao.update(booking);
    }

    @Override
    public boolean updateBookingStatus(int bookingId, String status) {
        Booking booking = bookingDao.findById(bookingId);
        if (booking != null) {
            // If booking is completed or cancelled, make vehicle available again
            if ("COMPLETED".equals(status) || "CANCELLED".equals(status)) {
                vehicleDao.updateAvailability(booking.getVehicleId(), true);
            } else if ("CONFIRMED".equals(status)) {
                vehicleDao.updateAvailability(booking.getVehicleId(), false);
            }
            
            return bookingDao.updateStatus(bookingId, status);
        }
        return false;
    }

    @Override
    public boolean updatePaymentStatus(int bookingId, String paymentStatus, String paymentMethod, String transactionId) {
        return bookingDao.updatePaymentStatus(bookingId, paymentStatus, paymentMethod, transactionId);
    }

    @Override
    @Transactional
    public boolean cancelBooking(int bookingId) {
        Booking booking = bookingDao.findById(bookingId);
        if (booking != null) {
            // Make vehicle available again
            vehicleDao.updateAvailability(booking.getVehicleId(), true);
            
            // Update booking status
            return bookingDao.updateStatus(bookingId, "CANCELLED");
        }
        return false;
    }
}