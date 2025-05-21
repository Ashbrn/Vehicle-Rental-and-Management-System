package com.vehicle.rental.dao;

import com.vehicle.rental.model.Booking;
import com.vehicle.rental.model.Video;
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
public class VideoDaoImpl implements VideoDao {

    private final JdbcTemplate jdbcTemplate;
    private final BookingDao bookingDao;
    
    @Autowired
    public VideoDaoImpl(JdbcTemplate jdbcTemplate, BookingDao bookingDao) {
        this.jdbcTemplate = jdbcTemplate;
        this.bookingDao = bookingDao;
    }
    
    private RowMapper<Video> getVideoRowMapper() {
        return (rs, rowNum) -> {
            Video video = new Video();
            video.setVideoId(rs.getInt("video_id"));
            video.setBookingId(rs.getInt("booking_id"));
            video.setVideoType(rs.getString("video_type"));
            video.setVideoUrl(rs.getString("video_url"));
            
            Timestamp uploadTime = rs.getTimestamp("upload_time");
            if (uploadTime != null) {
                video.setUploadTime(uploadTime.toLocalDateTime());
            }
            
            video.setNotes(rs.getString("notes"));
            
            // Load booking details
            Booking booking = bookingDao.findById(video.getBookingId());
            video.setBooking(booking);
            
            return video;
        };
    }

    @Override
    public Video findById(int videoId) {
        try {
            String sql = "SELECT * FROM videos WHERE video_id = ?";
            return jdbcTemplate.queryForObject(sql, getVideoRowMapper(), videoId);
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    @Override
    public List<Video> findAll() {
        String sql = "SELECT * FROM videos ORDER BY video_id DESC";
        return jdbcTemplate.query(sql, getVideoRowMapper());
    }

    @Override
    public List<Video> findByBookingId(int bookingId) {
        String sql = "SELECT * FROM videos WHERE booking_id = ? ORDER BY video_id";
        return jdbcTemplate.query(sql, getVideoRowMapper(), bookingId);
    }

    @Override
    public List<Video> findByBookingIdAndType(int bookingId, String videoType) {
        String sql = "SELECT * FROM videos WHERE booking_id = ? AND video_type = ? ORDER BY video_id";
        return jdbcTemplate.query(sql, getVideoRowMapper(), bookingId, videoType);
    }

    @Override
    public int save(Video video) {
        String sql = "INSERT INTO videos (booking_id, video_type, video_url, notes) VALUES (?, ?, ?, ?)";
        
        KeyHolder keyHolder = new GeneratedKeyHolder();
        
        jdbcTemplate.update(connection -> {
            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, video.getBookingId());
            ps.setString(2, video.getVideoType());
            ps.setString(3, video.getVideoUrl());
            ps.setString(4, video.getNotes());
            return ps;
        }, keyHolder);
        
        return keyHolder.getKey().intValue();
    }

    @Override
    public boolean update(Video video) {
        String sql = "UPDATE videos SET booking_id = ?, video_type = ?, video_url = ?, notes = ? " +
                     "WHERE video_id = ?";
        
        int rowsAffected = jdbcTemplate.update(sql,
                video.getBookingId(),
                video.getVideoType(),
                video.getVideoUrl(),
                video.getNotes(),
                video.getVideoId()
        );
        
        return rowsAffected > 0;
    }

    @Override
    public boolean delete(int videoId) {
        String sql = "DELETE FROM videos WHERE video_id = ?";
        int rowsAffected = jdbcTemplate.update(sql, videoId);
        return rowsAffected > 0;
    }
}