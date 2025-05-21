package com.vehicle.rental.dao;

import com.vehicle.rental.model.Vehicle;
import java.util.List;

public interface VehicleDao {
    Vehicle findById(int vehicleId);
    List<Vehicle> findAll();
    List<Vehicle> findAvailable();
    List<Vehicle> findByType(String type);
    List<Vehicle> findByBrand(String brand);
    List<Vehicle> findByPriceRange(double minPrice, double maxPrice);
    int save(Vehicle vehicle);
    boolean update(Vehicle vehicle);
    boolean updateAvailability(int vehicleId, boolean availability);
    boolean delete(int vehicleId);
    boolean isRegistrationNumberExists(String registrationNumber);
}