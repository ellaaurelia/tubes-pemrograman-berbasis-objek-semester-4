package tasktrack.services;

import tasktrack.interfaces.Manageable;
import tasktrack.models.*;

public class AdminPanel implements Manageable {
    private Admin admin;

    public AdminPanel(Admin admin) {
        this.admin = admin;
    }

    public void addCourse(Course course) {
        System.out.println("Course ditambahkan: " + course.getName());
    }

    public void editCourse(Course course) {
        System.out.println("Edit course: " + course.getName());
    }

    public void deleteCourse(Course course) {
        System.out.println("Course dihapus: " + course.getName());
    }

    public void assignRole(User user) {
        System.out.println("Role diberikan ke " + user.getName());
    }

    public void addAssignment(Course course, Assignment assignment) {
        course.addAssignment(assignment);
        System.out.println("Assignment ditambahkan ke " + course.getName());
    }

    public void viewStudentProgress(Student student) {
        student.checkProgress();
    }

    @Override
    public void add(Object item) {
        System.out.println("Item ditambahkan.");
    }

    @Override
    public void edit(Object item) {
        System.out.println("Item diedit.");
    }

    @Override
    public void delete(Object item) {
        System.out.println("Item dihapus.");
    }
}
