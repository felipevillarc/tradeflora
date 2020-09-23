class TradesController < ApplicationController

  def new
  	@trade = Trade.new 
  	@area = Area.find(params[:area_id])
  end

  def create
  	@trade = Trade.new(trade_params)
  	if @trade.save
  		area = Area.find(@trade.area_id)
  		# area.status = true      mudar o nome de status
  		# if area.save
  		#  redirect_to user_path(area.user_id), notice: 'Nova trade criada.'
  	    # end
  		redirect_to area_path(area), notice: 'Nova trade criada.'
  	else 
  		render :new
  	end
  end

  
  
  private
  
  def trade_params
    params.require(:trade).permit(:user_id, :area_id, :status, :viewed)
  end
end