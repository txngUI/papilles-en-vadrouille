package com.papilles.api.repository;

import com.papilles.api.domain.entity.Opinion;
import com.papilles.api.domain.entity.OpinionLike;
import com.papilles.api.domain.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface OpinionLikeRepository extends JpaRepository<OpinionLike, Integer> {
    boolean existsByUserAndOpinion(User user, Opinion opinion);
    void deleteByUserAndOpinion(User user, Opinion opinion);
}
