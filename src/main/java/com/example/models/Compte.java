package com.example.models;

import java.math.BigDecimal;

public class Compte {
    private int id;
    private String nom;
    private BigDecimal solde;
    private String devise;

    public Compte() {}

    public Compte(int id, String nom, BigDecimal solde, String devise) {
        this.id = id;
        this.nom = nom;
        this.solde = solde != null ? solde : BigDecimal.ZERO;
        this.devise = devise;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public BigDecimal getSolde() { return solde; }
    public void setSolde(BigDecimal solde) { this.solde = solde; }

    public String getDevise() { return devise; }
    public void setDevise(String devise) { this.devise = devise; }
}