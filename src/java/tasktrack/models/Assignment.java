package tasktrack.models;

import java.util.Date;

public class Assignment {
    private int id;
    private String title;
    private Date deadline;
    private String status;
    private Course course;

    public Assignment(int id, String title, Date deadline, Course course) {
        this.id = id;
        this.title = title;
        this.deadline = deadline;
        this.course = course;
        this.status = "Pending";
    }

    public void markAsDone() {
        this.status = "Done";
    }

    public boolean isLate() {
        return new Date().after(deadline);
    }

    public String getTitle() {
        return title;
    }

    public Date getDeadline() {
        return deadline;
    }
}
