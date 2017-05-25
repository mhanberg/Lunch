require 'rails_helper'

describe MetricsService do
    context 'single meal average' do
        before do
            @meal = create :meal
            @rating1 = create(:rating, score: 0, meal: @meal)
            @rating2 = create(:rating, score: 3, meal: @meal)
            @rating3 = create(:rating, score: 4, meal: @meal)
            @rating4 = create(:rating, score: 3, meal: @meal)
        end
        
        it 'should calculate the average rating of a meal' do
            result = MetricsService.meal_average @meal

            expect(result).to eq(2.5)
        end
    end

    context 'multi meal averge' do
        before do
            @meals = create_list(:meal)
            @rating1 = create(:rating, score: 0, meal: @meals[0])
            @rating2 = create(:rating, score: 3, meal: @meals[0])
            @rating3 = create(:rating, score: 4, meal: @meals[0])
            @rating4 = create(:rating, score: 3, meal: @meals[0])
        
            @rating5 = create(:rating, score: 4, meal: @meals[1])
            @rating6 = create(:rating, score: 3, meal: @meals[1])
            @rating7 = create(:rating, score: 1, meal: @meals[1])
        end

        it 'should calculate the average rating of a set of meals' do
            result = MetricsService.meals_average @meals
        end
    end
    
end
