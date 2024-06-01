class SessionsController < ApplicationController
  def new
    # Renders the login form
  end
  def create
    @user = User.find_by({ "email" => params["email"] })
    if @user != nil
      if BCrypt::Password.new(@user["password"]) == params["password"]
        session["user_id"] = @user["id"]
        flash["notice"] = "You are now logged-in as."
        redirect_to "/places"
      else
        flash["notice"] = "Sorry, invalid username or password."
        redirect_to "/login"
      end
    else
      flash["notice"] = "Sorry, invalid username or password."
      redirect_to "/login"
    end
  end

  def destroy
    session["user_id"] = nil
    flash["notice"] = "Goodbye."
    redirect_to "/login"
  end
end