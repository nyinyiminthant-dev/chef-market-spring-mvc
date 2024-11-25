package com.spring.controller;

import org.springframework.beans.factory.annotation.Autowired; 
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.model.OrderBean;
import com.spring.model.PaymentBean;
import com.spring.model.ProductBean;
import com.spring.model.UserBean;
import com.spring.repository.Order_Repo;
import com.spring.repository.PaymentRepo;
import com.spring.repository.ProductRepository;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;



@Controller
public class OrderController {
	
    @Autowired
    private PaymentRepo payrepo;
    
    @Autowired
    private Order_Repo orep;
    
    @Autowired
    private ProductRepository productRepository;
    

    @PostMapping("/placeOrder")
    public String placeOrder(@RequestParam("address") String address, HttpSession session, Model model) {
        System.out.println("Placing order...");

        List<ProductBean> cartItems = (List<ProductBean>) session.getAttribute("cartItems");
        if (cartItems == null || cartItems.isEmpty()) {
            System.out.println("Cart is empty.");
            model.addAttribute("message", "Your cart is empty!");
            return "redirect:/viewCart";
        }


        double totalAmount = cartItems.stream().mapToDouble(item -> item.getP_price() * item.getP_quantity()).sum();

        
        PaymentBean payment = new PaymentBean();
        payment.setAmount(totalAmount);
    
        
        OrderBean order = new OrderBean();
        order.setO_code("ORDER_" + System.currentTimeMillis());
        order.setDate_time(new Date());
        order.setPrice(totalAmount);
       
        order.setProducts(cartItems); 

       
        session.setAttribute("orderList", List.of(order)); 
        session.setAttribute("totalAmount", totalAmount); 
        session.setAttribute("address", address);
      
        session.removeAttribute("cartItems"); 
        model.addAttribute("message", "Order placed successfully!");

        return "redirect:/viewOrders";
    }

    @GetMapping("/viewOrders")
    public String viewOrders(HttpSession session, Model model) {
       
        List<OrderBean> orderList = (List<OrderBean>) session.getAttribute("orderList");
        Double totalAmount = (Double) session.getAttribute("totalAmount");
        String address = (String) session.getAttribute("address");

        model.addAttribute("orderList", orderList);
        model.addAttribute("totalAmount", totalAmount);
        model.addAttribute("address", address);

        return "order"; 
    }
    
    @GetMapping(value = "/viewo")
    public String goViewOrder(HttpSession session, Model model) {
        List<OrderBean> orderList = (List<OrderBean>) session.getAttribute("orderList");
        if (orderList == null || orderList.isEmpty()) {
            model.addAttribute("message", "No orders found.");
        } else {
            model.addAttribute("orderList", orderList);
        }

        return "viewOrders"; 
    }

    @PostMapping("/confirmOrder")
    public String confirmOrder(HttpSession session, RedirectAttributes redirectAttributes,
                               @RequestParam("address") String address, @RequestParam("pay_id") int payId) {
        List<ProductBean> cartItems = (List<ProductBean>) session.getAttribute("cartItems");

        if (cartItems == null || cartItems.isEmpty()) {
            redirectAttributes.addFlashAttribute("message", "Your cart is empty!");
            return "redirect:/viewCart";
        }

        UserBean loggedInUser = (UserBean) session.getAttribute("loggedInUser");

        
        OrderBean order = new OrderBean();
        order.setO_code("ORDER_" + System.currentTimeMillis());
        order.setU_id(loggedInUser.getId());
        order.setDate_time(new Date());
        order.setPrice(cartItems.stream().mapToDouble(item -> item.getP_price() * item.getP_quantity()).sum());
        order.setAddress(address);
        order.setPay_id(payId);
        order.setProducts(cartItems);

        
        session.setAttribute("orderList", List.of(order));

        session.removeAttribute("cartItems"); 
        redirectAttributes.addFlashAttribute("message", "Order placed successfully!");

        return "redirect:/viewOrders";
    }

    
    @PostMapping("/processPayment")
    public String processPayment(HttpSession session,
                                 @ModelAttribute("paymentBean") PaymentBean payment,
                                 @ModelAttribute("productOrder") OrderBean productOrder,
                                 Model model,HttpServletRequest request) {
        Double amount = payment.getAmount();
        String method = payment.getMethod();

      //  System.out.println("Received Payment Method: " + method);

        Integer u_id = (Integer) session.getAttribute("uID");
        if (u_id == null) {
            session.setAttribute("redirectAfterLogin", "/processPayment");
            return "redirect:/login";
        }

        // Save payment and get generated payment ID
        int pay_id = payrepo.savePayment(amount, method);
        if (pay_id > 0) {
            session.setAttribute("payment", payment.getMethod());
           // System.out.println("Payment Successful, Payment ID: " + pay_id);

            List<OrderBean> orderList = (List<OrderBean>) session.getAttribute("orderList");
            if (orderList != null && !orderList.isEmpty()) {
                OrderBean order = orderList.get(0);
                String address = (String) session.getAttribute("address");

                // Insert product order and get generated order ID
                int orderId = orep.insertProductOrder(address, u_id, pay_id);
                if (orderId > 0) {
                    session.setAttribute("o_id", orderId);
                   // System.out.println("Product Order Successful, Order ID: " + orderId);

                    // Insert each product into order details
                    for (ProductBean product : order.getProducts()) {
                        int p_id = product.getId();
                        int quantity = product.getP_quantity();
                        double price = product.getP_price();

                        // Insert product into order details
                        int detailResult = orep.saveOrderDetails(orderId, p_id, quantity, price);
                        if (detailResult > 0) {
                            // Successfully inserted the product into order details
                           // System.out.println("Product order details inserted successfully.");

                            // Update product quantity in the database
                            int currentQuantity = productRepository.getProductQuantityById(p_id);
                            if (currentQuantity >= quantity) {
                                // Calculate the new quantity after order
                                int updatedQuantity = currentQuantity - quantity;
                                boolean isUpdated = productRepository.updateProductQuantity(p_id, updatedQuantity);
                                if (isUpdated) {
                                   // System.out.println("Product quantity updated successfully.");
                                } else {
                                    
                                    model.addAttribute("message", "Failed to update product quantity.");
                                }
                            } else {
                            	model.addAttribute("message", "Not enough stock for product ID: " + p_id);
                               // System.out.println("Not enough stock for product ID: " + p_id);
                            }
                        } else {
                        	model.addAttribute("message", "Failed to insert product into order details.");
                           // System.out.println("Failed to insert product into order details.");
                        }
                    }

                    model.addAttribute("order", order);
                    model.addAttribute("payment", payment);
                    
                } else {
                	model.addAttribute("message", "Failed to insert product order.");
                    //System.out.println("Failed to insert product order.");
                }
            } else {
            	model.addAttribute("message", "No orders found in session.");
               // System.out.println("No orders found in session.");
            }
        } else {
        	model.addAttribute("message", "Payment failed");
            //System.out.println("Payment failed.");
        }
        session.getAttribute("cartItems");
        
        session.removeAttribute("cartItems");
        
        request.setAttribute("successMessage", "Your order has been placed successfully!");
        
        return "viewOrders"; // Error view
    }




