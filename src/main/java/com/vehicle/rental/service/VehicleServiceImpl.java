package com.vehicle.rental.service;

import com.vehicle.rental.dao.VehicleDao;
import com.vehicle.rental.model.Vehicle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service
public class VehicleServiceImpl implements VehicleService {

    private final VehicleDao vehicleDao;
    
    @Autowired
    public VehicleServiceImpl(VehicleDao vehicleDao) {
        this.vehicleDao = vehicleDao;
    }

    @Override
    public Vehicle getVehicleById(int vehicleId) {
        return vehicleDao.findById(vehicleId);
    }

    @Override
    public List<Vehicle> getAllVehicles() {
        return vehicleDao.findAll();
    }

    @Override
    public List<Vehicle> getAvailableVehicles() {
        return vehicleDao.findAvailable();
    }

    @Override
    public List<Vehicle> getVehiclesByType(String type) {
        return vehicleDao.findByType(type);
    }

    @Override
    public List<Vehicle> getVehiclesByBrand(String brand) {
        return vehicleDao.findByBrand(brand);
    }

    @Override
    public List<Vehicle> getVehiclesByPriceRange(double minPrice, double maxPrice) {
        return vehicleDao.findByPriceRange(minPrice, maxPrice);
    }

    @Override
    public int addVehicle(Vehicle vehicle) {
        return vehicleDao.save(vehicle);
    }

    @Override
    public boolean updateVehicle(Vehicle vehicle) {
        return vehicleDao.update(vehicle);
    }

    @Override
    public boolean updateVehicleAvailability(int vehicleId, boolean availability) {
        return vehicleDao.updateAvailability(vehicleId, availability);
    }

    @Override
    public boolean deleteVehicle(int vehicleId) {
        return vehicleDao.delete(vehicleId);
    }

    @Override
    public boolean isRegistrationNumberExists(String registrationNumber) {
        return vehicleDao.isRegistrationNumberExists(registrationNumber);
    }

    @Override
    public List<String> getAllVehicleTypes() {
        List<Vehicle> vehicles = vehicleDao.findAll();
        Set<String> types = new HashSet<>();
        
        for (Vehicle vehicle : vehicles) {
            types.add(vehicle.getType());
        }
        
        return new ArrayList<>(types);
    }

    @Override
    public List<String> getAllVehicleBrands() {
        List<Vehicle> vehicles = vehicleDao.findAll();
        Set<String> brands = new HashSet<>();
        
        for (Vehicle vehicle : vehicles) {
            brands.add(vehicle.getBrand());
        }
        
        return new ArrayList<>(brands);
    }
}