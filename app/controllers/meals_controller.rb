class MealsController < ApplicationController

  def index
    @meals = Meal.all
  end

  def show
    @meal = Meal.find(params[:id])
  end

  def new
    @meal = Meal.new
  end

  def edit
    @meal = Meal.find(params[:id])
  end

  def create
    @meal = Meal.create(meal_params)

    if @meal.save
      redirect_to @meal
    else
      render 'new'
    end
  end

  def update
    @meal = Mal.find(params[:id])

    if @meal.update(meal_params)
      redirect_to @meal
    else
      render 'edit'
    end
  end

  def destroy
    @meal = Meal.find(params[:id])
    @meal.destroy
    
    redirect_to meals_path
  end

  private
    def meals_params
      params.require(:meal).permit(:name, :description, :type, :group_id, :meal_date)
    end
  end
end
