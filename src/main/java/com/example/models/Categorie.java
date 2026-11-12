package com.example.models;

public class Categorie {
    private int id;
    private String nom;
    private String type;
    private String couleur;

    public Categorie() {
    }

    public Categorie(int id, String nom, String type, String couleur) {
        this.id = id;
        this.nom = nom;
        this.type = type;
        this.couleur = couleur;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getCouleur() {
        return couleur;
    }

    public void setCouleur(String couleur) {
        this.couleur = couleur;
    }
}
