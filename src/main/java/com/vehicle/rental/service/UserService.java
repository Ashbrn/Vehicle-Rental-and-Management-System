package com.vehicle.rental.service;

import com.vehicle.rental.model.User;
import java.util.List;

public interface UserService {
    User getUserById(int userId);
    User getUserByUsername(String username);
    User getUserByEmail(String email);
    List<User> getAllUsers();
    int registerUser(User user);
    boolean updateUser(User user);
    boolean deleteUser(int userId);
    boolean isUsernameExists(String username);
    boolean isEmailExists(String email);
    boolean isDrivingLicenseExists(String drivingLicense);
    boolean authenticateUser(String username, String password);
    boolean isAdmin(String username);
}