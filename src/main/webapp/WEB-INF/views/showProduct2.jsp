<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<title>Product List</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
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

	<nav
		class="navbar navbar-expand-lg navbar-light bg-light shadow-sm mb-4">
		<div class="container">
			<a class="navbar-brand" href="gosell_admin">Product Dashboard</a>
			<ul class="navbar-nav ms-auto">
				<li class="nav-item"><a class="nav-link" href="gosell_admin">
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
							fill="currentColor" class="bi bi-house-fill" viewBox="0 0 16 16">
                        <path
								d="M8.707 1.5a1 1 0 0 0-1.414 0L.646 8.146a.5.5 0 0 0 .708.708L8 2.207l6.646 6.647a.5.5 0 0 0 .708-.708L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293z" />
                        <path
								d="m8 3.293 6 6V13.5a1.5 1.5 0 0 1-1.5 1.5h-9A1.5 1.5 0 0 1 2 13.5V9.293z" />
                    </svg> Home
				</a></li>
			</ul>
		</div>
	</nav>

	<div class="container my-5">
		<h2 class="text-center mb-4">Product List</h2>

		<div class="table-container">
			<c:if test="${empty productlist}">
				<div class="alert alert-warning text-center">No products
					available.</div>
			</c:if>

			<table class="table table-hover table-bordered align-middle">
				<thead class="table-primary">
					<tr>
						<th>Product Code</th>
						<th>Product Name</th>
						<th>Size</th>
						<th>Quantity</th>
						<th>Price</th>
						<th>Photo</th>
						<th>Action</th>
						<th>Action</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="product" items="${productlist}">
						<tr>
							<td>${product.p_code}</td>
							<td>${product.p_name}</td>
							<td>${product.p_size}</td>
							<td>${product.p_quantity}</td>
							<td>${product.p_price}</td>
							<td><img
								src="${pageContext.request.contextPath}/upload/${product.p_photo}"
								alt="Product Photo" class="product-image" /></td>
							<td>
								<a
									href="${pageContext.request.contextPath}/editProduct/${product.id}"
									class="btn btn-warning order-btn">Update Product</a></td>
							<td><a href="javascript:void(0);"
   onclick="confirmDelete('${pageContext.request.contextPath}/deleteProduct/${product.id}')"
   class="btn btn-danger order-btn">Delete Product</a>
</td>	
							
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
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
        	        window.location.href = '${pageContext.request.contextPath}/showproducts';  // Redirect after successful deletion
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