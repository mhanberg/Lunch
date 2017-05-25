class MetricsController < ApplicationController
    def index
        @average = MetricsService.new(Meal.all.to_a).meals_average
    end
    
end
