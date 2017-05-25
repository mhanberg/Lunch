require 'rails_helper'

describe Meal do
    context 'calendar' do
        before do
            @user = create :user
            @meals =  create_list(:meal, 1, category: 1)
            @meals << create(:meal, category: 2)
            @meals << create(:meal, category: 3)
            @rating = create(:rating, meal: @meals[1], user: @user)
        end
        
        it 'should convert fetch ratings' do
            result = Meal.convert_to_calendar_json(@meals, @user.id)
            
            expect(result[0]["rating"]).to eq(false)
            expect(result[1]["rating"]).to eq(@rating.as_json)
            expect(result[2]["rating"]).to eq(false)
        end

        it 'should set meal start time' do
            result = Meal.convert_to_calendar_json(@meals, @user.id)

            expect(result[0]["start"]).to eq(@meals[0][:meal_date].to_s + " 06:00:00")
            expect(result[1]["start"]).to eq(@meals[1][:meal_date].to_s + " 11:00:00")
            expect(result[2]["start"]).to eq(@meals[2][:meal_date].to_s + " 17:30:00")
        end
        
        
    end
    
end
