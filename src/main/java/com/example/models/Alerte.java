package com.example.models;

import java.util.Date;

public class Alerte {
    private int id;
    private String message;
    private Date date;
    private boolean lue;

    public Alerte() {}

    public Alerte(int id, String message, Date date, boolean lue) {
        this.id = id;
        this.message = message;
        this.date = date;
        this.lue = lue;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public Date getDate() { return date; }
    public void setDate(Date date) { this.date = date; }

    public boolean isLue() { return lue; }
    public void setLue(boolean lue) { this.lue = lue; }
}