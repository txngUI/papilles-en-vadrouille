package com.papilles.api.repository;

import com.papilles.api.domain.entity.Favourite;
import com.papilles.api.domain.entity.Restaurant;
import com.papilles.api.domain.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FavouriteRepository extends JpaRepository<Favourite, Integer> {
    List<Favourite> findFavouriteByUser(User user);
    boolean existsByUserAndRestaurant(User user, Restaurant restaurant);
    void deleteByUserAndRestaurant(User user, Restaurant restaurant);
}
