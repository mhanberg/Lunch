class MealsController < ApplicationController
  def new
    @meal = Meal.new
  end

  def edit
    @meal = Meal.find(params[:id])
  end

  def create
    @meal = Meal.create(meals_params)

    if @meal.save
      flash[:success] = 'Successfully added meal!'
    else
      flash[:danger] = 'Failed to add meal!'
    end
    redirect_to Group.find(params[:meal][:group_id])
  end

  def update
    @meal = Meal.find(params[:id])

    if @meal.update(meals_params)
      flash[:success] = 'Successfully updated meal!'
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

  def calendar
    meals = Meal.where(
      group: current_user.default_group,
      meal_date: (params[:start]..params[:end])
    ).includes(:ratings)

    render json: Meal.convert_to_calendar_json(meals, current_user.id)
  end

  private

  def meals_params
    params.require(:meal).permit(:name, :description, :category, :group_id, :meal_date)
  end
end
