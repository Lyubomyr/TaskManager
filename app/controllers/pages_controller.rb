class PagesController < ApplicationController
  def home
    @title = "Home"
    @task = Task.new if signed_in?
  end

  def about
  	@title = "About"
  end
end
