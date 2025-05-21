package com.vehicle.rental.service;

import com.vehicle.rental.model.Video;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface VideoService {
    Video getVideoById(int videoId);
    List<Video> getAllVideos();
    List<Video> getVideosByBookingId(int bookingId);
    List<Video> getVideosByBookingIdAndType(int bookingId, String videoType);
    int uploadVideo(int bookingId, String videoType, MultipartFile videoFile, String notes);
    boolean updateVideo(Video video);
    boolean deleteVideo(int videoId);
    String getVideoFilePath(int videoId);
}