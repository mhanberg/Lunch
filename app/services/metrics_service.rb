class MetricsService
  def initialize(meals)
    @meals = [meals].flatten
  end

  def meals_average
    ratings = @meals.map(&:ratings).to_a.flatten

    avg = avg(ratings)
    if avg.nan?
      'No score available'
    else
      avg
    end
  end

  private

  def avg(ratings)
    (ratings.sum(&:score) / ratings.size.to_f).round(2)
  end
end
