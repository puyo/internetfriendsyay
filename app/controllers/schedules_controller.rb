class SchedulesController < ApplicationController
  before_filter :load_schedule, :only => [:show]

  def show
  end

  def new
    @schedule = Schedule.new
    @person = @schedule.people.build
  end

  def create
    @schedule = Schedule.new(schedule_params)
    if @schedule.save
      flash.notice = 'Schedule created'
      redirect_to @schedule
    else
      flash.alert = @schedule.errors.full_messages.join(', ')
      @person = @schedule.people.first
      render 'new'
    end
  end

  private

  def load_schedule
    @schedule = Schedule.find_by_uuid(params[:id])
    @people_at_indexes = @schedule.people_at_indexes(user.timezone)
  end

  def schedule_params
    params.require(:schedule).permit!
  end
end
