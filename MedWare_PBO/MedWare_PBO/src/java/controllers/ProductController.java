package controllers;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import models.Product;

@WebServlet(name = "ProductController", urlPatterns = {"/product"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class ProductController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);

        // cek user apakah udh login
        if (session.getAttribute("user") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        String menu = request.getParameter("menu");

        if (menu == null || menu.isEmpty()) {
            response.sendRedirect("product?menu=view");
            return;
        }

        Product productModel = new Product();

        switch (menu) {
            case "view":
                String searchQuery = request.getParameter("search");
                ArrayList<Product> products;

                if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                    products = productModel.search(searchQuery); 
                } else {
                    products = productModel.get(); 
                }

                request.setAttribute("products", products);
                request.getRequestDispatcher("/product/view.jsp").forward(request, response);
                break;

            case "viewdetails":
                String id = request.getParameter("id");
                Product product = productModel.find(id);

                if (product != null) {
                    request.setAttribute("product", product);
                    request.getRequestDispatcher("/product/viewdetails.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Produk tidak ditemukan.");
                    request.getRequestDispatcher("/product/view.jsp").forward(request, response);
                }
                break;

            case "add":
                request.getRequestDispatcher("/product/add.jsp").forward(request, response);
                break;

            case "edit":
                id = request.getParameter("id");
                product = productModel.find(id);
                if (product != null) {
                    request.setAttribute("product", product);
                    request.getRequestDispatcher("/product/edit.jsp").forward(request, response);
                } else {
                    response.sendRedirect("product?menu=view");
                }
                break;

            default:
                response.sendRedirect("product?menu=view");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        String action = request.getParameter("action");
        Product productModel = new Product();

        try {
            switch (action) {
                case "add":
                    handleAddProduct(request, response, productModel);
                    break;

                case "edit":
                    handleEditProduct(request, response, productModel);
                    break;

                case "delete":
                    handleDeleteProduct(request, response, productModel);
                    break;

                default:
                    response.sendRedirect("product?menu=view");
                    return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error: " + e.getMessage());
        }
    }

    private void handleAddProduct(HttpServletRequest request, HttpServletResponse response, Product productModel)
            throws Exception {
        String name = request.getParameter("nama");
        double price = Double.parseDouble(request.getParameter("harga"));
        int stock = Integer.parseInt(request.getParameter("stok"));
        String code = request.getParameter("kode");
        String composition = request.getParameter("komposisi");
        String description = request.getParameter("deskripsi");
        String expiredDate = request.getParameter("expiredDate");
        String sideEffects = request.getParameter("sideEffects");

        Date sqlExpiredDate = null;
        if (expiredDate != null && !expiredDate.isEmpty()) {
            sqlExpiredDate = Date.valueOf(expiredDate); 
        }

        Part filePart = request.getPart("image");
        if (filePart == null || filePart.getSize() == 0) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Image file is required.");
            return;
        }

        String fileName = filePart.getSubmittedFileName();
        String uploadPath = getServletContext().getRealPath("") + "uploads";
        java.io.File uploadDir = new java.io.File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir(); 
        }

        String filePath = uploadPath + java.io.File.separator + fileName;
        filePart.write(filePath);

        productModel.setName(name);
        productModel.setPrice(price);
        productModel.setStock(stock);
        productModel.setCode(code);
        productModel.setComposition(composition);
        productModel.setDescription(description);
        productModel.setImage(fileName);
        productModel.setExpiredDate(sqlExpiredDate);
        productModel.setSideEffects(sideEffects);
        productModel.insert();

        response.sendRedirect("product?menu=view");
    }

    private void handleEditProduct(HttpServletRequest request, HttpServletResponse response, Product productModel)
        throws Exception {
    int id = Integer.parseInt(request.getParameter("id"));
    String name = request.getParameter("nama");
    double price = Double.parseDouble(request.getParameter("harga"));
    int stock = Integer.parseInt(request.getParameter("stok"));
    String code = request.getParameter("kode");
    String composition = request.getParameter("komposisi");
    String description = request.getParameter("deskripsi");
    String expiredDate = request.getParameter("expiredDate");
    String sideEffects = request.getParameter("sideEffects");

    Date sqlExpiredDate = null;
    if (expiredDate != null && !expiredDate.isEmpty()) {
        sqlExpiredDate = Date.valueOf(expiredDate); 
    }

    Product oldProduct = productModel.find(String.valueOf(id));

    Part filePart = request.getPart("image");
    String fileName = oldProduct != null ? oldProduct.getImage() : null; // Gambar lama
    if (filePart != null && filePart.getSize() > 0) {
        fileName = filePart.getSubmittedFileName();
        String uploadPath = getServletContext().getRealPath("") + "uploads";
        java.io.File uploadDir = new java.io.File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir(); 
        }
        String filePath = uploadPath + java.io.File.separator + fileName;
        filePart.write(filePath); // gambar baru 
    }


    productModel.setId(id);
    productModel.setName(name);
    productModel.setPrice(price);
    productModel.setStock(stock);
    productModel.setCode(code);
    productModel.setComposition(composition);
    productModel.setDescription(description);
    productModel.setImage(fileName); 
    productModel.setExpiredDate(sqlExpiredDate);
    productModel.setSideEffects(sideEffects);
    productModel.update();

    response.sendRedirect("product?menu=view");
}


    private void handleDeleteProduct(HttpServletRequest request, HttpServletResponse response, Product productModel)
            throws Exception {
        if (!"POST".equalsIgnoreCase(request.getMethod())) {
            response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "Invalid request method.");
            return;
        }

        int id = Integer.parseInt(request.getParameter("id"));
        productModel.setId(id);
        productModel.delete();

        response.sendRedirect("product?menu=view");
    }
}
