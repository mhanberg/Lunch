require 'rails_helper'

describe MetricsService do
  context 'meal average' do
    before do
      @meals = create_list(:meal, 3)
      @rating1 = create(:rating, score: 0, meal: @meals[0])
      @rating2 = create(:rating, score: 3, meal: @meals[0])
      @rating3 = create(:rating, score: 4, meal: @meals[0])
      @rating4 = create(:rating, score: 3, meal: @meals[0])

      @rating5 = create(:rating, score: 4, meal: @meals[1])
      @rating6 = create(:rating, score: 3, meal: @meals[1])
      @rating7 = create(:rating, score: 1, meal: @meals[1])
    end

    it 'should calculate the average rating of a single meal' do
      result = MetricsService.new(@meals[0]).meals_average

      expect(result).to eq(2.5)
    end

    it 'should calculate the average rating of a set of meals' do
      expected = (18.0 / 7.0).round(2)

      result = MetricsService.new(@meals).meals_average

      expect(result).to eq(expected)
    end

    it 'should not fail when a single meal has no ratings' do
      expect(MetricsService.new(@meals[2]).meals_average).to eq('No score available')
    end
  end

  context 'pie chart' do
    it 'calculates it right' do
      meal = create :meal
      rating = create :rating, score: 2, meal: meal

      expected_chart = {
        'no_response' => 0,
        '0' => 0,
        '1' => 0,
        '2' => 1,
        '3' => 0,
        '4' => 0
      }

      result = MetricsService.new(meal).available_responses_pie_chart

      expect(result).to eq(expected_chart)
    end

    it 'accounts for lack of responses' do
      meals = create_list :meal, 3
      rating = create :rating, score: 2, meal: meals[0]

      expected_chart = {
        'no_response' => 2,
        '0' => 0,
        '1' => 0,
        '2' => 1,
        '3' => 0,
        '4' => 0
      }

      result = MetricsService.new(meals).available_responses_pie_chart

      expect(result).to eq(expected_chart)
    end
  end
end
