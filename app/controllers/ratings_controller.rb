class RatingsController < ApplicationController
    def index
        @ratings = Rating.where(meal_id: params[:meal_id])
	end

	def new
        @rating = Rating.new
        render layout: false
	end

	def create
        @rating = Rating.create(ratings_params)

        if @rating.save
            flash[:success] = "Successfully left rating!"
            redirect_to root_path
        else
            flash[:danger] = "Failed to leave rating :("
            redirect_to root_path
        end
	end

    def edit
        @rating = Rating.find(params[:id])
        render layout: false
    end

    def update
        @rating = Rating.find(params[:id])

        if @rating.update(ratings_params)
            flash[:success] = "Successfully updated rating!"
            redirect_to root_path
        else
            flash[:danger] = "Failed to update rating :("
            redirect_to root_path
        end
    end

	private
		def ratings_params
			params.require(:rating).permit(:meal_id, :user_id, :score, :comment)
		end
end
