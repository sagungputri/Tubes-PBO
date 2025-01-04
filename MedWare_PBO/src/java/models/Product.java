package models;

import java.sql.*;
import java.util.ArrayList;

public class Product extends Model<Product> {
    private int id;
    private String name;
    private double price;
    private int stock;
    private String composition;
    private String code;
    private String description;
    private String image;
    private Date expiredDate;
    private String sideEffects;

    public Product() {
        this.table = "product";
        this.primaryKey = "id";
        this.composition = "";
        this.description = "";
        this.code = "";
        this.image = "";
        this.sideEffects = "";
    }

    public Product(int id, String name, double price, int stock, String composition, String code, String description, String image, Date expiredDate, String sideEffects) {
        this.table = "product";
        this.primaryKey = "id";
        this.id = id;
        this.name = name;
        this.price = price;
        this.stock = stock;
        this.composition = composition;
        this.code = code;
        this.description = description;
        this.image = image;
        this.expiredDate = expiredDate;
        this.sideEffects = sideEffects;
    }

    @Override
    public Product toModel(ResultSet rs) {
        try {
            return new Product(
                rs.getInt("id"),
                rs.getString("name"),
                rs.getDouble("price"),
                rs.getInt("stock"),
                rs.getString("composition"),
                rs.getString("code"),
                rs.getString("description"),
                rs.getString("image"),
                rs.getDate("expiredDate"),
                rs.getString("sideEffects")
            );
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
            return null;
        }
    }

    // Getter dan Setter
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public String getComposition() {
        return composition;
    }

    public void setComposition(String composition) {
        this.composition = composition;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Date getExpiredDate() {
        return expiredDate;
    }

    public void setExpiredDate(Date expiredDate) {
        this.expiredDate = expiredDate;
    }

    public String getSideEffects() {
        return sideEffects;
    }

    public void setSideEffects(String sideEffects) {
        this.sideEffects = sideEffects;
    }

    // Method untuk mencari produk berdasarkan kata kunci
    public ArrayList<Product> search(String keyword) {
        ArrayList<Product> results = new ArrayList<>();
        try {
            connect();
            String query = "SELECT * FROM " + table + " WHERE name LIKE ? OR description LIKE ? OR code LIKE ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            String likeQuery = "%" + keyword + "%";
            pstmt.setString(1, likeQuery);
            pstmt.setString(2, likeQuery);
            pstmt.setString(3, likeQuery);

            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                results.add(toModel(rs));
            }
        } catch (SQLException e) {
            System.out.println("Search Error: " + e.getMessage());
        } finally {
            disconnect();
        }
        return results;
    }
}
