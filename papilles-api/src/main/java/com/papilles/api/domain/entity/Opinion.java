package com.papilles.api.domain.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "opinions", uniqueConstraints = @UniqueConstraint(columnNames = {
        "user_id", "restaurant_id"
}))
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Opinion {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "opinion_id")
    private Integer opinionId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "restaurant_id", nullable = false)
    private Restaurant restaurant;

    @Column(nullable = false)
    private Short rate;

    @Column(name = "date_created")
    private LocalDateTime createdAt;

    @Column(length = 200)
    private String content;

    @Column(name = "deleted_at")
    private LocalDateTime deletedAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }

    @OneToMany(mappedBy = "opinion", cascade = CascadeType.ALL, orphanRemoval = true)
    @Builder.Default
    private List<OpinionPicture> pictures = new ArrayList<>();

    @OneToMany(mappedBy = "opinion", cascade = CascadeType.ALL, orphanRemoval = true)
    @Builder.Default
    private List<OpinionLike> likes = new ArrayList<>();
}
