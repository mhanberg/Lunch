class MetricsController < ApplicationController
  def response_pie
    response = MetricsService.new(past_meals).available_responses_pie_chart

    render json: response
  end

  def meal_type_histogram
    response = MetricsService.new(past_meals).meal_type_histogram

    render json: response
  end

  def line_chart
    response = MetricsService.new(past_meals.order(:meal_date)).line_chart

    render json: response
  end

  private

  def past_meals
    Meal.where('meal_date <= ?', Date.today)
        .where(group: current_user.default_group)
        .includes(:ratings)
  end
end
