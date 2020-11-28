class HorsesController < ApplicationController
  before_action :set_params
  def new
    @horse = Horse.new
  end

  def create
    @horse = Horse.create(horse_params)
    if @horse.save
      flash[:success] = "Horse successfully created"
      redirect_to @horse
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  def update
    @horse = Horse.find(params[:id])
      if @horse.update_attributes(params[:horse])
        flash[:success] = "Horse was successfully updated"
        redirect_to @horse
      else
        flash[:error] = "Something went wrong"
        render 'edit'
      end
  end

  private

  def horse_params
    params.require(:horse).permit(:id, :name, :father, :mother)
  end
end
