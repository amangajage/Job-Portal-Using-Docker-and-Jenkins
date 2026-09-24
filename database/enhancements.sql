USE job_portal;

CREATE TABLE IF NOT EXISTS saved_jobs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    job_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY unique_saved_job (user_id, job_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS applications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    job_id INT NOT NULL,
    status VARCHAR(30) NOT NULL DEFAULT 'Applied',
    applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY unique_application (user_id, job_id)
) ENGINE=InnoDB;
