package com.DB;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnect {
    private static Connection Conn;
    private static boolean extraTablesReady = false;

    public static synchronized Connection getconn() {
        try {
            if (Conn == null || Conn.isClosed()) {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Conn = DriverManager.getConnection(
                    "jdbc:mysql://job-portal-mysql:3306/job_portal?autoReconnect=true&useSSL=false&allowPublicKeyRetrieval=true",
                    "root", System.getenv("MYSQL_ROOT_PASSWORD"));
            }
            if (!extraTablesReady) {
                initializePortalTables();
                extraTablesReady = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return Conn;
    }

    /* The first connection also creates the two small tables used by the
       dashboard. Existing user/jobs tables are left untouched. */
    private static void initializePortalTables() {
        try (java.sql.Statement st = Conn.createStatement()) {
            st.executeUpdate("CREATE TABLE IF NOT EXISTS saved_jobs ("
                    + "id INT AUTO_INCREMENT PRIMARY KEY, "
                    + "user_id INT NOT NULL, "
                    + "job_id INT NOT NULL, "
                    + "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, "
                    + "UNIQUE KEY unique_saved_job (user_id, job_id)"
                    + ") ENGINE=InnoDB");

            st.executeUpdate("CREATE TABLE IF NOT EXISTS applications ("
                    + "id INT AUTO_INCREMENT PRIMARY KEY, "
                    + "user_id INT NOT NULL, "
                    + "job_id INT NOT NULL, "
                    + "status VARCHAR(30) NOT NULL DEFAULT 'Applied', "
                    + "applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, "
                    + "UNIQUE KEY unique_application (user_id, job_id)"
                    + ") ENGINE=InnoDB");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
