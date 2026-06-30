package com.papilles.api.domain.entity;

import com.papilles.api.domain.enums.StatusAction;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "inscriptions")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Inscription {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "inscription_id")
    private Integer inscriptionId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(name = "date_asked", nullable = false)
    private LocalDateTime askedDate;

    @Column()
    private String reason;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private StatusAction status;

    @PrePersist
    protected void onCreate() {
        askedDate = LocalDateTime.now();
    }
}
