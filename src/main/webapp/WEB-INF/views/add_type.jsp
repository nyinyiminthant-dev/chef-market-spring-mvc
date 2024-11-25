<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
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
    <title>Add Type</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    
    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style type="text/css">
        body {
            background: url('${pageContext.request.contextPath}/resources/img/p11bg.jpg') no-repeat center center fixed; /* Set your background image URL here */
            background-size: cover;
            color: white;
            font-family: 'Arial', sans-serif;
            position: relative;
            overflow: hidden; /* Prevent scrolling */
        }

        /* Add blur to the background image */
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

        a {
            padding-left: 20px;
            text-decoration: none;
            color: #00d4ff;
            transition: color 0.3s ease;
        }

        a:hover {
            color: #00ff88;
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

        .form {
            width: 400px;
            padding: 30px;
            border-radius: 20px;
            background-color: rgba(255, 255, 255, 0.8); /* Semi-transparent background */
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.5);
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
            border-color: #00d4ff;
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
          <a class="nav-link" href="showadditems"   id="add">Add Item</a>
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
        <form:form action="addtype" method="post" modelAttribute="typelist" class="form">
            <h2>Add Type</h2>
            <form:select path="c_id" class="form-select">
                <option value="">Select Category</option>
                <c:forEach var="cbean" items="${cbeans}">
                    <option value="${cbean.id}" ${cbean.id == typelist.c_id ? 'selected' : ''}>${cbean.c_name}</option>
                </c:forEach>
            </form:select>
            <form:errors path="c_id" cssClass="error" />

            <form:input path="t_name" type="text" class="form-control" placeholder="Enter Type"></form:input>
            <form:errors path="t_name" cssClass="error" />

            <input type="submit" class="btn btn-primary" value="Add">
             <br>
        <br>
         <p style="color:#ff6f61;">After adding type please add the item</p>
        </form:form>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
