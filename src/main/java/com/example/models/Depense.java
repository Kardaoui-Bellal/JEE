package com.example.models;

import java.math.BigDecimal;
import java.util.Date;
import jakarta.persistence.*;

@Entity
@DiscriminatorValue("DEPENSE")
public class Depense extends Transaction {

    @Enumerated(EnumType.STRING)
    @Column(name = "mode_paiement")
    private ModePaiement modePaiement;

    public ModePaiement getModePaiement() {
        return modePaiement;
    }

    public void setModePaiement(ModePaiement modePaiement) {
        this.modePaiement = modePaiement;
    }
}
