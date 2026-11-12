package com.example.models;

import java.math.BigDecimal;
import java.util.Date;

public class Depense extends com.example.models.Transaction {
    private String modePaiement;

    public Depense() {
        super();
    }

    public Depense(int id, BigDecimal montant, Date date, String description, String modePaiement) {
        super(id, montant, date, description);
        this.modePaiement = modePaiement;
    }

    public String getModePaiement() { return modePaiement; }
    public void setModePaiement(String modePaiement) { this.modePaiement = modePaiement; }
}