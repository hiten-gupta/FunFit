package com.gms.dao;

import com.gms.model.Batch;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BatchDAO implements DAO<Batch> {

    @Override
    public void save(Batch batch) {
        String sql = "INSERT INTO batch (name, slot, time) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, batch.getName());
            ps.setString(2, batch.getSlot());
            ps.setString(3, batch.getTime());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void update(Batch batch) {
        String sql = "UPDATE batch SET name=?, slot=?, time=? WHERE bid=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, batch.getName());
            ps.setString(2, batch.getSlot());
            ps.setString(3, batch.getTime());
            ps.setInt(4, batch.getBid());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(int bid) {
        String sql = "DELETE FROM batch WHERE bid=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bid);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Batch get(int bid) {
        String sql = "SELECT * FROM batch WHERE bid=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bid);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Batch(rs.getInt("bid"), rs.getString("name"),
                        rs.getString("slot"), rs.getString("time"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Batch> getAll() {
        List<Batch> batches = new ArrayList<>();
        String sql = "SELECT * FROM batch";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                batches.add(new Batch(rs.getInt("bid"), rs.getString("name"),
                        rs.getString("slot"), rs.getString("time")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return batches;
    }
}
