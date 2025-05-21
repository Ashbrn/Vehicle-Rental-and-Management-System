package com.vehicle.rental.dao;

import com.vehicle.rental.model.Booking;
import com.vehicle.rental.model.User;
import com.vehicle.rental.model.Vehicle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Repository
public class BookingDaoImpl implements BookingDao {

    private final JdbcTemplate jdbcTemplate;
    private final UserDao userDao;
    private final VehicleDao vehicleDao;
    
    @Autowired
    public BookingDaoImpl(JdbcTemplate jdbcTemplate, UserDao userDao, VehicleDao vehicleDao) {
        this.jdbcTemplate = jdbcTemplate;
        this.userDao = userDao;
        this.vehicleDao = vehicleDao;
    }
    
    private RowMapper<Booking> getBookingRowMapper() {
        return (rs, rowNum) -> {
            Booking booking = new Booking();
            booking.setBookingId(rs.getInt("booking_id"));
            booking.setUserId(rs.getInt("user_id"));
            booking.setVehicleId(rs.getInt("vehicle_id"));
            
            Date startDate = rs.getDate("start_date");
            if (startDate != null) {
                booking.setStartDate(startDate.toLocalDate());
            }
            
            Date endDate = rs.getDate("end_date");
            if (endDate != null) {
                booking.setEndDate(endDate.toLocalDate());
            }
            
            booking.setTotalAmount(rs.getBigDecimal("total_amount"));
            booking.setStatus(rs.getString("status"));
            booking.setPaymentStatus(rs.getString("payment_status"));
            booking.setPaymentMethod(rs.getString("payment_method"));
            booking.setTransactionId(rs.getString("transaction_id"));
            
            Timestamp createdAt = rs.getTimestamp("created_at");
            if (createdAt != null) {
                booking.setCreatedAt(createdAt.toLocalDateTime());
            }
            
            Timestamp updatedAt = rs.getTimestamp("updated_at");
            if (updatedAt != null) {
                booking.setUpdatedAt(updatedAt.toLocalDateTime());
            }
            
            // Load user and vehicle details
            User user = userDao.findById(booking.getUserId());
            Vehicle vehicle = vehicleDao.findById(booking.getVehicleId());
            booking.setUser(user);
            booking.setVehicle(vehicle);
            
            return booking;
        };
    }

    @Override
    public Booking findById(int bookingId) {
        try {
            String sql = "SELECT * FROM bookings WHERE booking_id = ?";
            return jdbcTemplate.queryForObject(sql, getBookingRowMapper(), bookingId);
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    @Override
    public List<Booking> findAll() {
        String sql = "SELECT * FROM bookings ORDER BY booking_id DESC";
        return jdbcTemplate.query(sql, getBookingRowMapper());
    }

    @Override
    public List<Booking> findByUserId(int userId) {
        String sql = "SELECT * FROM bookings WHERE user_id = ? ORDER BY booking_id DESC";
        return jdbcTemplate.query(sql, getBookingRowMapper(), userId);
    }

    @Override
    public List<Booking> findByVehicleId(int vehicleId) {
        String sql = "SELECT * FROM bookings WHERE vehicle_id = ? ORDER BY booking_id DESC";
        return jdbcTemplate.query(sql, getBookingRowMapper(), vehicleId);
    }

    @Override
    public List<Booking> findByStatus(String status) {
        String sql = "SELECT * FROM bookings WHERE status = ? ORDER BY booking_id DESC";
        return jdbcTemplate.query(sql, getBookingRowMapper(), status);
    }

    @Override
    public List<Booking> findActiveBookings() {
        String sql = "SELECT * FROM bookings WHERE status IN ('PENDING', 'CONFIRMED') AND end_date >= CURRENT_DATE ORDER BY booking_id DESC";
        return jdbcTemplate.query(sql, getBookingRowMapper());
    }

    @Override
    public boolean isVehicleAvailable(int vehicleId, LocalDate startDate, LocalDate endDate) {
        String sql = "SELECT COUNT(*) FROM bookings " +
                     "WHERE vehicle_id = ? AND status IN ('PENDING', 'CONFIRMED') " +
                     "AND ((start_date BETWEEN ? AND ?) OR (end_date BETWEEN ? AND ?) " +
                     "OR (start_date <= ? AND end_date >= ?))";
        
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, 
                vehicleId, 
                startDate, endDate, 
                startDate, endDate,
                startDate, endDate
        );
        
        return count != null && count == 0;
    }

    @Override
    public int save(Booking booking) {
        String sql = "INSERT INTO bookings (user_id, vehicle_id, start_date, end_date, total_amount, status, payment_status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        System.out.println("Saving booking with user_id: " + booking.getUserId());
        
        KeyHolder keyHolder = new GeneratedKeyHolder();
        
        jdbcTemplate.update(connection -> {
            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, booking.getUserId());
            ps.setInt(2, booking.getVehicleId());
            ps.setDate(3, Date.valueOf(booking.getStartDate()));
            ps.setDate(4, Date.valueOf(booking.getEndDate()));
            ps.setBigDecimal(5, booking.getTotalAmount());
            ps.setString(6, booking.getStatus());
            ps.setString(7, booking.getPaymentStatus());
            return ps;
        }, keyHolder);
        
        return keyHolder.getKey().intValue();
    }

    @Override
    public boolean update(Booking booking) {
        String sql = "UPDATE bookings SET user_id = ?, vehicle_id = ?, start_date = ?, end_date = ?, " +
                     "total_amount = ?, status = ?, payment_status = ?, payment_method = ?, " +
                     "transaction_id = ?, updated_at = ? WHERE booking_id = ?";
        
        int rowsAffected = jdbcTemplate.update(sql,
                booking.getUserId(),
                booking.getVehicleId(),
                booking.getStartDate(),
                booking.getEndDate(),
                booking.getTotalAmount(),
                booking.getStatus(),
                booking.getPaymentStatus(),
                booking.getPaymentMethod(),
                booking.getTransactionId(),
                Timestamp.valueOf(LocalDateTime.now()),
                booking.getBookingId()
        );
        
        return rowsAffected > 0;
    }

    @Override
    public boolean updateStatus(int bookingId, String status) {
        String sql = "UPDATE bookings SET status = ?, updated_at = ? WHERE booking_id = ?";
        int rowsAffected = jdbcTemplate.update(sql, 
                status, 
                Timestamp.valueOf(LocalDateTime.now()), 
                bookingId
        );
        return rowsAffected > 0;
    }

    @Override
    public boolean updatePaymentStatus(int bookingId, String paymentStatus, String paymentMethod, String transactionId) {
        String sql = "UPDATE bookings SET payment_status = ?, payment_method = ?, transaction_id = ?, updated_at = ? " +
                     "WHERE booking_id = ?";
        int rowsAffected = jdbcTemplate.update(sql, 
                paymentStatus, 
                paymentMethod, 
                transactionId, 
                Timestamp.valueOf(LocalDateTime.now()), 
                bookingId
        );
        return rowsAffected > 0;
    }

    @Override
    public boolean delete(int bookingId) {
        String sql = "DELETE FROM bookings WHERE booking_id = ?";
        int rowsAffected = jdbcTemplate.update(sql, bookingId);
        return rowsAffected > 0;
    }
}