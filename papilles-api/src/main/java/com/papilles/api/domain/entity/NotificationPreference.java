package com.papilles.api.domain.entity;

import com.papilles.api.domain.enums.NotificationType;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "notifications_preferences")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class NotificationPreference {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "notification_preference_id")
    private Integer notificationPreferenceId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(nullable = false)
    private NotificationType type;

    @Column(nullable = false)
    private boolean enabled;
}