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
    
    if @area.save!
      redirect_to area_path(@area), notice: 'Nova área criada.'
    else
      @basins = Basin.all
      render :new
    end
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
    params.require(:area).permit(:lat, :long, :description, :basin_id)
  end
end
"""
def create 
  @area = Area.new(area_params) 
  @user = current_user 
  @area.user = @user
  if @area.save 
  redirect_to '/'
  else
    raise
  end
end"""