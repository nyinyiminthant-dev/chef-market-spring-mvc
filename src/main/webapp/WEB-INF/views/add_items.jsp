<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<title>Add Item</title>

<!-- Bootstrap and SweetAlert2 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style>
    body {
        background-image: url('${pageContext.request.contextPath}/resources/img/p10bg.jpg');
        background-size: cover;
        background-position: center;
        background-repeat: no-repeat;
        height: 100vh;
        color: white;
        font-family: Arial, sans-serif;
        overflow: hidden;
    }

    /* Apply a blur effect to the background image */
    body::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-image: inherit;
        background-size: cover;
        background-position: center;
        filter: blur(5px);
        z-index: -1; /* Keeps blur behind the form container */
    }

    /* Navbar styling to fix it to the top */
    .navbar {
        position: fixed;
        top: 0;
        width: 100%;
        z-index: 1000;
    }

    /* Main content container for vertical alignment */
    .main-content {
        display: flex;
        align-items: center;
        justify-content: center;
        min-height: 100vh;
        padding-top: 60px; /* Offset for navbar height */
    }

    /* Form container with soft blue color */
    .form-container {
        background-color: rgba(255, 255, 255, 0.8);
        border-radius: 15px;
        padding: 30px;
        width: 400px;
        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
        animation: fadeIn 1s ease;
        z-index: 1;
    }

    /* Header styling */
    h2 {
        text-align: center;
        font-weight: bold;
        color: black;
        margin-bottom: 20px;
    }

    /* Form controls */
    .form-control, .form-select {
        border-radius: 10px;
        transition: 0.3s;
    }

    .form-control:focus, .form-select:focus {
        box-shadow: 0px 0px 10px rgba(70, 130, 180, 0.6);
        border-color: #4682b4;
    }

    /* Button styling */
    .btn-primary {
        background-color: #4e73df;
        border: none;
        transition: 0.3s;
        width: 100%;
    }

    .btn-primary:hover {
        background-color: #375a7f;
        transform: scale(1.05);
    }

    /* Animation */
    @keyframes fadeIn {
        0% { opacity: 0; transform: translateY(-20px); }
        100% { opacity: 1; transform: translateY(0); }
    }

    /* Error styling */
    .error {
        color: #ff4d4f;
        font-size: 0.9em;
    }
    
    
       .navbar-nav .nav-link {
           
            border-radius: 10px;
            background:#eee;
            margin-right: 20px;
            transition: color 0.3s ease;
        }

        .navbar-nav .nav-link:hover {
            color: #ff6f61 !important;
            
        }
        
          #add {
             color:red;
             animation: addcolor 2s infinite;
        }
        
        
          @keyframes addcolor {
           
           0% {
           color: red;
           } 25% {
           color: #eee;
           }
           50% {
           color:red;
           }
        }
</style>
</head>
<body>


    <c:if test="${not empty successMessage}">
        <script>
            Swal.fire({
                icon: 'success',
                title: 'Success!',
                text: '${successMessage}',
                showConfirmButton: false,
                timer: 2000
            });
        </script>
    </c:if>

    <c:if test="${not empty error} && ${error == 'Please select a category.'}">
        <script>
            Swal.fire({
                icon: 'error',
                title: 'Error!',
                text: 'Please select a category.',
                showConfirmButton: true
            });
        </script>
    </c:if>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg bg-body-tertiary"  style="opacity: 0.8;">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Chef's Market</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="gohome">Home</a>
                </li>
                <li class="nav-item">
                   <a href="addcategory" class="nav-link">Add Category</a>
                    
                </li>
                <li class="nav-item">
                   <a href="showaddtype" class="nav-link">Add Type</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="showAddItemHasType"   id="add">Add Item has type</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="productForm">Add Product</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Main content container to center form vertically -->
<div class="main-content">
    <!-- Form Container -->
    <div class="form-container">
        <form:form action="showadditems" method="post" modelAttribute="itemslist" class="form">
            <h2>Add Items</h2>

            <!-- Category Selection -->
            <div class="mb-3">
                <form:select path="c_id" id="categorySelect" class="form-select" onchange="this.form.submit()">
                    <option value="">Select Category</option>
                    <c:forEach var="cbean" items="${cbeans}">
                        <option value="${cbean.id}" ${cbean.id == itemslist.c_id ? 'selected' : ''}>${cbean.c_name}</option>
                    </c:forEach>
                </form:select>
                <form:errors path="c_id" cssClass="error" />
            </div>

            <!-- Type Selection -->
            <div class="mb-3">
                <form:select path="t_id" id="typeSelect" class="form-select" onchange="this.form.submit()">
                    <option value="">Select Type</option>
                    <c:forEach var="tbean" items="${tbeans}">
                        <option value="${tbean.id}" ${tbean.id == itemslist.t_id ? 'selected' : ''}>${tbean.t_name}</option>
                    </c:forEach>
                </form:select>
                <form:errors path="t_id" cssClass="error" />
            </div>

            <!-- Item Name Input -->
            <div class="mb-3">
                <form:input path="i_name" type="text" class="form-control" placeholder="Enter Item Name" />
                <form:errors path="i_name" cssClass="error" />
            </div>

            <!-- Submit Button -->
            <button type="submit" class="btn btn-primary">Add</button>

            <!-- Link to Home -->
           
        </form:form>
    </div>
</div>

<!-- Bootstrap JavaScript and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2f9LxUJj6ISsmSMoO6wK4g6ka7h6cXIOKhq5U0qgk7J6wr23M+MuI/UUjZa" crossorigin="anonymous"></script>
</body>
</html>
