<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.entity.Jobs"%>
<%@ page import="com.DB.DBConnect"%>
<%@ page import="com.dao.JobDAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Manage Jobs | Job Portal</title>
    <%@include file="all_component/all_css.jsp"%>
</head>
<body>
    <c:if test="${userobj.role ne 'admin'}">
        <c:redirect url="login.jsp"></c:redirect>
    </c:if>
    <%@include file="all_component/navbar.jsp"%>

    <div class="page-header">
        <div class="container">
            <div class="section-kicker">Employer tools</div>
            <h1>Manage job postings</h1>
            <p>Edit, remove, or review the roles currently listed on the portal.</p>
        </div>
    </div>

    <main class="container section-space pt-4">
        <c:if test="${not empty succMsg}">
            <div class="alert alert-success border-0 shadow-sm" role="alert">
                <i class="fa-solid fa-circle-check me-2"></i>${succMsg}
            </div>
            <c:remove var="succMsg" />
        </c:if>

        <%
        JobDAO dao = new JobDAO(DBConnect.getconn());
        List<Jobs> list = dao.getAllJobs();
        %>

        <div class="d-flex justify-content-between align-items-center mb-3">
            <div class="small muted-text"><strong><%=list.size()%></strong> job posting(s)</div>
            <a href="add_job.jsp" class="btn btn-sm btn-jp-primary"><i class="fa-solid fa-plus me-1"></i> Post a Job</a>
        </div>

        <% if (list.isEmpty()) { %>
            <div class="empty-state">
                <i class="fa-regular fa-folder-open d-block"></i>
                <h3 class="h5" style="color:var(--jp-navy);">No jobs posted yet</h3>
                <p class="mb-3">Create your first job listing to get started.</p>
                <a href="add_job.jsp" class="btn btn-jp-primary">Post a Job</a>
            </div>
        <% } else { %>
            <div class="d-grid gap-3">
            <% for (Jobs j : list) {
                String status = j.getStatus() == null ? "" : j.getStatus();
                String desc = j.getDescription() == null ? "" : j.getDescription();
                String preview = desc.length() > 160 ? desc.substring(0, 160) + "..." : desc;
            %>
                <div class="job-card">
                    <div class="job-card-head">
                        <div>
                            <h3 class="job-title"><%=j.getTitle()%></h3>
                            <div class="job-date mt-1">Posted <%=j.getPdate()%></div>
                        </div>
                        <span class="status-badge <%= "Inactive".equalsIgnoreCase(status) ? "inactive" : "" %>"><%=status%></span>
                    </div>
                    <p class="job-description"><%=preview%></p>
                    <div class="job-meta">
                        <span class="meta-chip"><i class="fa-solid fa-location-dot"></i><%=j.getLocation()%></span>
                        <span class="meta-chip"><i class="fa-solid fa-layer-group"></i><%=j.getCategory()%></span>
                    </div>
                    <div class="job-actions">
                        <span class="small muted-text">Job ID #<%=j.getId()%></span>
                        <div class="d-flex gap-2">
                            <a href="edit_job.jsp?id=<%=j.getId()%>" class="btn btn-sm btn-jp-secondary"><i class="fa-solid fa-pen-to-square me-1"></i> Edit</a>
                            <a href="delete?id=<%=j.getId()%>" class="btn btn-sm btn-jp-danger" onclick="return confirm('Delete this job posting?');"><i class="fa-solid fa-trash me-1"></i> Delete</a>
                        </div>
                    </div>
                </div>
            <% } %>
            </div>
        <% } %>
    </main>

    <%@include file="all_component/footer.jsp"%>
</body>
</html>
