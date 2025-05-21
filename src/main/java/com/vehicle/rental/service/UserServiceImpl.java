package com.vehicle.rental.service;

import com.vehicle.rental.dao.UserDao;
import com.vehicle.rental.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    private final UserDao userDao;
    private final BCryptPasswordEncoder passwordEncoder;
    
    @Autowired
    public UserServiceImpl(UserDao userDao, BCryptPasswordEncoder passwordEncoder) {
        this.userDao = userDao;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public User getUserById(int userId) {
        return userDao.findById(userId);
    }

    @Override
    public User getUserByUsername(String username) {
        return userDao.findByUsername(username);
    }

    @Override
    public User getUserByEmail(String email) {
        return userDao.findByEmail(email);
    }

    @Override
    public List<User> getAllUsers() {
        return userDao.findAll();
    }

    @Override
    public int registerUser(User user) {
        // Encrypt the password before saving
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        return userDao.save(user);
    }

    @Override
    public boolean updateUser(User user) {
        return userDao.update(user);
    }

    @Override
    public boolean deleteUser(int userId) {
        return userDao.delete(userId);
    }

    @Override
    public boolean isUsernameExists(String username) {
        return userDao.isUsernameExists(username);
    }

    @Override
    public boolean isEmailExists(String email) {
        return userDao.isEmailExists(email);
    }

    @Override
    public boolean isDrivingLicenseExists(String drivingLicense) {
        return userDao.isDrivingLicenseExists(drivingLicense);
    }

    @Override
    public boolean authenticateUser(String username, String password) {
        User user = userDao.findByUsername(username);
        if (user != null) {
            return passwordEncoder.matches(password, user.getPassword());
        }
        return false;
    }

    @Override
    public boolean isAdmin(String username) {
        User user = userDao.findByUsername(username);
        return user != null && "ADMIN".equals(user.getRole());
    }
}