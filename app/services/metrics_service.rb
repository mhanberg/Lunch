class MetricsService
    def MetricsService.meal_average meal
        ratings = meal.ratings.to_a
        @avg = ratings.sum { |r| r.score } / ratings.size.to_f
    end

    def MetricsService.meals_average meals
        return nil
    end
    

end
