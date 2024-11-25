<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
<title>Owner Dashboard</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
 <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>
    .card-custom {
        border-radius: 15px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        transition: 0.3s;
    }
    .card-custom:hover {
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
    }
    .btn-rounded {
        border-radius: 20px;
    }
</style>
</head>
<body>

<script>
    function confirmLogout(url) {
        Swal.fire({
            title: 'Are you sure?',
           
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, Logout!'
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = url;
            }
        });
    }
</script>

<nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="goowner">Owner Dashboard</a>
        
        
        <ul class="navbar-nav ms-auto">
            <li class="nav-item">
                <a class="nav-link" href="goowner">

                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-house-fill" viewBox="0 0 16 16">
                        <path d="M8.707 1.5a1 1 0 0 0-1.414 0L.646 8.146a.5.5 0 0 0 .708.708L8 2.207l6.646 6.647a.5.5 0 0 0 .708-.708L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293z"/>
                        <path d="m8 3.293 6 6V13.5a1.5 1.5 0 0 1-1.5 1.5h-9A1.5 1.5 0 0 1 2 13.5V9.293z"/>
                    </svg>
                    Home
                </a>
            </li>
              <li><a href="javascript:void(0);" onclick="confirmLogout('adminlogout')" class="nav-link">Logout</a></li>
        </ul>
    </div>
</nav>

<div class="container my-5">
    <h2 class="text-center mb-4">Owner Dashboard</h2>

    <div class="row justify-content-center">
        <!-- Show Admins -->
        <div class="col-md-4 mb-4">
            <div class="card card-custom">
                <!-- <img src="admin_image.jpg" class="card-img-top" alt="Admins"> -->
                <div class="card-body text-center">
                    <h5 class="card-title">Admins</h5>
                    <p class="card-text">Manage admin accounts.</p>
                    <a href="showadmin" class="btn btn-primary btn-rounded mb-2">Show Admins</a>
                    <a href="admin_register" class="btn btn-success btn-rounded mb-2">Add Admin</a>
                   <!--  <a href="deleteAdmin.jsp" class="btn btn-danger btn-rounded">Delete Admin</a> -->
                </div>
            </div>
        </div>

        <!-- Show Categories -->
        <div class="col-md-4 mb-4">
            <div class="card card-custom">
               <!--  <img src="category_image.jpg" class="card-img-top" alt="Categories"> -->
                <div class="card-body text-center">
                    <h5 class="card-title">Categories</h5>
                    <p class="card-text">Manage product categories.</p>
                    <a href="showcategory" class="btn btn-primary btn-rounded">Show Categories</a>
                </div>
            </div>
        </div>

        <!-- Show Ingredients -->
        <div class="col-md-4 mb-4">
            <div class="card card-custom">
                <!-- <img src="ingredient_image.jpg" class="card-img-top" alt="Ingredients"> -->
                <div class="card-body text-center">
                    <h5 class="card-title">Ingredients</h5>
                    <p class="card-text">Manage ingredients.</p>
                    <a href="showingredient" class="btn btn-primary btn-rounded">Show Ingredients</a>
                </div>
            </div>
        </div>

        <!-- Show Items -->
        <div class="col-md-4 mb-4">
            <div class="card card-custom">
                <!-- <img src="item_image.jpg" class="card-img-top" alt="Items"> -->
                <div class="card-body text-center">
                    <h5 class="card-title">Items</h5>
                    <p class="card-text">Manage items.</p>
                    <a href="showitem" class="btn btn-primary btn-rounded">Show Items</a>
                </div>
            </div>
        </div>

        <!-- Show Types -->
        <div class="col-md-4 mb-4">
            <div class="card card-custom">
                <!-- <img src="type_image.jpg" class="card-img-top" alt="Types"> -->
                <div class="card-body text-center">
                    <h5 class="card-title">Types</h5>
                    <p class="card-text">Manage types.</p>
                    <a href="showtype" class="btn btn-primary btn-rounded">Show Types</a>
                </div>
            </div>
        </div>

        <!-- Show Users -->
        <div class="col-md-4 mb-4">
            <div class="card card-custom">
                <!-- <img src="user_image.jpg" class="card-img-top" alt="Users"> -->
                <div class="card-body text-center">
                    <h5 class="card-title">Users</h5>
                    <p class="card-text">Manage users.</p>
                    <a href="showuser" class="btn btn-primary btn-rounded">Show Users</a>
                </div>
            </div>
        </div>
        
        <div class="col-md-4 mb-4">
            <div class="card card-custom">
                <!-- <img src="type_image.jpg" class="card-img-top" alt="Types"> -->
                <div class="card-body text-center">
                    <h5 class="card-title">Products</h5>
                    <p class="card-text">Manage products.</p>
                    <a href="showproduct" class="btn btn-primary btn-rounded">Show Products</a>
                </div>
            </div>
        </div>

       
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
