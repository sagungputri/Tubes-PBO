package models;

public class Admin extends Person {

    public Admin(String username) {
        super(username, "admin");
    }

    public void accessAdminFeatures() {
        System.out.println("Admin memiliki akses penuh.");
    }
}
