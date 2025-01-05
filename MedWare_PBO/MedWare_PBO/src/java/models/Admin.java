package models;

public class Admin extends Person {

    public Admin(String username) {
        super(username, "admin");
    }

    @Override
    public void accessFeatures() {
        System.out.println("Admin memiliki akses penuh.");
    }
}
