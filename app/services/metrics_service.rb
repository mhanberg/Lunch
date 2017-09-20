class MetricsService
  def initialize(meals)
    @meals = [meals].flatten
  end

  def meals_average
    ratings = @meals.map(&:ratings).flatten

    avg = avg(ratings)
    if avg.nan?
      'No score available'
    else
      avg
    end
  end

  def available_responses_pie_chart
    result = {
      data: [0, 0, 0, 0, 0, 0],
      labels: [Rating.scores.keys, 'No Response'].flatten
    }

    @meals.each do |meal|
      meal.ratings.each do |rating|
        result[:data][rating.score] += 1
      end.empty? && begin
        result[:data][5] += 1
      end
    end

    result
  end

  def meal_type_histogram
    result = { data: [], labels: Meal.categories.keys }

    Meal.categories.keys.each do |category|
      result[:data] << avg(@meals.select { |m| m.send("#{category}?") }.map(&:ratings).flatten)
    end

    result
  end

  def line_chart
    ratings = Rating.joins(:meal)
                    .group(:meal_date)
                    .order('meals.meal_date')
                    .where(meal: @meals)
                    .select('avg(ratings.score) as average, meals.meal_date')
    {
      data: ratings.map { |r| { y: r.average, x: r.meal_date } },
      labels: Rating.scores.invert
    }
  end

  private

  def avg(ratings)
    (ratings.sum(&:score) / ratings.size.to_f).round(2)
  end
end
