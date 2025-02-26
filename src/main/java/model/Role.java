package model;

public class Role {
    private int معرف_الدور;
    private String اسمالدور;
    private String وصفالدور;

    public Role() {
    }

    public Role(int معرف_الدور, String اسمالدور, String وصفالدور) {
        this.معرف_الدور = معرف_الدور;
        this.اسمالدور = اسمالدور;
        this.وصفالدور = وصفالدور;
    }

    public int getMعرف_الدور() {
        return معرف_الدور;
    }

    public void setMعرف_الدور(int معرف_الدور) {
        this.معرف_الدور = معرف_الدور;
    }

    public String getاسمالدور() {
        return اسمالدور;
    }

    public void setاسمالدور(String اسمالدور) {
        this.اسمالدور = اسمالدور;
    }

    public String getوصفالدور() {
        return وصفالدور;
    }

    public void setوصفالدور(String وصفالدور) {
        this.وصفالدور = وصفالدور;
    }
}