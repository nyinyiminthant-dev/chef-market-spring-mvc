<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<%
    if (session.getAttribute("adminEmail") == null) {
        // Redirect to login page if session does not contain adminEmail
        response.sendRedirect(request.getContextPath() + "/productadmin");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order List</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    .table-container {
        padding: 20px;
        background-color: #f8f9fa;
        border-radius: 15px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
    .product-image {
        width: 100px;
        height: auto;
        border-radius: 8px;
        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.2);
    }
</style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm mb-4">
    <div class="container">
        <a class="navbar-brand" href="gosell_admin">Order Dashboard</a>
        <ul class="navbar-nav ms-auto">
            <li class="nav-item">
                <a class="nav-link" href="gosell_admin">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-house-fill" viewBox="0 0 16 16">
                        <path d="M8.707 1.5a1 1 0 0 0-1.414 0L.646 8.146a.5.5 0 0 0 .708.708L8 2.207l6.646 6.647a.5.5 0 0 0 .708-.708L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293z"/>
                        <path d="m8 3.293 6 6V13.5a1.5 1.5 0 0 1-1.5 1.5h-9A1.5 1.5 0 0 1 2 13.5V9.293z"/>
                    </svg>
                    Home
                </a>
            </li>
        </ul>
    </div>
</nav>

<div class="container my-5">
    <h2 class="text-center mb-4">Order List</h2>
    
   <form:form modelAttribute="searchUser" action="SearchUser" method="post" onsubmit="return validateForm()">
   
   <p>${error }</p>
    <div class="input-control">
        <label for="u_email">Email:</label>
        <form:input path="u_email" id="u_email" />

    </div>
    <div class="input-control">
        <label for="Startdate">Start Date:</label>
        <form:input type="date" path="st_date" id="Startdate"  />
    </div>
    <div class="input-control">
        <label for="endDate">End Date:</label>
        <form:input type="date" path="end_date" id="endDate"  />
    </div>
    <button class="btn btn-primary btn-rounded">Search</button>
</form:form>

<script>
function validateForm() {
    const email = document.getElementById("u_email").value;
    const startDate = document.getElementById("Startdate").value;
    const endDate = document.getElementById("endDate").value;

    // Simple email regex pattern for validation
    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    
    if (!email||  !startDate || !endDate) {
        alert("All fields are required.");
        return false;
    }

    if (!emailPattern.test(email)) {
        alert("Please enter a valid email address.");
        return false;
    }

    return true;
}
</script>   
    		

    <div class="table-container">
        <c:if test="${empty orderlist}">
            <div class="alert alert-warning text-center">
                No orders available.
            </div>
        </c:if>

        <table class="table table-hover table-bordered align-middle">
            <thead class="table-primary">
                <tr>
                    <th>Order Code</th>
                   
                    <th>User Name</th>
                    <th>User Email</th>
                    <th>Address</th>
                    <th>Pay Code</th>
                    <th>Order Date</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="order" items="${orderlist}">
                    <tr>
                        <td>${order.o_code}</td>
                        
                        <td><c:out value="${order.u_firstname}" /> <c:out value="${order.u_lastname}" /></td>
                        <td>${order.u_email}</td>
                        <td>${order.address}</td>
                        <td>${order.pay_code}</td>
                       <td>${order.o_date}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
