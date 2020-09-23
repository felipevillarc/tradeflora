class AreasController < ApplicationController

  def index
    @areas = Area.all
  end

  def show
    @area = Area.find(params[:id])
  end

  def new
    @area = Area.new
    @basins = Basin.all
  end

  def edit
    @area = Area.find(params[:id])
  end

  def create
    @area = Area.new(area_params)
    @area.user = current_user

    redirect_to @area, notice: 'Nova área criada.' 
  end

  def update
    @area = Area.find(params[:id])
    @area.user = current_user
  end

  def destroy
    @area = Area.find(params[:id])
    @area.destroy

    redirect_to @area, notice: 'Área removida.' 
  end

  private

  def area_params
    params.require(:area).permit(:lat, :long, :description, :basin)
  end
end
