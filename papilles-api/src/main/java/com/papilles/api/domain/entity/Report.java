package com.papilles.api.domain.entity;

import com.papilles.api.domain.enums.StatusAction;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "reports")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Report {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "report_id")
    private Integer reportId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "reported_id", nullable = false)
    private User reportedUser;

    @Column(name = "date_reported", nullable = false)
    private LocalDateTime reportedDate;

    @Column(nullable = false)
    private String reason;

    @Column()
    private String decision;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private StatusAction status;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "opinion_id", nullable = false)
    private Opinion opinion;

    @PrePersist
    protected void onCreate() {
        reportedDate = LocalDateTime.now();
    }
}
