class AreasController < ApplicationController

  def index
    @areas = Area.all
  end

  def show
    @basins = Basin.all
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
    if @area.update!(area_params)
      redirect_to area_path(@area), notice: 'Área modificada.'
    else
      @basins = Basin.all
      render :edit
    end
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
