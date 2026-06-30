package com.papilles.api.domain.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "opinions_picture")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OpinionPicture {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "opinion_picture_id")
    private Integer opinionPictureId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "opinion_id", nullable = false)
    private Opinion opinion;

    @Column(nullable = false)
    private String picture;
}
