class PlacesController < ApplicationController
  before_action :current_user

  def index
    @places = Place.all
  end

  def show
      @place = Place.find_by({ "id" => params["id"] })
      @entries = Entry.where({ "place_id" => @place["id"], "user_id" => session["user_id"] })
      end

  def new
    @user = User.find_by({ "id" => session["user_id"] })
  end 

  def create
    @user = User.find_by({ "id" => session["user_id"]  })
  
    if @user
      @place = Place.find_by({ "id" => params["id"] })
      @place = Place.new
      @place["name"] = params["name"]
      @place.save
    else
      flash["notice"] = "Please login first."
      redirect_to "/login"
    end
  end
end
