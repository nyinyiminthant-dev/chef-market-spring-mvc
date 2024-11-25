<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<title>Your Cart</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
.quantity-control {
	display: flex;
	align-items: center;
	justify-content: center;
}

.quantity-control form {
	margin: 0 5px;
}

.total-price {
	font-weight: bold;
	font-size: 1.25rem;
}

.alert-danger {
	margin-top: 15px;
}
</style>
</head>
<body>

<c:if test="${not empty error}">
    <script>
        Swal.fire({
            icon: 'error',
            title: 'Error!',
            text: '${error}',
            confirmButtonText: 'OK'
        });
    </script>
</c:if>


	<div class="container mt-5">
		<h2 class="text-center mb-4">Your Cart</h2>

		<!-- Display error message if quantity exceeds max limit -->
		<c:if test="${not empty errorMessage}">
			<div class="alert alert-danger text-center">${errorMessage}</div>
		</c:if>

		<div class="table-responsive">
			<table class="table table-striped table-bordered">
				<thead class="table-dark">
					<tr>
						<th>Product Name</th>
						<th>Price</th>
						<th>Quantity</th>
						<th>Total Price</th>
						<th>Action</th>
					</tr>
				</thead>
				<tbody>
					<c:set var="totalPrice" value="0" />
					<c:set var="totalQuantity" value="0" />
					<!-- Track total quantity -->
					<c:forEach var="item" items="${cartItems}">
						<tr>
							<td>${item.p_name}</td>
							<td>${item.p_price}Kyats</td>
							<td>
								<div class="quantity-control">
									<!-- Decrease quantity form -->
									
									<form
										action="${pageContext.request.contextPath}/updateCartQuantity/${item.id}"
										method="post" style="display: inline;">
										<input type="hidden" name="quantity"
											value="${item.p_quantity - 1}" />
										<button type="submit" class="btn btn-outline-secondary btn-sm"
											${item.p_quantity <= 1 ? 'disabled' : ''}>
											<svg xmlns="http://www.w3.org/2000/svg" width="16"
												height="16" fill="currentColor"
												class="bi bi-dash-square-fill" viewBox="0 0 16 16">
                                            <path
													d="M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2zm2.5 7.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1 0-1" />
                                        </svg>
										</button>
									</form>

									<!-- Display current quantity -->
									<span class="mx-2">${item.p_quantity}</span>

									<!-- Increase quantity form -->

									<!-- Increase quantity form -->
									<form
										action="${pageContext.request.contextPath}/updateCartQuantity/${item.id}"
										method="post" style="display: inline;">
										<input type="hidden" name="quantity"
											value="${item.p_quantity + 1}" />
										<button type="submit" class="btn btn-outline-secondary btn-sm"
											${item.p_quantity >= item.maxQuantity ? 'disabled' : ''}>
											<svg xmlns="http://www.w3.org/2000/svg" width="16"
												height="16" fill="currentColor"
												class="bi bi-plus-square-fill" viewBox="0 0 16 16">
            <path
													d="M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2zm6.5 4.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3a.5.5 0 0 1 1 0" />
        </svg>
										</button>
									</form>



								</div>
							</td>
							<td>${item.p_price * item.p_quantity}Kyats</td>
							<!-- Total price for each item -->
							<td>
								<form
									action="${pageContext.request.contextPath}/removeFromCart/${item.id}"
									method="post" onsubmit="return confirmDelete(event)">
									<button type="submit" class="btn btn-danger btn-sm">Remove</button>
								</form>
							</td>
						</tr>
						<c:set var="totalPrice"
							value="${totalPrice + (item.p_price * item.p_quantity)}" />
						<c:set var="totalQuantity"
							value="${totalQuantity + item.p_quantity}" />
						<!-- Track total quantity -->
					</c:forEach>
				</tbody>
			</table>
		</div>

		<c:if test="${not empty cartItems}">
			<div class="text-right mt-3 total-price">
				<strong>Total:</strong> ${totalPrice} Kyats
			</div>
		</c:if>

		<div class="text-center mt-4">
			<a href="${pageContext.request.contextPath}/addToCart"
				class="btn btn-primary">Continue Shopping</a>

			<form action="${pageContext.request.contextPath}/placeOrder"
				method="post" class="mt-3"
				onsubmit="return validateOrder(${totalQuantity})">

				<label for="address" class="form-label"><strong>Delivery
						Address:</strong></label>
				<textarea id="address" name="address" class="form-control" rows="3"
					required placeholder="Enter your full address here">${sessionScope.address}</textarea>

				<button type="submit" class="btn btn-success mt-3">Order
					Now</button>
			</form>
		</div>
	</div>

	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script>
    function confirmDelete(event) {
        event.preventDefault(); // Prevent the form from submitting immediately
        const form = event.target;
        Swal.fire({
            title: 'Are you sure?',
            text: "This item will be removed from your cart.",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, remove it!'
        }).then((result) => {
            if (result.isConfirmed) {
                form.submit(); // Submit the form if confirmed
            }
        });
    }

    function validateOrder(totalQuantity) {
        if (totalQuantity <= 0) {
            Swal.fire({
                title: 'Invalid Quantity',
                text: "You cannot place an order with zero items in your cart.",
                icon: 'error',
                confirmButtonText: 'OK'
            });
            return false; // Prevent form submission
        }
        return true; // Allow form submission
    }

</script>

</body>
</html>
