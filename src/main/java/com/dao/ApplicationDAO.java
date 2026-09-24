package com.dao;

import com.entity.Jobs;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ApplicationDAO {
    private final Connection conn;

    public ApplicationDAO(Connection conn) {
        this.conn = conn;
    }

    public boolean apply(int userId, int jobId) {
        String sql = "INSERT IGNORE INTO applications(user_id, job_id, status) VALUES (?, ?, 'Applied')";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, jobId);
            return ps.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean hasApplied(int userId, int jobId) {
        String sql = "SELECT id FROM applications WHERE user_id=? AND job_id=?";
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

    public List<ApplicationRecord> getApplicationsForUser(int userId) {
        List<ApplicationRecord> list = new ArrayList<ApplicationRecord>();
        String sql = "SELECT a.id, a.job_id, j.title, j.location, j.category, a.status, a.applied_at "
                   + "FROM applications a JOIN jobs j ON a.job_id=j.id WHERE a.user_id=? ORDER BY a.applied_at DESC";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ApplicationRecord r = new ApplicationRecord();
                    r.id = rs.getInt("id");
                    r.jobId = rs.getInt("job_id");
                    r.jobTitle = rs.getString("title");
                    r.location = rs.getString("location");
                    r.category = rs.getString("category");
                    r.status = rs.getString("status");
                    r.appliedAt = String.valueOf(rs.getTimestamp("applied_at"));
                    list.add(r);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<ApplicationRecord> getAllApplications() {
        List<ApplicationRecord> list = new ArrayList<ApplicationRecord>();
        String sql = "SELECT a.id, a.job_id, a.user_id, u.name, u.email, j.title, a.status, a.applied_at "
                   + "FROM applications a JOIN `user` u ON a.user_id=u.id JOIN jobs j ON a.job_id=j.id "
                   + "ORDER BY a.applied_at DESC";
        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                ApplicationRecord r = new ApplicationRecord();
                r.id = rs.getInt("id");
                r.jobId = rs.getInt("job_id");
                r.userId = rs.getInt("user_id");
                r.userName = rs.getString("name");
                r.userEmail = rs.getString("email");
                r.jobTitle = rs.getString("title");
                r.status = rs.getString("status");
                r.appliedAt = String.valueOf(rs.getTimestamp("applied_at"));
                list.add(r);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateStatus(int applicationId, String status) {
        String sql = "UPDATE applications SET status=? WHERE id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, applicationId);
            return ps.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public int countApplications() {
        String sql = "SELECT COUNT(*) FROM applications";
        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    public static class ApplicationRecord {
        public int id;
        public int userId;
        public int jobId;
        public String userName;
        public String userEmail;
        public String jobTitle;
        public String location;
        public String category;
        public String status;
        public String appliedAt;
    }
}
