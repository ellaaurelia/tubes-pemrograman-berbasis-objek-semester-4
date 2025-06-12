package tasktrack.models;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

public class ToDoList {
    private Student student;
    private List<Assignment> assignments;

    public ToDoList(Student student) {
        this.student = student;
        this.assignments = new ArrayList<>();
    }

    public void addAssignment(Assignment assignment) {
        assignments.add(assignment);
    }

    public void showSortedAssignments() {
        assignments.sort(Comparator.comparing(Assignment::getDeadline));
        for (Assignment a : assignments) {
            System.out.println(a.getTitle() + " - Deadline: " + a.getDeadline());
        }
    }
}
