package com.vehicle.rental.dao;

import com.vehicle.rental.model.User;
import java.util.List;

public interface UserDao {
    User findById(int userId);
    User findByUsername(String username);
    User findByEmail(String email);
    List<User> findAll();
    int save(User user);
    boolean update(User user);
    boolean delete(int userId);
    boolean isUsernameExists(String username);
    boolean isEmailExists(String email);
    boolean isDrivingLicenseExists(String drivingLicense);
}