<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<%@ page import="com.entity.Jobs"%>
<%@ page import="com.DB.DBConnect"%>
<%@ page import="com.dao.JobDAO"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Edit Job | Job Portal</title>
    <%@include file="all_component/all_css.jsp"%>
</head>
<body>
    <c:if test="${userobj.role ne 'admin'}">
        <c:redirect url="login.jsp"></c:redirect>
    </c:if>
    <%@include file="all_component/navbar.jsp"%>

    <%
    int id = Integer.parseInt(request.getParameter("id"));
    JobDAO dao = new JobDAO(DBConnect.getconn());
    Jobs j = dao.getJobById(id);
    %>

    <main class="container section-space py-5">
        <div class="row justify-content-center">
            <div class="col-xl-9">
                <% if (j == null) { %>
                    <div class="empty-state">
                        <i class="fa-regular fa-circle-xmark d-block"></i>
                        <h3 class="h5" style="color:var(--jp-navy);">Job not found</h3>
                        <p class="mb-3">The job you are trying to edit no longer exists.</p>
                        <a href="view_job.jsp" class="btn btn-jp-primary">Back to Manage Jobs</a>
                    </div>
                <% } else { %>
                    <div class="form-card">
                        <div class="section-kicker">Employer tools</div>
                        <h1 class="form-card-title mt-2">Edit job posting</h1>
                        <p class="form-card-subtitle">Update the job information and save your changes.</p>

                        <form action="update" method="post">
                            <input type="hidden" value="<%=j.getId()%>" name="id">

                            <div class="mb-3">
                                <label class="form-label" for="jobTitle">Job title</label>
                                <input type="text" class="form-control" id="jobTitle" name="title" value="<%=j.getTitle()%>" required>
                            </div>

                            <div class="row g-3">
                                <div class="col-md-4">
                                    <label class="form-label" for="jobLocation">Location</label>
                                    <select name="location" class="form-select" id="jobLocation" required>
                                        <option value="<%=j.getLocation()%>" selected><%=j.getLocation()%></option>
                                        <option value="Bangalore">Bangalore</option>
                                        <option value="Baroda">Baroda</option>
                                        <option value="Chandigarh">Chandigarh</option>
                                        <option value="Coimbatore">Coimbatore</option>
                                        <option value="Chennai">Chennai</option>
                                        <option value="Delhi-NCR">Delhi</option>
                                        <option value="Dhule">Dhule</option>
                                        <option value="Hydrabad">Hydrabad</option>
                                        <option value="Kolkata">Kolkata</option>
                                        <option value="Mumbai">Mumbai</option>
                                        <option value="Pune">Pune</option>
                                        <option value="Shirpur">Shirpur</option>
                                    </select>
                                </div>

                                <div class="col-md-4">
                                    <label class="form-label" for="jobCategory">Category</label>
                                    <select name="category" class="form-select" id="jobCategory" required>
                                        <option value="<%=j.getCategory()%>" selected><%=j.getCategory()%></option>
                                        <option value="IT">IT</option>
                                        <option value="Devloper">Developer</option>
                                        <option value="Banking">Banking</option>
                                        <option value="Engineer">Engineer</option>
                                        <option value="Teacher">Teacher</option>
                                    </select>
                                </div>

                                <div class="col-md-4">
                                    <label class="form-label" for="jobStatus">Status</label>
                                    <select class="form-select" id="jobStatus" name="status" required>
                                        <option value="<%=j.getStatus()%>" selected><%=j.getStatus()%></option>
                                        <option value="Active">Active</option>
                                        <option value="Inactive">Inactive</option>
                                    </select>
                                </div>
                            </div>

                            <div class="mt-3">
                                <label class="form-label" for="jobDescription">Description</label>
                                <textarea required rows="7" name="desc" id="jobDescription" class="form-control"><%=j.getDescription()%></textarea>
                            </div>

                            <div class="form-actions">
                                <a href="view_job.jsp" class="btn btn-jp-secondary">Cancel</a>
                                <button type="submit" class="btn btn-jp-primary px-4"><i class="fa-solid fa-floppy-disk me-1"></i> Save Changes</button>
                            </div>
                        </form>
                    </div>
                <% } %>
            </div>
        </div>
    </main>

    <%@include file="all_component/footer.jsp"%>
</body>
</html>
