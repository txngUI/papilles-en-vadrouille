package com.papilles.api.domain.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "categories")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Category {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_category")
    private Integer categoryId;

    @Column(name = "category_name")
    private String categoryName;
}
