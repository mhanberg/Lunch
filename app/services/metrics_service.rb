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

  def available_responses_pie_chart
    chart = {
      'no_response' => 0,
      '0' => 0,
      '1' => 0,
      '2' => 0,
      '3' => 0,
      '4' => 0
    }

    @meals.each do |meal|
      meal.ratings.each do |rating|
        chart[rating.score.to_s] += 1
      end.empty? && begin
        chart['no_response'] += 1
      end
    end

    chart
  end

  private

  def avg(ratings)
    (ratings.sum(&:score) / ratings.size.to_f).round(2)
  end
end
