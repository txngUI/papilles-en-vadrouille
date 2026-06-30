package com.papilles.api.domain.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "opinion_like", uniqueConstraints = @UniqueConstraint(columnNames = {
        "user_id", "opinion_id"
}))
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OpinionLike {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "opinion_like_id")
    private Integer opinionLikeId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "opinion_id", nullable = false)
    private Opinion opinion;
}
