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
    @meal = Meal.create(meals_params)

    if @meal.save
      flash[:success] = "Successfully added meal!"
      redirect_to Group.find(params[:meal][:group_id])
    else
      flash[:danger] = "Failed to add meal!"
      redirect_to Group.find(params[:meal][:group_id])
    end
  end

  def update
    @meal = Meal.find(params[:id])

    if @meal.update(meals_params)
      flash[:success] = "Successfully updated meal!"
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
    my_group_ids = Meal.where(group_id: current_user.groups.map { |m| m.id })

    render json: Meal.convert_to_calendar_json(my_group_ids, current_user.id)
  end

  private
    def meals_params
      params.require(:meal).permit(:name, :description, :category, :group_id, :meal_date)
    end

end
