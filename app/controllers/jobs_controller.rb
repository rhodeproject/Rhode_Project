class JobsController < ApplicationController
  before_filter :god_check, :only => [:index]
  def index
    @delayedjob = Delayed::Job.all
  end
end
