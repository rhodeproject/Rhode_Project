class SitemapController < ApplicationController
  def index
    @micrposts = Post.all

    respond_to do |format|
      format.xml { render :layout => false }
    end
  end
end