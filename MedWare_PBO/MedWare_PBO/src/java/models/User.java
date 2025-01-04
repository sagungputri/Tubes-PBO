package models;

public class User extends Person {

    public User(String username) {
        super(username, "user");
    }

    public void accessLimitedFeatures() {
        System.out.println("User memiliki akses terbatas.");
    }
}
