class MetricsController < ApplicationController
  def response_pie
    render json: MetricsService.new(Meal.where('meal_date < ?', Date.today)
                                        .includes(:ratings).to_a)
                               .available_responses_pie_chart
  end
end
