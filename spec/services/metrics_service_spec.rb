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
      create :rating, score: 2, meal: meal

      expected_response = { data: [0, 0, 1, 0, 0, 0], labels: [Rating.scores.keys, 'No Response'].flatten }

      result = MetricsService.new(meal).available_responses_pie_chart

      expect(result).to eq(expected_response)
    end

    it 'accounts for lack of responses' do
      meals = create_list :meal, 3
      create :rating, score: 2, meal: meals[0]

      expected_response = { data: [0, 0, 1, 0, 0, 2], labels: [Rating.scores.keys, 'No Response'].flatten }


      result = MetricsService.new(meals).available_responses_pie_chart

      expect(result).to eq(expected_response)
    end
  end

  context 'meal_type_histogram' do
    it 'calculates it right' do
      breakfast = create :meal, category: Meal.categories['Breakfast']
      lunch = create :meal, category: Meal.categories['Lunch']
      dinner = create :meal, category: Meal.categories['Dinner']

      create :rating, score: 4, meal: breakfast
      create :rating, score: 5, meal: breakfast
      create :rating, score: 4, meal: breakfast
      create :rating, score: 4, meal: breakfast
      create :rating, score: 3, meal: breakfast

      create :rating, score: 2, meal: lunch
      create :rating, score: 5, meal: lunch
      create :rating, score: 4, meal: lunch

      create :rating, score: 2, meal: dinner
      create :rating, score: 2, meal: dinner
      create :rating, score: 3, meal: dinner
      create :rating, score: 1, meal: dinner
      create :rating, score: 0, meal: dinner
      create :rating, score: 0, meal: dinner
      create :rating, score: 2, meal: dinner

      expected = {
        data: [4, 3.67, 1.43],
        labels_x: Meal.categories.keys,
        labels_y: Rating.scores.invert
      }

      actual = MetricsService.new([breakfast, lunch, dinner]).meal_type_histogram

      expect(actual).to eq(expected)
    end
  end
end
