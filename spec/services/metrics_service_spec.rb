require 'rails_helper'

describe MetricsService do
    context 'average' do
        before do
            @meal = create :meal
            @rating1 = create(:rating, score: 0, meal: @meal)
            @rating2 = create(:rating, score: 3, meal: @meal)
            @rating3 = create(:rating, score: 4, meal: @meal)
            @rating4 = create(:rating, score: 3, meal: @meal)
        end
        
        it 'should calculate the average rating of a set of meals' do
            result = MetricsService.average(@meal)

            expect(result).to eq(2.5)
        end
    end
end
