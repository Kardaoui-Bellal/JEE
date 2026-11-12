package com.example.models;

import jakarta.persistence.*;

@Entity
@DiscriminatorValue("REVENU")
public class Revenu extends Transaction {

    @Column(length = 100)
    private String source;

    public String getSource() { return source; }
    public void setSource(String source) { this.source = source; }
}
