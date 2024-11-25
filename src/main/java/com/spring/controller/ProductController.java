package com.spring.controller;



import java.io.File; 
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.model.*;

import com.spring.repository.*;

@Controller
public class ProductController {

    @Autowired
    ProductRepository productRepository;
    

    @GetMapping("/productForm")
    public ModelAndView showPhoto() {
        ProductBean bean = new ProductBean();
        return new ModelAndView("productForm", "product", bean);
    }

    @GetMapping(value = "/viewProduct")
    public String showProduct(Model model) {
        List<ProductBean> products = productRepository.showProduct();
        model.addAttribute("productList", products);
        return "viewPhoto";
    }
    
    @GetMapping("/products")
    public String index() {
        return "index1"; 
    }

 
    

    
    
    
    
    
    
    

    // Display the list of products
    @GetMapping("/productss")
    public String viewProducts(Model model) {
        List<ProductBean> productList = productRepository.showProduct();
        model.addAttribute("products", productList);
        return "productList"; // JSP page to display products
    }

    @GetMapping(value = "/showproduct")
 	public String showAllProduct(Model m) {
 		List<ProductBean> list = productRepository.showProduct();

 		if (list.size() > 0) {
 			m.addAttribute("productlist", list);

 		} else {
 			m.addAttribute("error", "No Type");
 		}
 		return "showProduct";
 	}
    

    @PostMapping("/showProduct")
    public String addProduct(@ModelAttribute("product") ProductBean productBean, Model model,RedirectAttributes redirectAttrs)
            throws IllegalStateException, IOException, SQLException {

        MultipartFile photo = productBean.getMfphoto();
        if (photo == null || photo.isEmpty()) {
            model.addAttribute("message", "No image uploaded!");
            return "productForm";
        }

        String uploadDir = "D:\\Manvanlesson\\ChefsMarket2\\src\\main\\webapp\\upload";
        File uploadFolder = new File(uploadDir);
        if (!uploadFolder.exists()) {
            uploadFolder.mkdirs();
        }

        String fileName = photo.getOriginalFilename();
        File dest = new File(uploadDir + File.separator + fileName);
        photo.transferTo(dest);
        productBean.setP_photo(fileName);

        if (productRepository.isDuplicateProductName(productBean.getP_name())) {
            model.addAttribute("message", "Error: A product with the same name already exists.");
            return "productForm";
        }

        if (productRepository.isDuplicateProductPhoto(fileName)) {
            model.addAttribute("message", "Error: A product with the same photo already exists.");
            return "productForm";
        }

        int result = productRepository.addProduct(productBean);
        if (result > 0) {
        	redirectAttrs.addFlashAttribute("successMessage", "Product added successfully!");
            return "redirect:/viewProduct";
        } else {
            model.addAttribute("message", "Error: Product upload failed.");
            return "productForm";
        }
    }
    
    @GetMapping(value = "/showproducts")
 	public String showAllProductSell(Model m) {
 		List<ProductBean> list = productRepository.showProduct();

 		if (list.size() > 0) {
 			m.addAttribute("productlist", list);

 		} else {
 			m.addAttribute("error", "No Type");
 		}
 		return "showProduct2";
 	}
    
