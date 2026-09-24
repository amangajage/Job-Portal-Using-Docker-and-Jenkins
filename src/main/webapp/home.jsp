<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.entity.Jobs"%>
<%@ page import="com.DB.DBConnect"%>
<%@ page import="com.dao.JobDAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html><html><head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>Find Jobs | Job Portal</title><%@include file="all_component/all_css.jsp"%>
</head><body>
<c:if test="${empty userobj}"><c:redirect url="login.jsp"></c:redirect></c:if>
<%@include file="all_component/navbar.jsp"%>
<div class="page-header"><div class="container"><div class="section-kicker">Job search</div><h1>Find your next opportunity</h1><p>Search available roles, save the ones you like, and apply when you're ready.</p></div></div>
<main class="container section-space pt-4">
<c:if test="${not empty succMsg}"><div class="alert alert-success border-0 shadow-sm"><i class="fa-solid fa-circle-check me-2"></i>${succMsg}</div><c:remove var="succMsg"/></c:if>
<div class="filter-panel mb-4"><div class="d-flex align-items-center gap-2 mb-3"><div class="feature-icon mb-0" style="width:38px;height:38px;font-size:.95rem"><i class="fa-solid fa-filter"></i></div><div><h2 class="h6 mb-0 fw-bold" style="color:var(--jp-navy)">Filter jobs</h2><div class="small muted-text">Search by location, category, or both.</div></div></div>
<form action="more_view.jsp" method="get"><div class="row g-3 align-items-end">
<div class="col-md-5"><label class="filter-label" for="jobLocation">Location</label><select name="loc" class="form-select" id="jobLocation"><option value="lo">Any location</option><option>Chandigarh</option><option>Bangalore</option><option>Coimbatore</option><option>Chennai</option><option>Mumbai</option><option>Pune</option><option>Kolkata</option><option>Delhi-NCR</option><option>Baroda</option><option>Hydrabad</option><option>Dhule</option><option>Shirpur</option></select></div>
<div class="col-md-5"><label class="filter-label" for="jobCategory">Category</label><select name="cat" class="form-select" id="jobCategory"><option value="ca">Any category</option><option>IT</option><option value="Devloper">Developer</option><option>Banking</option><option>Engineer</option><option>Teacher</option></select></div>
<div class="col-md-2"><button type="submit" class="btn btn-jp-primary w-100 py-2"><i class="fa-solid fa-magnifying-glass me-1"></i>Search</button></div>
</div></form></div>
<div class="d-flex justify-content-between align-items-end mb-3"><div><div class="section-kicker">Latest openings</div><h2 class="h4 section-title mb-0 mt-1">Available jobs</h2></div><a href="dashboard.jsp" class="btn btn-sm btn-jp-secondary"><i class="fa-solid fa-bookmark me-1"></i>Saved & Applications</a></div>
<% List<Jobs> list = new JobDAO(DBConnect.getconn()).getAllJobs(); %>
<% if (list.isEmpty()) { %><div class="empty-state"><i class="fa-regular fa-folder-open d-block"></i><h3 class="h5" style="color:var(--jp-navy)">No jobs available right now</h3><p class="mb-0">Please check again later for new postings.</p></div><% } else { %>
<div class="d-grid gap-3"><% for (Jobs j : list) { String desc=j.getDescription()==null?"":j.getDescription(); String preview=desc.length()>120?desc.substring(0,120)+"...":desc; String status=j.getStatus()==null?"":j.getStatus(); %>
<div class="job-card"><div class="job-card-head"><div><h3 class="job-title"><%=j.getTitle()%></h3><div class="job-date mt-1">Posted <%=j.getPdate()%></div></div><div class="d-flex align-items-center gap-2"><span class="status-badge <%= "Inactive".equalsIgnoreCase(status)?"inactive":"" %>"><%=status%></span><a class="save-btn" href="one_view.jsp?id=<%=j.getId()%>" title="Open job"><i class="fa-regular fa-bookmark"></i></a></div></div>
<p class="job-description"><%=preview%></p><div class="job-meta"><span class="meta-chip"><i class="fa-solid fa-location-dot"></i><%=j.getLocation()%></span><span class="meta-chip"><i class="fa-solid fa-layer-group"></i><%=j.getCategory()%></span></div>
<div class="job-actions"><span class="small muted-text">Job ID #<%=j.getId()%></span><a href="one_view.jsp?id=<%=j.getId()%>" class="btn btn-sm btn-jp-secondary px-3">View Details <i class="fa-solid fa-arrow-right ms-1"></i></a></div></div>
<% } %></div><% } %>
</main><%@include file="all_component/footer.jsp"%></body></html>
