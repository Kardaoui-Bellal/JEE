package com.example.models;

import java.math.BigDecimal;
import java.util.Date;

public class Revenu extends com.example.models.Transaction {

    private String source;

    public Revenu() {
        super();
    }

    public Revenu(int id, BigDecimal montant, Date date, String description, String source) {
        super(id, montant, date, description);
        this.source = source;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }
}
