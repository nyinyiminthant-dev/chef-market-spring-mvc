<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
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
<title>Add Category</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" 
    integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

<style type="text/css">
    body {
        background: url('${pageContext.request.contextPath}/resources/img/p9bg.jpg') no-repeat center center fixed;
        background-size: cover;
        color: white;
        font-family: 'Arial', sans-serif;
        animation: fadeInBackground 2s ease-in-out;
    }

      body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: inherit;
            filter: blur(8px); /* Adjust the blur intensity */
            z-index: -1;
        }


    .error {
        color: red;
        font-weight: bold;
    }

    .text-primary-emphasis{
        padding-left: 20px;
        text-decoration: none;
       
        transition: color 0.3s ease;
    }

  

    .contain {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh; /* Full height of viewport */
            z-index: 1;
            position: relative;
            opacity: 0; /* Start hidden for fade-in effect */
            animation: fadeIn 1s forwards, scaleUp 0.5s forwards; /* Fade-in and scale-up animation */
        }

    @keyframes fadeInUp {
        0% {
            transform: translateY(100px);
            opacity: 0;
        }
        100% {
            transform: translateY(0);
            opacity: 1;
        }
    }

    .form {
        width: 400px;
        padding: 30px;
        border-radius: 20px;
        background-color: rgba(255, 255, 255, 0.8);
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.5);
        animation: zoomIn 0.8s ease;
    }

        @keyframes fadeIn {
            to {
                opacity: 1; /* End with full opacity */
            }
        }

        @keyframes scaleUp {
            0% {
                transform: scale(0.8); /* Start slightly smaller */
            }
            100% {
                transform: scale(1); /* End at normal size */
            }
        }

        .form h2 {
            text-align: center;
            color: black;
            margin-bottom: 20px;
        }

        .form-select, .form-control {
            margin-bottom: 20px;
            border-radius: 10px;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        .form-select:focus, .form-control:focus {
           /*  border-color: #00d4ff; */
            box-shadow: 0 0 8px rgba(0, 212, 255, 0.8);
        }

        .btn-primary {
            width: 100%;
            padding: 10px;
            border-radius: 10px;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }

       

        .swal2-popup {
            font-size: 1.2rem !important;
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
            timer: 2000,
            timerProgressBar: true,
            
        });
    </script>
</c:if>

<!-- Error Alert -->
<c:if test="${not empty error}">
    <script>
        Swal.fire({
            icon: 'error',
            title: 'Error!',
            text: '${error}',
            showConfirmButton: true, 
            
        });
    </script>
</c:if>

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
          <a href="showaddtype" class="nav-link" id="add">Add Type</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="showadditems">Add Item</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="showAddItemHasType">Add Item has type</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="productForm">Add Product</a>
        </li>
      </ul>
    </div>
  </div>
</nav>

    

<div class="contain">
    <form:form action="addcategory" method="post" modelAttribute="categorylist" class="form">
        <h2 class="animate__animated animate__bounceIn">Add Category</h2>
        
      <form:input path="c_name" type="text" class="form-control" placeholder="Enter Category"/>
<form:errors path="c_name" cssClass="error"/>

        
        <input type="submit" class="btn btn-primary" value="Add">
        
       
        <br>
        <br>
         <p style="color:#ff6f61;">After adding category please add the type</p>
       
       
    </form:form>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
