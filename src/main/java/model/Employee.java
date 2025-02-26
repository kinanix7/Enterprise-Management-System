package model;

public class Employee {
    private int معرفالموظف;
    private String الاسم;
    private String البريدالإلكتروني;

    public Employee() {
    }

    public Employee(int معرفالموظف, String الاسم, String البريدالإلكتروني) {
        this.معرفالموظف = معرفالموظف;
        this.الاسم = الاسم;
        this.البريدالإلكتروني = البريدالإلكتروني;
    }

    public int getMعرفالموظف() {
        return معرفالموظف;
    }

    public void setMعرفالموظف(int معرفالموظف) {
        this.معرفالموظف = معرفالموظف;
    }

    public String getالاسم() {
        return الاسم;
    }

    public void setالاسم(String الاسم) {
        this.الاسم = الاسم;
    }

    public String getالبريدالإلكتروني() {
        return البريدالإلكتروني;
    }

    public void setالبريدالإلكتروني(String البريدالإلكتروني) {
        this.البريدالإلكتروني = البريدالإلكتروني;
    }
}