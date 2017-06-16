class MetricsService
    def initialize meals
        @meals = [meals].flatten
    end
    
    def meals_average
        ratings = @meals.map { |meal| meal.ratings }.to_a.flatten

        avg = avg(ratings)
        unless avg.nan?
            avg
        else
            "No score available"
        end

    end
    
    private
        def avg ratings
            (ratings.sum { |r| r.score } / ratings.size.to_f).round(2)
        end
end