    @GetMapping("/proceedToPayment")
    public String proceedToPayment() {
        return "payment"; 
    }


    
    
    
    
    
    
    
    
    
    
    
    
    

	 @GetMapping(value = "/showorder")
	 	public String showAllOrder(Model m) {
	 		List<OrderBean> list = orep.showOrder();

	 		if (list.size() > 0) {
	 			m.addAttribute("orderlist", list);

	 		} else {
	 			m.addAttribute("error", "No Order");
	 		}
	 		
	 		 m.addAttribute("searchUser", new OrderBean());
	 		return "showOrder";
	 	}
	 
	 @GetMapping(value = "/showorder_details")
	 	public String showAllOrderDetails(Model m) {
	 		List<OrderBean> list = orep.showOrderDetails();

	 		if (list.size() > 0) {
	 			m.addAttribute("orderdetailslist", list);

	 		} else {
	 			m.addAttribute("error", "No Order");
	 		}
	 		
	 		 m.addAttribute("searchProduct", new OrderBean());
	 		 m.addAttribute("searchProductByDate", new OrderBean());
	 		return "showOrderDetail";
	 	}
	 
   
	 @PostMapping("/SearchUser")
	 public String searchOrders(@ModelAttribute("searchUser") OrderBean searchUser, Model m) {
	     
	     if (searchUser.getU_email() == null || java.sql.Date.valueOf(searchUser.getSt_date()) == null || java.sql.Date.valueOf(searchUser.getEnd_date()) == null) {
	         m.addAttribute("error", "All fields are required.");
	         return "showOrder"; 
	     }
	     
	     
	     java.sql.Date startDate = java.sql.Date.valueOf(searchUser.getSt_date());
	     java.sql.Date endDate = java.sql.Date.valueOf(searchUser.getEnd_date());

	     List<OrderBean> orders = orep.findOrdersByEmailAndDateRange(searchUser.getU_email(), startDate, endDate);
	     
	     if (orders.isEmpty()) {
	         m.addAttribute("error", "No orders found for the given criteria.");
	     } else {
	         m.addAttribute("orderlist", orders);
	     }

	     return "showOrder"; 
	 }
	 
	 @PostMapping("/SearchProduct")
	 public String searchProduct(@ModelAttribute("searchProduct") OrderBean searchProduct, Model m) {
	     
	   

	     List<OrderBean> orders = orep.findWithProductCodeOrderDetails(searchProduct.getP_code());
	     
	     if (orders.isEmpty()) {
	         m.addAttribute("error", "No Products found for the given criteria.");
	     } else {
	         m.addAttribute("orderdetailslist", orders);
	     }
	     m.addAttribute("searchProductByDate", new OrderBean());
	     return "showOrderDetail"; 
	 }
	 
	 @PostMapping("/SearchProductDate")
	 public String searchProductDate(@ModelAttribute("searchProductByDate") OrderBean searchProductDate, Model m) {
	     
		 java.sql.Date startDate = java.sql.Date.valueOf(searchProductDate.getSt_date());
		 java.sql.Date endDate = java.sql.Date.valueOf(searchProductDate.getEnd_date());

	     List<OrderBean> orders = orep.findWithDateOrderDetails(startDate,endDate);
	     
	     if (orders.isEmpty()) {
	         m.addAttribute("error", "No Products found for the given criteria.");
	     } else {
	         m.addAttribute("orderdetailslist", orders);
	     }
	     m.addAttribute("searchProduct", new OrderBean());
	     return "showOrderDetail"; 
	 }
	 
	 
	 
    }

        
        


