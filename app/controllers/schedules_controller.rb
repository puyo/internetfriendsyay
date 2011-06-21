class SchedulesController < ApplicationController
  before_filter :load_schedule, :only => [:show]

  respond_to :html

  def show
  end

  def new
    @schedule = Schedule.new
    @person = @schedule.people.build
  end

  def create
    @schedule = Schedule.new(params[:schedule])
    if @schedule.save
      flash.notice = 'Schedule created'
    else
      flash.alert = @schedule.errors.full_messages.join(', ')
    end
    respond_with(@schedule)
  end

  private

  def load_schedule
    @schedule = Schedule.find_by_uuid(params[:id])
    @people_at_indexes = @schedule.people_at_indexes(user.timezone)
  end
end
