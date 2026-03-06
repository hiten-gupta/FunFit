package com.gms.dao;

import com.gms.model.Participant;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ParticipantDAO implements DAO<Participant> {

    @Override
    public void save(Participant p) {
        String sql = "INSERT INTO participant (name, phone, email, bid) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getName());
            ps.setString(2, p.getPhone());
            ps.setString(3, p.getEmail());
            ps.setInt(4, p.getBid());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void update(Participant p) {
        String sql = "UPDATE participant SET name=?, phone=?, email=?, bid=? WHERE pid=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getName());
            ps.setString(2, p.getPhone());
            ps.setString(3, p.getEmail());
            ps.setInt(4, p.getBid());
            ps.setInt(5, p.getPid());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(int pid) {
        String sql = "DELETE FROM participant WHERE pid=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, pid);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Participant get(int pid) {
        String sql = "SELECT * FROM participant WHERE pid=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, pid);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Participant(rs.getInt("pid"), rs.getString("name"),
                        rs.getString("phone"), rs.getString("email"), rs.getInt("bid"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Participant> getAll() {
        List<Participant> list = new ArrayList<>();
        String sql = "SELECT * FROM participant";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                list.add(new Participant(rs.getInt("pid"), rs.getString("name"),
                        rs.getString("phone"), rs.getString("email"), rs.getInt("bid")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Participant> getByBatch(int bid) {
        List<Participant> list = new ArrayList<>();
        String sql = "SELECT * FROM participant WHERE bid=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Participant(rs.getInt("pid"), rs.getString("name"),
                        rs.getString("phone"), rs.getString("email"), rs.getInt("bid")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
