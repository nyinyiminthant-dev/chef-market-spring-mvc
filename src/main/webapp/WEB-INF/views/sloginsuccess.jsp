<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%
    if (session.getAttribute("adminEmail") == null) {
        // Redirect to login page if session does not contain adminEmail
        response.sendRedirect(request.getContextPath() + "/productadmin");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login Successful</title>

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">

<style>
/* Full-screen background image */
body {
	background-image:
		url('${pageContext.request.contextPath}/resources/img/p4bg.jpg');
	/* Replace with your image URL */
	background-size: cover;
	background-position: center;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	margin: 0;
	font-family: 'Roboto', sans-serif;
	color: #ffffff;
}

/* Add a blur effect to the background */
body::before {
	content: '';
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: inherit;
	filter: blur(8px);
	z-index: -1;
}

.contain {
	width: 400px;
	height: 300px;
	background-color: rgba(255, 255, 255, 0.9);
	/* Slightly transparent background */
	border-radius: 20px;
	padding: 30px;
	text-align: center;
	box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
	animation: slideIn 1s ease-in-out;
	position: relative;
	z-index: 1;
}

h1 {
	color: #28a745; /* Success green color */
	font-size: 2rem;
	margin-bottom: 20px;
}

.btn-success {
	font-size: 1.2rem;
	padding: 10px 20px;
	border-radius: 30px;
	background-color: #28a745;
	border: none;
	transition: background-color 0.3s ease, transform 0.3s ease;
}

.btn-success:hover {
	background-color: #218838;
	transform: scale(1.05); /* Button enlarges slightly on hover */
}


/* Slide-in animation for the container */
@
keyframes slideIn {from { opacity:0;
	transform: translateY(-30px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}

/* Responsive adjustments */
@media ( max-width : 768px) {
	.contain {
		width: 90%;
		height: auto;
		padding: 20px;
	}
	h1 {
		font-size: 1.5rem;
	}
	.btn-success {
		font-size: 1rem;
		padding: 8px 16px;
	}
}
</style>
</head>
<body>
	<div class="contain">
		<h1>Sell-Admin-Login <br> <br>Successful!</h1>
	
	 <br>
		<a href="gosell_admin">
			<button type="button" class="btn btn-success">Enter</button>
		</a>
	</div>

	<!-- Bootstrap JS (Optional) -->
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js"
		integrity="sha384-oBqDVmMz4fnFO9gyb4ITdHpZVupSbNQEk3S69XtXhJRaN8DnsfD8zI5Qf8L6EL2i"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"
		integrity="sha384-cn7l7gDp0eyq7Hf3FP1vn6kgcIB9K4tBTvsc1x3BBSWEv+uEmeomI5HNqEFYBb9E"
		crossorigin="anonymous"></script>
</body>
</html>