package tasktrack.models;

public class Admin extends User {
    public Admin(int id, String name, String email, String password) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.password = password;
    }

    public void manageCourse(Course course) {
        System.out.println("Mengelola course: " + course.getName());
    }

    public void assignRole(User user) {
        System.out.println("Memberikan role ke user: " + user.getName());
    }

    @Override
    public boolean login() {
        System.out.println(name + " login sebagai Admin");
        return true;
    }
}
