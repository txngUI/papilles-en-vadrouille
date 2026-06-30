package com.papilles.api.domain.entity;

import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "restaurants")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Restaurant {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "restaurant_id")
    private Integer restaurantId;

    @Column(nullable = false, length = 100)
    private String name;

    @Column(nullable = false, length = 500)
    private String description;

    @Column(length = 100)
    private String website;

    @Column(length = 20)
    private String phone;

    @Column(name = "code_postal")
    private String codePostal;

    @Column(length = 100)
    private String address;

    @Column(length = 100)
    private String city;

    @Column(nullable = false, precision = 10, scale = 7)
    private BigDecimal latitude;

    @Column(nullable = false, precision = 10, scale = 7)
    private BigDecimal longitude;

    @Column(length = 100)
    private String country;

    @Column(name = "address_complementary", length = 100)
    private String addressComplementary;

    @Column(length = 200)
    private String picture;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category", nullable = false)
    private Category category;

    @Column(name = "price_min")
    private Integer minPrice;

    @Column(name = "price_max")
    private Integer maxPrice;

    @Column(name = "date_created")
    private LocalDateTime createdAt;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "created_by", nullable = false)
    private User createdBy;

    @Column(name = "deleted_at")
    private LocalDateTime deletedAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }
}
