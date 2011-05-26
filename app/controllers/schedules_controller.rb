class SchedulesController < ApplicationController
  before_filter :load_schedule, :only => [:show]

  def show
  end

  def new
    @schedule = Schedule.new
    @person = @schedule.people.build
  end

  def create
    @schedule = Schedule.new(params[:schedule])
    if @schedule.save
      redirect_to schedule_url(@schedule), :notice => 'Schedule created'
    else
      flash.now.alert = @schedule.errors.full_messages.join(', ')
      render :new
    end
  end

  private

  def load_schedule
    @schedule = Schedule.find_by_uuid(params[:id])
    @schedule.user = @user
  end
end