    @PostMapping("/updateProduct")
    public String updateProduct(@ModelAttribute("product") ProductBean productBean, Model model)
            throws IllegalStateException, IOException {

        MultipartFile photo = productBean.getMfphoto();
        String fileName = productBean.getP_photo();

        if (photo != null && !photo.isEmpty()) {
            fileName = photo.getOriginalFilename();
            String uploadDir = "D:\\Manvanlesson\\ChefsMarket2\\src\\main\\webapp\\upload";
            File dest = new File(uploadDir + File.separator + fileName);
            photo.transferTo(dest);
            productBean.setP_photo(fileName);
        }

        int result = productRepository.updateProduct(productBean);
        if (result > 0) {
            model.addAttribute("message", "Product updated successfully!");
        } else {
            model.addAttribute("message", "Error: Product update failed.");
        }

        return "redirect:/showproducts";
    }

    
    @PostMapping("/updateProducts")
    public String updateProductAdmin(@ModelAttribute("product") ProductBean productBean, Model model)
            throws IllegalStateException, IOException {

        MultipartFile photo = productBean.getMfphoto();
        String fileName = productBean.getP_photo();

        if (photo != null && !photo.isEmpty()) {
            fileName = photo.getOriginalFilename();
            String uploadDir = "D:\\Manvanlesson\\ChefsMarket2\\src\\main\\webapp\\upload";
            File dest = new File(uploadDir + File.separator + fileName);
            photo.transferTo(dest);
            productBean.setP_photo(fileName);
        }

        int result = productRepository.updateProduct(productBean);
        if (result > 0) {
            model.addAttribute("message", "Product updated successfully!");
        } else {
            model.addAttribute("message", "Error: Product update failed.");
        }

        return "redirect:/viewProduct";
    }
    @GetMapping("/editProduct/{id}")
    public String editProduct(@PathVariable("id") int id, Model model) {
        ProductBean product = productRepository.getProductById(id);
        if (product != null) {
            model.addAttribute("product", product);
            return "editProductForm";
        }
        return "redirect:/showproducts";
    }

    @GetMapping("/editProduct2/{id}")
    public String editProducts(@PathVariable("id") int id, Model model) {
        ProductBean product = productRepository.getProductById(id);
        if (product != null) {
            model.addAttribute("product", product);
            return "editProductForm2";
        }
        return "redirect:/viewProduct";
    }


    @PostMapping("/deleteProduct/{id}")
    public String deleteProduct(@PathVariable("id") int id, Model model) {
        int result = productRepository.deleteProduct(id);
        if (result > 0) {
            model.addAttribute("message", "Product deleted successfully!");
        } else {
            model.addAttribute("message", "Error: Product deletion failed.");
        }
        return "redirect:/showproducts";
    }
    
    @PostMapping("/deleteProduct2/{id}")
    public String deleteProducts(@PathVariable("id") int id, Model model) {
        int result = productRepository.deleteProduct(id);
        if (result > 0) {
            model.addAttribute("message", "Product deleted successfully!");
        } else {
            model.addAttribute("message", "Error: Product deletion failed.");
        }
        return "redirect:/viewProduct";
    }

    
    
    @GetMapping("/addToCart")
    public String showAddToCart(Model model, HttpSession session) {       
        List<ProductBean> products = productRepository.showAllProducts();
        model.addAttribute("productList", products);
        return "addToCart";
    }


