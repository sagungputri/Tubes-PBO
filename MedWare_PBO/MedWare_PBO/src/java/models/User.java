package models;

public class User extends Person {

    public User(String username) {
        super(username, "user");
    }

    @Override
    public void accessFeatures() {
        System.out.println("User memiliki akses terbatas.");
    }
}
