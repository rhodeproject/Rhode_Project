class SitemapController < ApplicationController
  def index
    @posts = Post.all
    @events = Event.all
    respond_to do |format|
      format.xml { render :layout => false }
    end
  end
end