        @PostMapping("/updateCartQuantity/{id}")
        public String updateCartQuantity(@PathVariable("id") int productId,
                                          @RequestParam("quantity") int quantity,
                                          HttpSession session,
                                          Model model) {
            
            List<ProductBean> cart = (List<ProductBean>) session.getAttribute("cartItems");

            // Retrieve the product by ID
            ProductBean product = productRepository.getProductById(productId);

            // Check if the cart exists
            if (cart != null) {
                
                if (quantity > product.getMaxQuantity()) {
                    model.addAttribute("errorMessage",
                            "Requested quantity exceeds available stock for " + product.getP_name());
                    model.addAttribute("cartItems", productRepository.getCartItems()); // Retrieve all cart items
                    return "viewCart"; // Return the viewCart page with error message
                }

                
                for (ProductBean item : cart) {
                    if (item.getId() == productId) {
                        item.setP_quantity(quantity);
                        break;
                    }
                }

                
                session.setAttribute("cartItems", cart);
                model.addAttribute("message", "Cart updated successfully!");
            } else {
                model.addAttribute("message", "Error: Cart not found.");
            }
            
            
            return "redirect:/viewCart";
        }
        
		
        @PostMapping("/addToCart/{id}")
        public String addToCart(@PathVariable("id") int id,
                                @RequestParam("quantity") int quantity,
                                HttpSession session,
                                Model model, RedirectAttributes redirectAttrs) {
            // Check if the user is logged in
            if (session.getAttribute("loggedInUser") == null) {
            	redirectAttrs.addFlashAttribute("error", "Please login to buy!");
                return "redirect:/login";
            }

            // Retrieve product by ID
            ProductBean product = productRepository.getProductById(id);
            if (product == null) {
                redirectAttrs.addFlashAttribute("error", "Product not found.");
                return "redirect:/productList";
            }

            // Initialize cart and cartProductIds in session if necessary
            List<ProductBean> cart = (List<ProductBean>) session.getAttribute("cartItems");
            Set<Integer> cartProductIds = (Set<Integer>) session.getAttribute("cartProductIds");

            if (cart == null) {
                cart = new ArrayList<>();
                session.setAttribute("cartItems", cart);
            }
            if (cartProductIds == null) {
                cartProductIds = new HashSet<>();
                session.setAttribute("cartProductIds", cartProductIds);
            }

            // Check if the product is already in the cart
            if (cartProductIds.contains(id)) {
                redirectAttrs.addFlashAttribute("error", "This product is already in your cart.");
                return "redirect:/addToCart";
            }

            // Check if adding quantity exceeds max available
            if (quantity > product.getMaxQuantity()) {
                redirectAttrs.addFlashAttribute("error", "You cannot add more than " + product.getMaxQuantity() + " of " + product.getP_name());
                return "redirect:/addToCart";
            }

            // Add product to cart
            product.setP_quantity(quantity);
            cart.add(product);
            cartProductIds.add(id);  // Track the product ID in cartProductIds

            // Update the cart count
            session.setAttribute("cartCount", cart.size());

            // Redirect to the product list or cart page
            return "redirect:/addToCart";
        }
        
        

        @GetMapping("/viewCart")
        public String viewCart(HttpSession session, Model model) {
            List<ProductBean> cartItems = (List<ProductBean>) session.getAttribute("cartItems");
            model.addAttribute("cartItems", cartItems);

            int totalPrice = 0;
            if (cartItems != null) {
                for (ProductBean item : cartItems) {
                    totalPrice += item.getP_price() * item.getP_quantity();
                }
            }
            model.addAttribute("totalPrice", totalPrice);

            return "viewCart"; 
        }
        
		/*
		 * @PostMapping("/removeFromCart/{id}") public String
		 * removeFromCart(@PathVariable("id") int id, HttpSession session, Model model)
		 * { List<ProductBean> cartItems = (List<ProductBean>)
		 * session.getAttribute("cartItems");
		 * 
		 * if (cartItems != null) { cartItems.removeIf(item -> item.getId() == id);
		 * session.setAttribute("cartItems", cartItems);
		 * session.setAttribute("cartCount", cartItems.size()); // Update cart count
		 * after removal model.addAttribute("message", "Product removed from cart!"); }
		 * 
		 * return "redirect:/viewCart"; }
		 */	
        
        @PostMapping("/removeFromCart/{id}")
        public String removeFromCart(@PathVariable("id") int id, HttpSession session) {
            // Retrieve cart items and cart product IDs from the session
            List<ProductBean> cart = (List<ProductBean>) session.getAttribute("cartItems");
            Set<Integer> cartProductIds = (Set<Integer>) session.getAttribute("cartProductIds");

            if (cart != null && cartProductIds != null) {
                // Remove the product from the cart
                cart.removeIf(item -> item.getId() == id);
                
                // Remove the product ID from cartProductIds
                cartProductIds.remove(id);
                
                // Update the session attributes
                session.setAttribute("cartItems", cart);
                session.setAttribute("cartProductIds", cartProductIds);
                session.setAttribute("cartCount", cart.size());

                // Enable the "Add to Cart" button for this product by removing the "addedToCart_" attribute
                session.removeAttribute("addedToCart_" + id);
            }

            return "redirect:/viewCart";
        }


}



