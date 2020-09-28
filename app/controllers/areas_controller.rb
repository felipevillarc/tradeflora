class AreasController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    if params[:query].present?
      @areas = Area.search_by_area_user_or_basin(params[:query])
    else
      @areas = Area.all
    end
  end

  def show
    @basins = Basin.all
    @area = Area.find(params[:id])
    @markers = [{
        lat: @area.lat,
        lng: @area.long
      }]
  end

  def new
    @area = Area.new
    @basins = Basin.all
  end

  def edit
    @area = Area.find(params[:id])
    @basins = Basin.all
    #raise
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
