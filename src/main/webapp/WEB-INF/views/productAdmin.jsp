<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%> 



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
    <title>Chef's Market</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <!-- Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />

    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    

    <!-- Custom CSS -->
    <style>
        body {
            background-image: url('${pageContext.request.contextPath}/resources/img/p2bg.jpg');
            background-size: cover;
            font-family: 'Roboto', sans-serif;
            background-attachment: fixed;
            color: #fff;
           
        }

        .hero-section {
        
            background: rgba(0, 0, 0, 0.6);
            padding: 100px 0;
            height: 65dvh;
            text-align: center;
            color: #f8f9fa;
            animation: fadeInDown 2s ease-out;
        }

        .hero-section h1 {
            font-size: 4rem;
            margin-bottom: 20px;
            animation: fadeInLeft 2s;
        }

        .navbar-brand {
            font-weight: bold;
            font-size: 1.5rem;
            color: #fff !important;
        }

      .home_text {
             position:absolute;
             top:140px;
            
             left:0;
             right:0;
             animation: fadeInLeft 2s;
      }
        .navbar-nav .nav-link {
            color: #fff !important;
            transition: color 0.3s ease;
        }

        .navbar-nav .nav-link:hover {
            color: #ff6f61 !important;
        }

        .table {
            background-color: rgba(255, 255, 255, 0.8);
             width: 95%;
             border-radius: 20px;
             margin-left:30px;
             margin-right:30px;
            margin-top: 30px;
            animation: fadeInUp 1.5s ease-out;
            
        }

        .btn-custom {
            background-color: #ff6f61;
            border-color: #ff6f61;
            color: white;
            transition: background-color 0.3s ease;
        }

        .btn-custom:hover {
            background-color: #ff4f41;
        }

        .footer {
            background-color: rgba(0, 0, 0, 0.8);
            padding: 20px;
            color: #fff;
            text-align: center;
        }

        /* Animations */
        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeInLeft {
            from {
                opacity: 0;
                transform: translateX(-50px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        
         .card {
       
        
        
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            
           
        }
        .card:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
        }
        
        #c_card {
        width: 350px;
        height: 300px;
        
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            
           
        }
        #c_card:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
        }
        .card-img-top {
            height: 200px;
            object-fit: cover;
        }
        .card-body {
            text-align: center;
        }
        .order-btn {
            margin-top: 10px;
        }
        
         .profile-photo {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            border: 3px solid white;
            margin-left: 30px;
            margin-bottom: 50px;
            animation: bounce 2s infinite;
        }
        
        /* Enhance the navbar style */
.navbar-dark .navbar-nav .nav-link {
    color: #f8f9fa;
    padding: 10px 15px;
    font-weight: 500;
}

.navbar-dark .navbar-nav .nav-link:hover {
    color: #ffc107;
    background-color: transparent;
}

.navbar-dark .navbar-nav .nav-item {
    margin-right: 10px;
}

.navbar-dark .navbar-brand {
    font-size: 1.8rem;
    font-weight: 600;
}

/* Style for profile photo */
.profile-photo {
    border-radius: 50%;
    margin-bottom: 10px;
}

/* Dropdown item style */
.dropdown-menu-dark .dropdown-item {
    padding: 12px 20px;
}

.dropdown-item:hover {
    background-color: #6c757d;
}

/* Responsive adjustments for offcanvas */
@media (max-width: 768px) {
    .navbar-nav {
        text-align: center;
    }
    .navbar-toggler {
        border-color: #fff;
    }
}






/* Card Styling */
#c_card {
    border-radius: 10px;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

#c_card:hover {
    transform: translateY(-5px);
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
}

.card-img-top {
    border-radius: 10px;
    height: 250px;
    object-fit: cover;
}



.card-body .card-text {
    font-size: 1rem;
    color: #6c757d;
}

.card-body .card-text strong {
    font-weight: 600;
    color: #343a40;
}

/* Carousel control buttons */




