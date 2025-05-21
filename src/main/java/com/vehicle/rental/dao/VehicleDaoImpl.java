package com.vehicle.rental.dao;

import com.vehicle.rental.model.Vehicle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

@Repository
public class VehicleDaoImpl implements VehicleDao {

    private final JdbcTemplate jdbcTemplate;
    
    @Autowired
    public VehicleDaoImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
    
    private final RowMapper<Vehicle> vehicleRowMapper = (rs, rowNum) -> {
        Vehicle vehicle = new Vehicle();
        vehicle.setVehicleId(rs.getInt("vehicle_id"));
        vehicle.setRegistrationNumber(rs.getString("registration_number"));
        vehicle.setBrand(rs.getString("brand"));
        vehicle.setModel(rs.getString("model"));
        vehicle.setType(rs.getString("type"));
        vehicle.setYear(rs.getInt("year"));
        vehicle.setColor(rs.getString("color"));
        vehicle.setSeatingCapacity(rs.getInt("seating_capacity"));
        vehicle.setFuelType(rs.getString("fuel_type"));
        
        BigDecimal mileage = rs.getBigDecimal("mileage");
        if (mileage != null) {
            vehicle.setMileage(mileage);
        }
        
        vehicle.setPricePerDay(rs.getBigDecimal("price_per_day"));
        vehicle.setAvailability(rs.getBoolean("availability"));
        vehicle.setImageUrl(rs.getString("image_url"));
        vehicle.setDescription(rs.getString("description"));
        
        Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) {
            vehicle.setCreatedAt(createdAt.toLocalDateTime());
        }
        
        Timestamp updatedAt = rs.getTimestamp("updated_at");
        if (updatedAt != null) {
            vehicle.setUpdatedAt(updatedAt.toLocalDateTime());
        }
        
        return vehicle;
    };

    @Override
    public Vehicle findById(int vehicleId) {
        try {
            String sql = "SELECT * FROM vehicles WHERE vehicle_id = ?";
            return jdbcTemplate.queryForObject(sql, vehicleRowMapper, vehicleId);
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    @Override
    public List<Vehicle> findAll() {
        String sql = "SELECT * FROM vehicles ORDER BY vehicle_id";
        return jdbcTemplate.query(sql, vehicleRowMapper);
    }

    @Override
    public List<Vehicle> findAvailable() {
        String sql = "SELECT * FROM vehicles WHERE availability = TRUE ORDER BY price_per_day";
        return jdbcTemplate.query(sql, vehicleRowMapper);
    }

    @Override
    public List<Vehicle> findByType(String type) {
        String sql = "SELECT * FROM vehicles WHERE type = ? ORDER BY price_per_day";
        return jdbcTemplate.query(sql, vehicleRowMapper, type);
    }

    @Override
    public List<Vehicle> findByBrand(String brand) {
        String sql = "SELECT * FROM vehicles WHERE brand = ? ORDER BY price_per_day";
        return jdbcTemplate.query(sql, vehicleRowMapper, brand);
    }

    @Override
    public List<Vehicle> findByPriceRange(double minPrice, double maxPrice) {
        String sql = "SELECT * FROM vehicles WHERE price_per_day BETWEEN ? AND ? ORDER BY price_per_day";
        return jdbcTemplate.query(sql, vehicleRowMapper, minPrice, maxPrice);
    }

    @Override
    public int save(Vehicle vehicle) {
        String sql = "INSERT INTO vehicles (registration_number, brand, model, type, year, color, " +
                     "seating_capacity, fuel_type, mileage, price_per_day, availability, image_url, description) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        KeyHolder keyHolder = new GeneratedKeyHolder();
        
        jdbcTemplate.update(connection -> {
            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, vehicle.getRegistrationNumber());
            ps.setString(2, vehicle.getBrand());
            ps.setString(3, vehicle.getModel());
            ps.setString(4, vehicle.getType());
            ps.setInt(5, vehicle.getYear());
            ps.setString(6, vehicle.getColor());
            ps.setInt(7, vehicle.getSeatingCapacity());
            ps.setString(8, vehicle.getFuelType());
            ps.setBigDecimal(9, vehicle.getMileage());
            ps.setBigDecimal(10, vehicle.getPricePerDay());
            ps.setBoolean(11, vehicle.isAvailability());
            ps.setString(12, vehicle.getImageUrl());
            ps.setString(13, vehicle.getDescription());
            return ps;
        }, keyHolder);
        
        return keyHolder.getKey().intValue();
    }

    @Override
    public boolean update(Vehicle vehicle) {
        String sql = "UPDATE vehicles SET registration_number = ?, brand = ?, model = ?, type = ?, " +
                     "year = ?, color = ?, seating_capacity = ?, fuel_type = ?, mileage = ?, " +
                     "price_per_day = ?, availability = ?, image_url = ?, description = ?, updated_at = ? " +
                     "WHERE vehicle_id = ?";
        
        int rowsAffected = jdbcTemplate.update(sql,
                vehicle.getRegistrationNumber(),
                vehicle.getBrand(),
                vehicle.getModel(),
                vehicle.getType(),
                vehicle.getYear(),
                vehicle.getColor(),
                vehicle.getSeatingCapacity(),
                vehicle.getFuelType(),
                vehicle.getMileage(),
                vehicle.getPricePerDay(),
                vehicle.isAvailability(),
                vehicle.getImageUrl(),
                vehicle.getDescription(),
                Timestamp.valueOf(LocalDateTime.now()),
                vehicle.getVehicleId()
        );
        
        return rowsAffected > 0;
    }

    @Override
    public boolean updateAvailability(int vehicleId, boolean availability) {
        String sql = "UPDATE vehicles SET availability = ?, updated_at = ? WHERE vehicle_id = ?";
        int rowsAffected = jdbcTemplate.update(sql, 
                availability, 
                Timestamp.valueOf(LocalDateTime.now()), 
                vehicleId
        );
        return rowsAffected > 0;
    }

    @Override
    public boolean delete(int vehicleId) {
        String sql = "DELETE FROM vehicles WHERE vehicle_id = ?";
        int rowsAffected = jdbcTemplate.update(sql, vehicleId);
        return rowsAffected > 0;
    }

    @Override
    public boolean isRegistrationNumberExists(String registrationNumber) {
        String sql = "SELECT COUNT(*) FROM vehicles WHERE registration_number = ?";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, registrationNumber);
        return count != null && count > 0;
    }
}