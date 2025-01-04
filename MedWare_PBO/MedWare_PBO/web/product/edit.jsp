<%@page import="models.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <title>Edit Barang</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            color: #DC5858;
            font-family: Arial, sans-serif;
        }
        .card {
            border: 1px solid #DC5858;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .card-header {
            background-color: #DC5858;
            color: white;
        }
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
        }
        .btn-warning {
            background-color: #DC5858;
            color: white;
        }
        .btn-warning:hover {
            opacity: 0.8;
        }
    </style>
</head>
<body>
    <%
        Product product = (Product) request.getAttribute("product");
        if (product == null) {
    %>
        <div class="container my-5">
            <div class="alert alert-danger text-center">
                <h4>Data barang tidak ditemukan.</h4>
                <a href="product?menu=view" class="btn btn-secondary mt-3">Kembali ke Dashboard</a>
            </div>
        </div>
    <%
        } else {
    %>
    <div class="container my-5">
        <div class="card shadow">
            <div class="card-header text-center">
                <h2>Edit Barang</h2>
            </div>
            <div class="card-body">
                <form method="POST" action="product" enctype="multipart/form-data">
                    <input type="hidden" name="action" value="edit">
                    <input type="hidden" name="id" value="<%= product.getId() %>">
                    <input type="hidden" name="currentImage" value="<%= product.getImage() %>">

                    <!-- input nama  -->
                    <div class="form-floating mb-3">
                        <input 
                            type="text" 
                            class="form-control" 
                            id="namaBarang" 
                            name="nama" 
                            value="<%= product.getName() %>" 
                            required>
                        <label for="namaBarang">Nama Barang</label>
                    </div>

                    <!-- input harga -->
                    <div class="form-floating mb-3">
                        <input 
                            type="number" 
                            class="form-control" 
                            id="hargaBarang" 
                            name="harga" 
                            value="<%= product.getPrice() %>" 
                            step="0.01" 
                            required>
                        <label for="hargaBarang">Harga Barang</label>
                    </div>

                    <!-- input stok -->
                    <div class="form-floating mb-3">
                        <input 
                            type="number" 
                            class="form-control" 
                            id="stokBarang" 
                            name="stok" 
                            value="<%= product.getStock() %>" 
                            required>
                        <label for="stokBarang">Stok Barang</label>
                    </div>

                    <!-- input kode-->
                    <div class="form-floating mb-3">
                        <input 
                            type="text" 
                            class="form-control" 
                            id="kodeBarang" 
                            name="kode" 
                            value="<%= product.getCode() %>" 
                            required>
                        <label for="kodeBarang">Kode Barang</label>
                    </div>

                    <!--input komposisi -->
                    <div class="form-floating mb-3">
                        <textarea 
                            class="form-control" 
                            id="komposisiBarang" 
                            name="komposisi" 
                            rows="3"
                            style="height: 100px;"><%= product.getComposition() %></textarea>
                        <label for="komposisiBarang">Komposisi Barang</label>
                    </div>

                    <!-- inpit deskripsi -->
                    <div class="form-floating mb-3">
                        <textarea 
                            class="form-control" 
                            id="deskripsiBarang" 
                            name="deskripsi" 
                            rows="3"
                            style="height: 100px;"><%= product.getDescription() %></textarea>
                        <label for="deskripsiBarang">Deskripsi Barang</label>
                    </div>

                    <!--input kadarluwarsa -->
                    <div class="form-floating mb-3">
                        <input 
                            type="date" 
                            class="form-control" 
                            id="expiredDate" 
                            name="expiredDate" 
                            value="<%= product.getExpiredDate() != null ? product.getExpiredDate().toString() : "" %>" 
                            required>
                        <label for="expiredDate">Tanggal Expired</label>
                    </div>

                    <!-- input efek samping-->
                    <div class="form-floating mb-3">
                        <textarea 
                            class="form-control" 
                            id="sideEffects" 
                            name="sideEffects" 
                            rows="3"
                            style="height: 100px;"><%= product.getSideEffects() %></textarea>
                        <label for="sideEffects">Efek Samping</label>
                    </div>

                    <!-- inpiut gambar baru -->
                    <div class="mb-3">
                        <label for="image" class="form-label">Gambar Barang</label>
                        <% if (product.getImage() != null && !product.getImage().isEmpty()) { %>
                            <img src="<%= request.getContextPath() %>/uploads/<%= product.getImage() %>" class="img-thumbnail d-block mb-3" style="max-width: 200px;">
                        <% } %>
                        <input type="file" class="form-control" id="image" name="image" accept="image/*">
                    </div>

                    <div class="d-flex justify-content-between">
                        <a href="product?menu=view" class="btn btn-secondary btn-lg">Kembali</a>
                        <button type="submit" class="btn btn-warning btn-lg">Simpan Perubahan</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <%
        }
    %>
</body>
</html>
