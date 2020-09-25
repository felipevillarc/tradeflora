class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
  end
  
  def trades
  	@my_trades = Trade.where(user: current_user)
  end

  def proposals
  	@my_proposals = current_user.proposals
  end

  def meu_perfil
    @user = current_user
  end
end
