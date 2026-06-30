package com.papilles.api.repository;

import com.papilles.api.domain.entity.Notification;
import com.papilles.api.domain.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface NotificationRepository extends JpaRepository<Notification, Integer> {

    List<Notification> findNotificationByUser(User user);
    long countByUserAndIsReadFalse(User user);
}
