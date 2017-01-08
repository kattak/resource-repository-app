class FavoritesController < ApplicationController
  def index
    @favorites = Favorite.all
  end

  def new
    @favorite = Favorite.new
  end

  def create
    @favorite = Favorite.new(favorite_params)
    respond_to do |format|
     if @favorite.save
       format.html { redirect_to resources_path, notice: 'Favorite was successfully created.' }
       format.json { render :'/resources/index', status: :created, location: @favorite }
     else
       format.html { render :new }
       format.json { render json: @favorite.errors, status: :unprocessable_entity }
     end
   end
  end

  private
  def favorite_params
    params.require(:favorite).permit(:user_id, :resource_id)
  end

end
