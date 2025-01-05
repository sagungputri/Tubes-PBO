package models;

public abstract class Person {
    protected String username;
    protected String role;

    public Person(String username, String role) {
        this.username = username;
        this.role = role;
    }

    public String getUsername() {
        return username;
    }

    public String getRole() {
        return role;
    }

    public abstract void accessFeatures();
}

