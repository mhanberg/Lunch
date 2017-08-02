class MetricsController < ApplicationController
  def response_pie
    render json: MetricsService.new(Meal.all.to_a).available_responses_pie_chart
  end
end
