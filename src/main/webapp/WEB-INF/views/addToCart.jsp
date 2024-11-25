<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add to Cart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script> <!-- Ensure SweetAlert2 is loaded -->
    <style>
        body {
            background-color: #f8f9fa;
        }
        .card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .card:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
        }
        .card-img-top {
            height: 200px;
            object-fit: cover;
        }
        .cart-icon {
            position: fixed;
            top: 20px;
            right: 20px;
            cursor: pointer;
            z-index: 1000;
        }
        .cart-icon span {
            position: absolute;
            top: -5px;
            right: -5px;
            background-color: red;
            color: white;
            border-radius: 50%;
            padding: 3px 7px;
            font-size: 12px;
        }
        
        .back{
           text-decoration: none;
           margin-left: 20px;
           	
        }
    </style>
</head>
<body>


<nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="goowner">Shopping</a>
        
        
        <ul class="navbar-nav ms-auto">
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/">

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

<!-- Cart Icon with dynamic count -->
<div class="cart-icon">
    <a href="${pageContext.request.contextPath}/viewCart">
        <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="currentColor" class="bi bi-cart" viewBox="0 0 16 16">
            <path d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .491.592l-1.5 8A.5.5 0 0 1 13 12H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5M3.102 4l1.313 7h8.17l1.313-7zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4m7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4m-7 1a1 1 0 1 1 0 2 1 1 0 0 1 0-2m7 0a1 1 0 1 1 0 2 1 1 0 0 1 0-2"/>
        </svg>
        <span id="cart-count">${sessionScope.cartCount != null ? sessionScope.cartCount : 0}</span>
    </a>
</div>

<div class="container">
    <h2 class="text-center my-4">Product List</h2>


    <!-- Display error message in SweetAlert -->
    <c:if test="${not empty error}">
        <script>
            Swal.fire({
                title: 'Error',
                text: '${error}',  <!-- Use the error message passed from the controller -->
                icon: 'error',
                confirmButtonText: 'OK'
            });
        </script>
    </c:if>

  <c:if test="${not empty productList}">
    <div class="row row-cols-1 row-cols-md-3 g-4">
        <c:forEach var="product" items="${productList}">
            <div class="col">
                <div class="card h-100">
                    <img src="${pageContext.request.contextPath}/upload/${product.p_photo}" class="card-img-top" alt="${product.p_name}">
                    <div class="card-body">
                        <h5 class="card-title">${product.p_name}</h5>
                        <p class="card-text">Size: ${product.p_size}</p>
                        <p class="card-text">Price: ${product.p_price} Kyats</p>
                        <p class="card-text">Available: ${product.p_quantity}</p>

                        <!-- Check if the product is already in the cart -->
                        <c:choose>
                            <c:when test="${sessionScope.cartProductIds != null && sessionScope.cartProductIds.contains(product.id)}">
                                <!-- Button disabled if product is in the cart -->
                                <button class="btn btn-secondary" disabled>Already in Cart</button>
                            </c:when>
                            <c:otherwise>
                                <!-- Form to add product to cart if it's not already there -->
                                <form action="${pageContext.request.contextPath}/addToCart/${product.id}" method="post">
                                    <input type="hidden" name="quantity" value="1" />
                                    <input type="submit" class="btn btn-primary order-btn" value="Add to Cart"/>
                                </form>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</c:if>

    <c:if test="${empty productList}">
        <p class="text-center">No products available.</p>
    </c:if>
</div>

<!-- SweetAlert2 Success Message -->
<c:if test="${not empty successMessage}">
    <script>
        Swal.fire({
            title: 'Success',
            text: '${successMessage}',  <!-- Success message passed from controller -->
            icon: 'success',
            confirmButtonText: 'OK'
        });
    </script>
</c:if>

<!-- Optionally, handle cart count dynamically using JavaScript -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        var cartCount = ${sessionScope.cartCount != null ? sessionScope.cartCount : 0};
        var cartCountElement = document.getElementById('cart-count');
        if (cartCountElement) {
            cartCountElement.textContent = cartCount;
        }
    });
</script>

</body>
</html>
