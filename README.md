# Online Job Portal - Enhanced UI & Features

This version keeps the original Java/JSP/Servlet/MySQL job portal workflow and adds a more polished, practical interface plus lightweight candidate features.

## Existing workflow retained
- JSP + Bootstrap frontend
- Java Servlets
- MySQL database
- Tomcat 7 Maven plugin
- Admin job posting/editing/deletion
- User registration/login/profile editing
- Location/category job search

## Added
- Professional responsive navigation and page styling
- Improved landing page, job cards, forms, job details, and footer
- User dashboard
- Save/unsave jobs
- Apply to active jobs
- Application history and status display
- Admin dashboard with user/job/application counts
- Admin application-status management
- About and Contact pages
- Automatic creation of `saved_jobs` and `applications` tables on first database connection
- Corrected job-search result field mapping

## Run locally
1. Start MySQL Server.
2. Open the project in VS Code.
3. Make sure `DBConnect.java` contains your local MySQL username/password.
4. From the folder containing `pom.xml`, run:

   `mvn clean install`

5. Start Tomcat:

   `mvn tomcat7:run`

6. Open:

   `http://localhost:8080/Job_Portal`

The first application connection automatically creates the two additional tables if they do not already exist.

## Admin login
- Email: `admin@gmail.com`
- Password: `admin@123`

For a real deployment, replace the hard-coded admin credentials and plaintext password storage with proper authentication and password hashing.
