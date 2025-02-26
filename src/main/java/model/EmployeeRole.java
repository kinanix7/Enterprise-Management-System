package model;

import java.sql.Date;

public class EmployeeRole {
    private int معرفالموظف;
    private int معرفالدور;
    private Date تاريخالتعيين;

    // Pour l'affichage dans l'interface
    private String اسمالموظف;
    private String اسمالدور;

    public EmployeeRole() {
    }

    public EmployeeRole(int معرفالموظف, int معرفالدور, Date تاريخالتعيين) {
        this.معرفالموظف = معرفالموظف;
        this.معرفالدور = معرفالدور;
        this.تاريخالتعيين = تاريخالتعيين;
    }

    public int getMعرفالموظف() {
        return معرفالموظف;
    }

    public void setMعرفالموظف(int معرفالموظف) {
        this.معرفالموظف = معرفالموظف;
    }

    public int getMعرفالدور() {
        return معرفالدور;
    }

    public void setMعرفالدور(int معرفالدور) {
        this.معرفالدور = معرفالدور;
    }

    public Date getتاريخالتعيين() {
        return تاريخالتعيين;
    }

    public void setتاريخالتعيين(Date تاريخالتعيين) {
        this.تاريخالتعيين = تاريخالتعيين;
    }

    public String getاسمالموظف() {
        return اسمالموظف;
    }

    public void setاسمالموظف(String اسمالموظف) {
        this.اسمالموظف = اسمالموظف;
    }

    public String getاسمالدور() {
        return اسمالدور;
    }

    public void setاسمالدور(String اسمالدور) {
        this.اسمالدور = اسمالدور;
    }
}