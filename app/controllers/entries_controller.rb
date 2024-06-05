class EntriesController < ApplicationController
  before_action :current_user

  def new
    @user = User.find_by({ "id" => session["user_id"] })
  end

  def create
    @user = User.find_by({ "id" => session["user_id"] })
    if @user != nil
      @entry = Entry.new
      @entry["title"] = params["title"]
      @entry["description"] = params["description"]
      @entry["occurred_on"] = params["occurred_on"]
      @entry.uploaded_image.attach(params["uploaded_image"])
      @entry["user_id"] = @user["id"]
      @entry["place_id"] = @user["place_id"]
      @entry.save
    else
      flash["notice"] = "Please login first."
    end
    redirect_to "/places/#{@entry["place_id"]}"
  end
  

end
