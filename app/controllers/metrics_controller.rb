class MetricsController < ApplicationController
  def response_pie
    response = MetricsService.new(past_meals).available_responses_pie_chart

    render json: response
  end

  def meal_type_histogram
    response = MetricsService.new(past_meals).meal_type_histogram

    render json: response
  end

  private

  def past_meals
    groups = GroupsUser.where(user: current_user).map(&:group)
    Meal.where('meal_date < ?', Date.today)
        .where(group: groups)
        .includes(:ratings)
  end
end
