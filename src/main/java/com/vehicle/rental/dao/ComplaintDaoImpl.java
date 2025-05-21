package com.vehicle.rental.dao;

import com.vehicle.rental.model.Booking;
import com.vehicle.rental.model.Complaint;
import com.vehicle.rental.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

@Repository
public class ComplaintDaoImpl implements ComplaintDao {

    private final JdbcTemplate jdbcTemplate;
    private final UserDao userDao;
    private final BookingDao bookingDao;
    
    @Autowired
    public ComplaintDaoImpl(JdbcTemplate jdbcTemplate, UserDao userDao, BookingDao bookingDao) {
        this.jdbcTemplate = jdbcTemplate;
        this.userDao = userDao;
        this.bookingDao = bookingDao;
    }
    
    private RowMapper<Complaint> getComplaintRowMapper() {
        return (rs, rowNum) -> {
            Complaint complaint = new Complaint();
            complaint.setComplaintId(rs.getInt("complaint_id"));
            complaint.setUserId(rs.getInt("user_id"));
            
            // Handle nullable booking_id
            int bookingId = rs.getInt("booking_id");
            if (!rs.wasNull()) {
                complaint.setBookingId(bookingId);
            }
            
            complaint.setSubject(rs.getString("subject"));
            complaint.setDescription(rs.getString("description"));
            complaint.setStatus(rs.getString("status"));
            complaint.setAdminResponse(rs.getString("admin_response"));
            
            Timestamp createdAt = rs.getTimestamp("created_at");
            if (createdAt != null) {
                complaint.setCreatedAt(createdAt.toLocalDateTime());
            }
            
            Timestamp updatedAt = rs.getTimestamp("updated_at");
            if (updatedAt != null) {
                complaint.setUpdatedAt(updatedAt.toLocalDateTime());
            }
            
            // Load user details
            User user = userDao.findById(complaint.getUserId());
            complaint.setUser(user);
            
            // Load booking details if available
            if (complaint.getBookingId() != null) {
                Booking booking = bookingDao.findById(complaint.getBookingId());
                complaint.setBooking(booking);
            }
            
            return complaint;
        };
    }

    @Override
    public Complaint findById(int complaintId) {
        try {
            String sql = "SELECT * FROM complaints WHERE complaint_id = ?";
            return jdbcTemplate.queryForObject(sql, getComplaintRowMapper(), complaintId);
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    @Override
    public List<Complaint> findAll() {
        String sql = "SELECT * FROM complaints ORDER BY complaint_id DESC";
        return jdbcTemplate.query(sql, getComplaintRowMapper());
    }

    @Override
    public List<Complaint> findByUserId(int userId) {
        String sql = "SELECT * FROM complaints WHERE user_id = ? ORDER BY complaint_id DESC";
        return jdbcTemplate.query(sql, getComplaintRowMapper(), userId);
    }

    @Override
    public List<Complaint> findByBookingId(int bookingId) {
        String sql = "SELECT * FROM complaints WHERE booking_id = ? ORDER BY complaint_id DESC";
        return jdbcTemplate.query(sql, getComplaintRowMapper(), bookingId);
    }

    @Override
    public List<Complaint> findByStatus(String status) {
        String sql = "SELECT * FROM complaints WHERE status = ? ORDER BY complaint_id DESC";
        return jdbcTemplate.query(sql, getComplaintRowMapper(), status);
    }

    @Override
    public int save(Complaint complaint) {
        String sql = "INSERT INTO complaints (user_id, booking_id, subject, description, status) " +
                     "VALUES (?, ?, ?, ?, ?)";
        
        KeyHolder keyHolder = new GeneratedKeyHolder();
        
        jdbcTemplate.update(connection -> {
            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, complaint.getUserId());
            
            if (complaint.getBookingId() != null) {
                ps.setInt(2, complaint.getBookingId());
            } else {
                ps.setNull(2, java.sql.Types.INTEGER);
            }
            
            ps.setString(3, complaint.getSubject());
            ps.setString(4, complaint.getDescription());
            ps.setString(5, complaint.getStatus());
            return ps;
        }, keyHolder);
        
        return keyHolder.getKey().intValue();
    }

    @Override
    public boolean update(Complaint complaint) {
        String sql = "UPDATE complaints SET user_id = ?, booking_id = ?, subject = ?, description = ?, " +
                     "status = ?, admin_response = ?, updated_at = ? WHERE complaint_id = ?";
        
        int rowsAffected = jdbcTemplate.update(connection -> {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, complaint.getUserId());
            
            if (complaint.getBookingId() != null) {
                ps.setInt(2, complaint.getBookingId());
            } else {
                ps.setNull(2, java.sql.Types.INTEGER);
            }
            
            ps.setString(3, complaint.getSubject());
            ps.setString(4, complaint.getDescription());
            ps.setString(5, complaint.getStatus());
            ps.setString(6, complaint.getAdminResponse());
            ps.setTimestamp(7, Timestamp.valueOf(LocalDateTime.now()));
            ps.setInt(8, complaint.getComplaintId());
            return ps;
        });
        
        return rowsAffected > 0;
    }

    @Override
    public boolean updateStatus(int complaintId, String status) {
        String sql = "UPDATE complaints SET status = ?, updated_at = ? WHERE complaint_id = ?";
        int rowsAffected = jdbcTemplate.update(sql, 
                status, 
                Timestamp.valueOf(LocalDateTime.now()), 
                complaintId
        );
        return rowsAffected > 0;
    }

    @Override
    public boolean updateAdminResponse(int complaintId, String adminResponse, String status) {
        String sql = "UPDATE complaints SET admin_response = ?, status = ?, updated_at = ? WHERE complaint_id = ?";
        int rowsAffected = jdbcTemplate.update(sql, 
                adminResponse, 
                status, 
                Timestamp.valueOf(LocalDateTime.now()), 
                complaintId
        );
        return rowsAffected > 0;
    }

    @Override
    public boolean delete(int complaintId) {
        String sql = "DELETE FROM complaints WHERE complaint_id = ?";
        int rowsAffected = jdbcTemplate.update(sql, complaintId);
        return rowsAffected > 0;
    }
}