package com.example.models;
import java.math.BigDecimal;

public class Budget {
    private int id;
    private String periode; // Ex: "2026-11"
    private BigDecimal plafond;
    private BigDecimal montantDepense;

    public Budget() {
    }

    public Budget(int id, String periode, BigDecimal plafond, BigDecimal montantDepense) {
        this.id = id;
        this.periode = periode;
        this.plafond = plafond;
        this.montantDepense = montantDepense != null ? montantDepense : BigDecimal.ZERO;
    }

    public boolean verifierDepassement() {
        if (montantDepense == null || plafond == null) {
            return false;
        }
        return montantDepense.compareTo(plafond) > 0;
    }

    public boolean verifierProchePlafond() {
        if (montantDepense == null || plafond == null || plafond.compareTo(BigDecimal.ZERO) == 0) {
            return false;
        }
        BigDecimal seuil = plafond.multiply(new BigDecimal("0.80"));
        return montantDepense.compareTo(seuil) >= 0;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPeriode() {
        return periode;
    }

    public void setPeriode(String periode) {
        this.periode = periode;
    }

    public BigDecimal getPlafond() {
        return plafond;
    }

    public void setPlafond(BigDecimal plafond) {
        this.plafond = plafond;
    }

    public BigDecimal getMontantDepense() {
        return montantDepense;
    }

    public void setMontantDepense(BigDecimal montantDepense) {
        this.montantDepense = montantDepense;
    }
}
