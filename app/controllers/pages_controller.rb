class PagesController < ApplicationController
  def home
  end
  def meu_perfil
    @user = current_user
  end
end
