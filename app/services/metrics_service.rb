class MetricsService
    def MetricsService.average meal
        ratings = meal.ratings.to_a
        @avg = ratings.sum { |r| r.score } / ratings.size.to_f
    end
end
