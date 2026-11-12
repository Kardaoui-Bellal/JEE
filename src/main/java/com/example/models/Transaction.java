package com.example.models;

import java.math.BigDecimal;
import java.util.Date;

public abstract class Transaction {

    protected int id;
    protected BigDecimal montant;
    protected Date date;
    protected String description;

    public Transaction() {
    }

    public Transaction(int id, BigDecimal montant, Date date, String description) {
        this.id = id;
        this.montant = montant;
        this.date = date;
        this.description = description;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public BigDecimal getMontant() {
        return montant;
    }

    public void setMontant(BigDecimal montant) {
        this.montant = montant;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
