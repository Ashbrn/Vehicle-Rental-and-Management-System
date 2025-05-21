package com.vehicle.rental.service;

import com.vehicle.rental.dao.VideoDao;
import com.vehicle.rental.model.Video;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

@Service
public class VideoServiceImpl implements VideoService {

    private final VideoDao videoDao;
    private final String uploadDir = "src/main/webapp/uploads/videos/";
    
    @Autowired
    public VideoServiceImpl(VideoDao videoDao) {
        this.videoDao = videoDao;
        
        // Create upload directory if it doesn't exist
        File directory = new File(uploadDir);
        if (!directory.exists()) {
            directory.mkdirs();
        }
    }

    @Override
    public Video getVideoById(int videoId) {
        return videoDao.findById(videoId);
    }

    @Override
    public List<Video> getAllVideos() {
        return videoDao.findAll();
    }

    @Override
    public List<Video> getVideosByBookingId(int bookingId) {
        return videoDao.findByBookingId(bookingId);
    }

    @Override
    public List<Video> getVideosByBookingIdAndType(int bookingId, String videoType) {
        return videoDao.findByBookingIdAndType(bookingId, videoType);
    }

    @Override
    public int uploadVideo(int bookingId, String videoType, MultipartFile videoFile, String notes) {
        try {
            // Generate unique filename
            String originalFilename = videoFile.getOriginalFilename();
            String fileExtension = "";
            if (originalFilename != null && originalFilename.contains(".")) {
                fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
            }
            String newFilename = UUID.randomUUID().toString() + fileExtension;
            
            // Save file to disk
            Path filePath = Paths.get(uploadDir + newFilename);
            Files.write(filePath, videoFile.getBytes());
            
            // Create video record in database
            Video video = new Video();
            video.setBookingId(bookingId);
            video.setVideoType(videoType);
            video.setVideoUrl("/uploads/videos/" + newFilename);
            video.setNotes(notes);
            
            return videoDao.save(video);
        } catch (IOException e) {
            e.printStackTrace();
            return -1;
        }
    }

    @Override
    public boolean updateVideo(Video video) {
        return videoDao.update(video);
    }

    @Override
    public boolean deleteVideo(int videoId) {
        Video video = videoDao.findById(videoId);
        if (video != null) {
            // Delete file from disk
            String filePath = video.getVideoUrl().replace("/uploads/videos/", uploadDir);
            File file = new File(filePath);
            if (file.exists()) {
                file.delete();
            }
            
            // Delete record from database
            return videoDao.delete(videoId);
        }
        return false;
    }

    @Override
    public String getVideoFilePath(int videoId) {
        Video video = videoDao.findById(videoId);
        if (video != null) {
            return video.getVideoUrl();
        }
        return null;
    }
}