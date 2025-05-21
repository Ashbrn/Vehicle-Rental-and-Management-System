package com.vehicle.rental.service;

import com.vehicle.rental.model.Vehicle;
import java.util.List;

public interface VehicleService {
    Vehicle getVehicleById(int vehicleId);
    List<Vehicle> getAllVehicles();
    List<Vehicle> getAvailableVehicles();
    List<Vehicle> getVehiclesByType(String type);
    List<Vehicle> getVehiclesByBrand(String brand);
    List<Vehicle> getVehiclesByPriceRange(double minPrice, double maxPrice);
    int addVehicle(Vehicle vehicle);
    boolean updateVehicle(Vehicle vehicle);
    boolean updateVehicleAvailability(int vehicleId, boolean availability);
    boolean deleteVehicle(int vehicleId);
    boolean isRegistrationNumberExists(String registrationNumber);
    List<String> getAllVehicleTypes();
    List<String> getAllVehicleBrands();
}