class JobsController < ApplicationController
  before_filter :god_check, :only => [:index]
  def index
    @delayedjob = Delayed::Job.all
  end

  def destroy
    Delayed::Job.delete_all
    redirect_to jobs_path
  end
end
