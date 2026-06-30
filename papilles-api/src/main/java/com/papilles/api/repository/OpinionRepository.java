package com.papilles.api.repository;

import com.papilles.api.domain.entity.Opinion;
import com.papilles.api.domain.entity.Restaurant;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface OpinionRepository extends JpaRepository<Opinion, Integer> {
    List<Opinion> findOpinionByRestaurant(Restaurant restaurant);
    boolean existsByUserUserIdAndRestaurantRestaurantId(Integer userId, Integer restaurantId);
    @Query("SELECT AVG(o.rate) FROM Opinion o WHERE o.restaurant.restaurantId = :restaurantId AND o.deletedAt IS NULL")
    Optional<Double> findAverageRateByRestaurantId(@Param("restaurantId") Integer restaurantId);
}
