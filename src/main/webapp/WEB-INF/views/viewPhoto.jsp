<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%
    if (session.getAttribute("adminEmail") == null) {
        // Redirect to login page if session does not contain adminEmail
        response.sendRedirect(request.getContextPath() + "/productadmin");
        return;
    }
%>
<html>
<head>
<title>Product List</title>


<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Custom CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/style.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/cart_style.css">



<style>
/* Background and body styling */
body {
	background-image:
		url('${pageContext.request.contextPath}/resources/img/p9bg.jpg');
	background-size: cover;
	background-position: center;
	color: #333;
}

/* Card animations and styles */
.card {
	transition: transform 0.3s ease, box-shadow 0.3s ease;
	opacity: 0;
	transform: translateY(50px);
}

.card:hover {
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

/* Cart icon */
.icon-cart svg {
	width: 24px;
	height: 24px;
	color: #333;
	margin-right: 10px;
}

.icon-cart span {
	color: #ff6347;
	font-weight: bold;
}

/* Cart styles */
.cartTab {
	position: fixed;
	bottom: 0;
	width: 100%;
	background-color: #fff;
	box-shadow: 0 -4px 8px rgba(0, 0, 0, 0.2);
	display: none;
	padding: 20px;
}

.cartTab h1 {
	font-size: 1.5em;
	color: #333;
}

.addproductlink {
	text-decoration: none;
	 color: brown;
  background:white;
  border:1px solid #eee;
	padding: 5px;
	border-radius: 3px;
	transition: 0.3s;
}

.addproductlink:hover {
  color: red;
  background:#eee;
 
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
        
</style>
</head>
<body>



<c:if test="${not empty sessionScope.successMessage}">
    <script>
        Swal.fire({
            icon: 'success',
            title: 'Success!',
            text: '${sessionScope.successMessage}',
            showConfirmButton: false,
            timer: 2000,
            timerProgressBar: true
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
	<div class="container">

		<h2 class="text-center my-4">Product List</h2>

		<header>
			<div class="title">PRODUCT LIST</div>
			<a href="productForm" class="addproductlink">Add More</a>
			
		</header>

		<c:if test="${!empty productList}">
			<div class="row row-cols-1 row-cols-md-3 g-4">
				<c:forEach var="product" items="${productList}">
					<div class="col">
						<div class="card h-100">
							<img
								src="${pageContext.request.contextPath}/upload/${product.p_photo}"
								class="card-img-top" alt="Product Image">
							<div class="card-body">
								<h5 class="card-title">${product.p_name}</h5>
								<p class="card-text">Size: ${product.p_size}</p>
								<p class="card-text">Price: ${product.p_price} Kyats</p>
								<p class="card-text">Quantity: ${product.p_quantity}</p>
								 <sec:authorize access="hasRole('ROLE_ADMIN')">
                                <a href="${pageContext.request.contextPath}/editProduct2/${product.id}" class="btn btn-warning order-btn">Update Product</a>
                                <a href="javascript:void(0);" onclick="confirmDelete('${pageContext.request.contextPath}/deleteProduct2/${product.id}')" class="btn btn-danger order-btn">Delete Product</a>
                            </sec:authorize>
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

	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
function confirmDelete(url) {
    Swal.fire({
        title: 'Are you sure?',
        text: "Delete!!!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, delete it!'
    }).then((result) => {
        if (result.isConfirmed) {
            // Send a POST request
        	fetch(url, {
        	    method: 'POST',  // Use POST method to send the request
        	    headers: {
        	        'Content-Type': 'application/x-www-form-urlencoded'
        	    }
        	}).then(response => {
        	    if (response.ok) {
        	        window.location.href = '${pageContext.request.contextPath}/viewProduct';  // Redirect after successful deletion
        	    } else {
        	        Swal.fire('Error', 'Product deletion failed.', 'error');
        	    }
        	});

        }
    });
}

    // Animation for card load-in
    document.addEventListener("DOMContentLoaded", function() {
        const cards = document.querySelectorAll('.card');
        cards.forEach((card, index) => {
            card.style.opacity = 0;
            card.style.transform = 'translateY(50px)';
            setTimeout(() => {
                card.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
                card.style.opacity = 1;
                card.style.transform = 'translateY(0)';
            }, index * 100);
        });
    });
</script>

</body>
</html>
