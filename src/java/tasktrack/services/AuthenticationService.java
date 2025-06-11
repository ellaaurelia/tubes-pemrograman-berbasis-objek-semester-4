package tasktrack.services;

import tasktrack.models.*;
import tasktrack.exceptions.AuthenticationException;

import java.util.HashMap;
import java.util.Map;

public class AuthenticationService {
    private Map<String, User> userDatabase = new HashMap<>();

    public AuthenticationService() {
        // Tambahkan user dummy untuk testing
        Student student = new Student(1, "Mahasiswa A", "student@example.com", "1234");
        Admin admin = new Admin(2, "Admin A", "admin@example.com", "admin123");
        userDatabase.put(student.getEmail(), student);
        userDatabase.put(admin.getEmail(), admin);
    }

    public User login(String email, String password) throws AuthenticationException {
        if (!userDatabase.containsKey(email)) {
            throw new AuthenticationException("Email tidak ditemukan!");
        }

        User user = userDatabase.get(email);
        if (!user.getPassword().equals(password)) {
            throw new AuthenticationException("Password salah!");
        }

        return user;
    }

    public void register(Student student) throws AuthenticationException {
        if (userDatabase.containsKey(student.getEmail())) {
            throw new AuthenticationException("Email sudah terdaftar!");
        }

        userDatabase.put(student.getEmail(), student);
        System.out.println("Registrasi berhasil untuk " + student.getName());
    }
}
