<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="com.entity.Jobs"%>
<%@page import="com.DB.DBConnect"%>
<%@page import="com.dao.JobDAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Job Portal live | Find Your Next Opportunity</title>
    <%@include file="all_component/all_css.jsp"%>
</head>
<body>
<%@include file="all_component/navbar.jsp"%>
<main class="page-content">
    <section class="jp-hero">
        <div class="container"><div class="jp-hero-card">
            <div class="section-kicker">Online Job Portal</div>
            <h1>Find work that fits your Next Move.</h1>
            <p>Search available roles by location and category, review job details, save interesting openings, and keep track of your applications.</p>
            <div class="hero-actions">
                <c:choose>
                    <c:when test="${userobj.role eq 'user'}"><a href="home.jsp" class="btn btn-jp-primary px-4 py-2">Browse Jobs</a></c:when>
                    <c:when test="${userobj.role eq 'admin'}"><a href="admin.jsp" class="btn btn-jp-primary px-4 py-2">Open Dashboard</a></c:when>
                    <c:otherwise><a href="login.jsp" class="btn btn-jp-primary px-4 py-2">Sign In</a><a href="signup.jsp" class="btn btn-jp-secondary px-4 py-2">Create Account</a></c:otherwise>
                </c:choose>
            </div>
        </div></div>
    </section>

    <section class="stats-strip"><div class="container"><div class="row g-3">
        <div class="col-md-4"><div class="stat-card"><div class="stat-value"><i class="fa-solid fa-magnifying-glass me-2"></i>Search</div><div class="stat-label">Filter openings by location and category.</div></div></div>
        <div class="col-md-4"><div class="stat-card"><div class="stat-value"><i class="fa-solid fa-bookmark me-2"></i>Save</div><div class="stat-label">Keep interesting roles in one place.</div></div></div>
        <div class="col-md-4"><div class="stat-card"><div class="stat-value"><i class="fa-solid fa-list-check me-2"></i>Track</div><div class="stat-label">Follow your applications from your dashboard.</div></div></div>
    </div></div></section>

    <section class="section-space"><div class="container">
        <div class="row mb-4"><div class="col-lg-8"><div class="section-kicker">Browse by field</div><h2 class="section-title mt-2">Explore common job categories.</h2><p class="muted-text mb-0">Choose a field to start your search. The existing portal categories are kept intact.</p></div></div>
        <div class="row g-3">
            <div class="col-6 col-lg"><a class="category-card" href="${empty userobj ? 'login.jsp' : 'more_view.jsp?loc=lo&cat=IT'}"><div class="category-icon"><i class="fa-solid fa-laptop-code"></i></div><h3>IT</h3><p>View openings</p></a></div>
            <div class="col-6 col-lg"><a class="category-card" href="${empty userobj ? 'login.jsp' : 'more_view.jsp?loc=lo&cat=Devloper'}"><div class="category-icon"><i class="fa-solid fa-code"></i></div><h3>Developer</h3><p>View openings</p></a></div>
            <div class="col-6 col-lg"><a class="category-card" href="${empty userobj ? 'login.jsp' : 'more_view.jsp?loc=lo&cat=Banking'}"><div class="category-icon"><i class="fa-solid fa-building-columns"></i></div><h3>Banking</h3><p>View openings</p></a></div>
            <div class="col-6 col-lg"><a class="category-card" href="${empty userobj ? 'login.jsp' : 'more_view.jsp?loc=lo&cat=Engineer'}"><div class="category-icon"><i class="fa-solid fa-gears"></i></div><h3>Engineer</h3><p>View openings</p></a></div>
            <div class="col-6 col-lg"><a class="category-card" href="${empty userobj ? 'login.jsp' : 'more_view.jsp?loc=lo&cat=Teacher'}"><div class="category-icon"><i class="fa-solid fa-chalkboard-user"></i></div><h3>Teacher</h3><p>View openings</p></a></div>
        </div>
    </div></section>

    <section class="section-space pt-0"><div class="container">
        <div class="row mb-4 align-items-end"><div class="col"><div class="section-kicker">Latest openings</div><h2 class="section-title mt-2 mb-0">Recently posted jobs</h2></div><div class="col-auto"><c:if test="${userobj.role eq 'user'}"><a href="home.jsp" class="btn btn-jp-secondary btn-sm">View all jobs <i class="fa-solid fa-arrow-right ms-1"></i></a></c:if></div></div>
        <%
            List<Jobs> landingJobs = new JobDAO(DBConnect.getconn()).getAllJobs();
            int shown = 0;
        %>
        <div class="row g-3">
        <% for (Jobs j : landingJobs) { if (shown++ >= 3) break; String d=j.getDescription()==null?"":j.getDescription(); String p=d.length()>110?d.substring(0,110)+"...":d; String s=j.getStatus()==null?"":j.getStatus(); %>
            <div class="col-lg-4"><div class="job-card h-100">
                <div class="job-card-head"><div><h3 class="job-title"><%=j.getTitle()%></h3><div class="job-date mt-1">Posted <%=j.getPdate()%></div></div><span class="status-badge <%= "Inactive".equalsIgnoreCase(s)?"inactive":"" %>"><%=s%></span></div>
                <p class="job-description"><%=p%></p><div class="job-meta"><span class="meta-chip"><i class="fa-solid fa-location-dot"></i><%=j.getLocation()%></span><span class="meta-chip"><i class="fa-solid fa-layer-group"></i><%=j.getCategory()%></span></div>
                <div class="job-actions"><span class="small muted-text">Job #<%=j.getId()%></span><c:choose><c:when test="${not empty userobj}"><a href="one_view.jsp?id=<%=j.getId()%>" class="btn btn-sm btn-jp-secondary">View Details</a></c:when><c:otherwise><a href="login.jsp" class="btn btn-sm btn-jp-secondary">Sign in to view</a></c:otherwise></c:choose></div>
            </div></div>
        <% } %>
        <% if (landingJobs.isEmpty()) { %><div class="col-12"><div class="empty-state">No jobs have been posted yet.</div></div><% } %>
        </div>
    </div></section>
</main>
<%@include file="all_component/footer.jsp"%>
</body></html>
