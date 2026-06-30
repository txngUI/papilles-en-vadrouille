package com.papilles.api.domain.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "favourites", uniqueConstraints = @UniqueConstraint(columnNames = {
        "user_id", "restaurant_id"
}))
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Favourite {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "favourite_id")
    private Integer favouriteId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "restaurant_id", nullable = false)
    private Restaurant restaurant;
}