/* Adjustments for mobile and tablet */
@media (max-width: 768px) {
    .hero-section h1 {
        font-size: 2rem;
    }

    .hero-section .btn-custom {
        padding: 10px 20px;
    }
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
                window.location.href = ${pageContext.request.contextPath}/;
            }
        });
    }
</script>


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

<nav class="navbar navbar-dark bg-dark fixed-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Product-Admin</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasDarkNavbar" aria-controls="offcanvasDarkNavbar" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="offcanvas offcanvas-end text-bg-dark" tabindex="-1" id="offcanvasDarkNavbar" aria-labelledby="offcanvasDarkNavbarLabel">
            <div class="offcanvas-header">
                <h5 class="offcanvas-title" id="offcanvasDarkNavbarLabel">Admin Profile</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas" aria-label="Close"></button>
            </div>
            <div class="offcanvas-body">
                <ul class="navbar-nav justify-content-end flex-grow-1 pe-3">
                    <li class="nav-item">
                        <img src="${pageContext.request.contextPath}/upload/${admin.a_photo}" alt="Profile Photo" class="profile-photo rounded-circle mb-3" width="100">
                       
                    </li>
                     <li class="nav-item">
                      <h5>Name : ${admin.first_name}</h5>
                      
                       <br>
                       <hr>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="#">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="changeProfile">Edit Profile</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Work
                        </a>
                        <ul class="dropdown-menu dropdown-menu-dark">
                            <li><a href="addcategory" class="dropdown-item">Add Category (First)</a></li>
                            <li><a href="showaddtype" class="dropdown-item">Add Type (Second)</a></li>
                            <li><a href="showadditems" class="dropdown-item">Add Item (Third)</a></li>
                            <li><a href="showAddItemHasType" class="dropdown-item">Add Item has type (Fourth)</a></li>
                            <li><a href="productForm" class="dropdown-item">Add Product</a></li>
                        </ul>
                    </li>
                    <li><a href="javascript:void(0);" onclick="confirmLogout('adminlogout')" class="nav-link">Logout</a></li>
                </ul>
            </div>
        </div>
    </div>
</nav>

 
    <div id="carouselExampleFade" class="carousel carousel slide">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <div class="hero-section">
                

                      <div class= "home_text">
                
                    <h1 class="display-4 mb-4">Category List</h1>
                   
                    <a href="restore" class="btn btn-lg btn-custom">Restore Category</a>
                    </div>
                </div>

                <hr>
              <%--  
                <h1>Category List</h1>
               
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th scope="col">Id</th>
                            <th scope="col">Name</th>
                            <th scope="col">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="cbean" items="${cbeans}" varStatus="count">
                            <tr>
                                <td>${count.count}</td>
                                <td>${cbean.c_name}</td>
                                <td><a href="edit/${cbean.id}" class="btn btn-primary">Edit</a></td>
                                <td><a href="delete/${cbean.id}" class="btn btn-danger">Delete</a></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                
                
                
               --%>  
                
                
                
                
                 <div class="container mt-5">
        

        <!-- Bootstrap grid system to show categories as cards -->
        <div class="row row-cols-1 row-cols-md-3 g-4">
            <!-- Loop through cbeans list -->
            <c:forEach var="cbean" items="${cbeans}" varStatus="count">
                <div class="col">
                    <div class="card h-100">
                        <div class="card-body">
                            <h5 class="card-title">Category: ${cbean.c_name}</h5>
                            <p class="card-text">Category ID: ${count.count}</p>
                            <!-- Action buttons -->
                            <a href="edit/${cbean.id}" class="btn btn-primary">Edit</a>
                           <a href="javascript:void(0);" onclick="confirmDelete('delete/${cbean.id}')" class="btn btn-danger">Delete</a>

                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>       
            </div>
            
            
            
            

           
            <div class="carousel-item">
                <div class="hero-section">
                    <h1 class="display-4 mb-4">Item Has Type List</h1>
                   
                    
                </div>

                <hr>
    
        <table class="table table-striped table-hover">
            <thead>
                <tr>
                    <th scope="col">No</th>
                    <th scope="col">Category</th>
                    <th scope="col">Type</th>
                    <th scope="col">Item</th>
                    <th scope="col">Add Ingredient</th>
                </tr>
            </thead>
           <tbody>
    <c:forEach var="ihtlist" items="${itemhastypelist}" varStatus="count">
        <tr>
            <td>${count.count}</td>
            <td>${ihtlist.c_name}</td>
            <td>${ihtlist.t_name}</td>
            <td>${ihtlist.i_name}</td>
            <td>
               <c:choose>
    <c:when test="${ihtlist.ingredientExists}">
        <c:set var="itemLink" value="${pageContext.request.contextPath}/editith/${ihtlist.id}" />
    </c:when>
    <c:otherwise>
        <c:set var="itemLink" value="${pageContext.request.contextPath}/addith/${ihtlist.id}" />
    </c:otherwise>
