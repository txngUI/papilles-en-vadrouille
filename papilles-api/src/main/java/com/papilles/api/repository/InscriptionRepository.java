package com.papilles.api.repository;

import com.papilles.api.domain.entity.Inscription;
import com.papilles.api.domain.entity.User;
import com.papilles.api.domain.enums.StatusAction;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface InscriptionRepository extends JpaRepository<Inscription, Integer> {
    boolean existsByUserAndStatus(User user, StatusAction status);
}
