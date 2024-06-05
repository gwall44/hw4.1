class EntriesController < ApplicationController
  before_action :current_user

  def index
    @user = User.find_by({ "id" => session["user_id"] })
    if @user
      @entries = @user.entries
    else
      flash["notice"] = "Please login first."
      redirect_to "/login"
    end
  end
  

  def new
    @user = User.find_by({ "id" => session["user_id"] })
  end

  def create
    @user = User.find_by({ "id" => session["user_id"] })
    if @user != nil
      @entry = Entry.new
      @entry["description"] = params["description"]
      @entry.uploaded_image.attach(params["uploaded_image"])
      @entry["user_id"] = @user["id"]
      @entry.save
    else
      flash["notice"] = "Please login first."
    end
    redirect_to "/entries"
  end

end
