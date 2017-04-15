class RatingsController < ApplicationController
    def index
        @ratings = Rating.where(meal_id: params[:meal_id])
	end

	def new
        @rating = Rating.new
	end

	def create
        @rating = Rating.create(ratings_params)
        meal = Meal.find(params[:rating][:meal_id])

        if @rating.save
            flash[:success] = "Successfully left rating!"
            redirect_to meal
        else
            flash[:danger] = "Failed to leave rating :("
            redirect_to meal
        end
	end

    def edit
        @rating = Rating.find(params[:id])
    end

    def update
        @rating = rating.find(params[:id])

        if @rating.update(ratings_params)
            flash[:success] = "Successfully updated rating!"
            redirect_to Meal.find(params[:rating][:meal_id])
        else
            flash[:danger] = "Failed to update rating :("
            render 'edit'
        end
    end

	private
		def ratings_params
			params.require(:rating).permit(:meal_id, :user_id, :rating, :comment)
		end
end
