package com.papilles.api.repository;

import com.papilles.api.domain.entity.Restaurant;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface RestaurantRepository extends JpaRepository<Restaurant, Integer> {

    @Query("""
        SELECT r FROM Restaurant r
        WHERE r.deletedAt IS NULL
        AND (:search IS NULL OR LOWER(r.name) LIKE LOWER(CONCAT('%', :search, '%')))
        AND (:categoryId IS NULL OR r.category.categoryId = :categoryId)
        AND (:city IS NULL OR LOWER(r.city) LIKE LOWER(CONCAT('%', :city, '%')))
        AND (:priceMax IS NULL OR r.minPrice <= :priceMax)
    """)
    Page<Restaurant> findAllActive(
            @Param("search") String search,
            @Param("categoryId") Integer categoryId,
            @Param("city") String city,
            @Param("priceMax") Integer priceMax,
            Pageable pageable
    );

    Optional<Restaurant> findByRestaurantIdAndDeletedAtIsNull(Integer id);
}