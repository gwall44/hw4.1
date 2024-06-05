class EntriesController < ApplicationController

  def index
    @entries = current_user.entries
    # alternative responses to requests other than HTML
    # respond_to do |format|
    #   format.html # implicitly renders posts/index.html.erb
    # end
  end

  def new
    @user = User.find_by({ "id" => session["user_id"] })
  end

  def create
    @user = User.find_by({ "id" => session["user_id"] })
    if @user != nil
      @entry = Entry.new
      @entry["description"] = params["description"]
      @entry["image"] = params["image"]
      @entry.uploaded_image.attach(params["uploaded_image"])
      @entry["user_id"] = @user["id"]
      @entry.save
    else
      flash["notice"] = "Please login first."
    end
    redirect_to "/entries"
  end

end