</c:choose>

<a href="${itemLink}" class="btn ${ihtlist.ingredientExists ? 'btn-secondary' : 'btn-success'}">
    ${ihtlist.ingredientExists ? 'Edit' : 'Add'}
</a>

            </td>
        </tr>
    </c:forEach>
</tbody>

        </table>
       
            </div>
        
        <div class="d-flex justify-content-between position-fixed" style="width: 100%; top: 50%; transform: translateY(-50%);">
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleFade" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleFade" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>
  




        
        
        
        <div class="carousel-item">
        
    <div class="hero-section text-center text-white py-5 ">
     <div class= "home_text">
        <h1 class="display-4 mb-4">Ingredient List</h1>
        <!-- <a href="showadditems" class="btn btn-lg btn-custom">View Most Popular</a> -->
        </div>
    </div>

    <hr class="my-4">
    
    <div class="container mt-5">
        <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
            <c:forEach var="ingredient" items="${ingredientList}">
                <div class="col">
                    <div class="card h-100 shadow-lg border-light" id="c_card">
                        <img src="${pageContext.request.contextPath}/upload/${ingredient.photoPath}" class="card-img-top" alt="${ingredient.item_name}">
                        <div class="card-body">
                            <h5 class="card-title">${ingredient.item_name}</h5> <!-- Display item name -->
                            <p class="card-text"><strong>Ingredient:</strong> ${ingredient.in_name}</p> <!-- Display in_name -->
                            <p class="card-text"><strong>Instruction:</strong> ${ingredient.instruction}</p> <!-- Display instruction -->
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <div class="d-flex justify-content-between position-fixed" style="width: 100%; top: 50%; transform: translateY(-50%);">
        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleFade" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleFade" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>
</div>


</div>



</div>


    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
<script>
    function confirmDelete(url) {
        Swal.fire({
            title: 'Are you sure?',
            text: "You won't be able to revert this!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, delete it!'
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = url; // If confirmed, redirect to the delete URL
            }
        })
    }
    
    
    
    


    // Function to toggle instruction visibility
    function toggleInstruction(button) {
        const shortInstruction = button.previousElementSibling.querySelector('.short-instruction');
        const fullInstruction = button.previousElementSibling.querySelector('.full-instruction');

        if (fullInstruction.style.display === 'none') {
            shortInstruction.style.display = 'none';
            fullInstruction.style.display = 'inline';
            button.innerText = 'See less';
        } else {
            shortInstruction.style.display = 'inline';
            fullInstruction.style.display = 'none';
            button.innerText = 'See more';
        }
    }

    // Initial hiding for long instructions and card animations
    document.addEventListener("DOMContentLoaded", function() {
        const allCards = document.querySelectorAll('.card');
        
        allCards.forEach(function(card, index) {
            setTimeout(() => {
                card.classList.add('show'); // Add show class for animation
            }, index * 100); // Staggered appearance
        });

        const allInstructions = document.querySelectorAll('.card-text');
        allInstructions.forEach(function(instruction) {
            const length = instruction.dataset.length;
            if (length > 100) { // Hiding long instructions initially
                instruction.querySelector('.short-instruction').style.display = 'inline';
                instruction.querySelector('.full-instruction').style.display = 'none';
            } else {
                instruction.style.display = 'block';
            }
        });
    });
</script>
</body>
</html>
