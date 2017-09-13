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

  private

  def avg(ratings)
    (ratings.sum(&:score) / ratings.size.to_f).round(2)
  end
end
