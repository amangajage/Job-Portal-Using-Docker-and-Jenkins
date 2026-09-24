package com.dao;

import com.entity.Jobs;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SavedJobDAO {
    private final Connection conn;

    public SavedJobDAO(Connection conn) {
        this.conn = conn;
    }

    public boolean saveJob(int userId, int jobId) {
        String sql = "INSERT IGNORE INTO saved_jobs(user_id, job_id) VALUES (?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, jobId);
            return ps.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean unsaveJob(int userId, int jobId) {
        String sql = "DELETE FROM saved_jobs WHERE user_id=? AND job_id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, jobId);
            return ps.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean isSaved(int userId, int jobId) {
        String sql = "SELECT id FROM saved_jobs WHERE user_id=? AND job_id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, jobId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Jobs> getSavedJobs(int userId) {
        List<Jobs> list = new ArrayList<Jobs>();
        String sql = "SELECT j.* FROM saved_jobs s JOIN jobs j ON s.job_id=j.id WHERE s.user_id=? ORDER BY s.created_at DESC";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Jobs j = new Jobs();
                    j.setId(rs.getInt(1));
                    j.setTitle(rs.getString(2));
                    j.setDescription(rs.getString(3));
                    j.setCategory(rs.getString(4));
                    j.setStatus(rs.getString(5));
                    j.setLocation(rs.getString(6));
                    j.setPdate(String.valueOf(rs.getTimestamp(7)));
                    list.add(j);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
