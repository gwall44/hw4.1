class EntriesController < ApplicationController

  def new
  end

  def create
    @user = User.find_by({ "id" => session["user_id"] })
    if @user != nil
      @post = Post.new
      @post["body"] = params["body"]
      @post["image"] = params["image"]
      @post.uploaded_image.attach(params["uploaded_image"])
      @post["user_id"] = @user["id"]
      @post.save
    else
      flash["notice"] = "Login first."
    end
    redirect_to "/posts"
  end

end
