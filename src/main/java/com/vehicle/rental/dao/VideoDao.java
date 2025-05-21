package com.vehicle.rental.dao;

import com.vehicle.rental.model.Video;
import java.util.List;

public interface VideoDao {
    Video findById(int videoId);
    List<Video> findAll();
    List<Video> findByBookingId(int bookingId);
    List<Video> findByBookingIdAndType(int bookingId, String videoType);
    int save(Video video);
    boolean update(Video video);
    boolean delete(int videoId);
}