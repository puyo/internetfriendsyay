# Manage schedule resources.
class SchedulesController < ApplicationController
  before_action :load_schedule, only: [:show]
  before_action :massage_available_at_params, only: [:create]

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

  def massage_available_at_params
    params[:schedule][:people_attributes].each do |k, v|
      v[:available_at] = v[:available_at].keys
    end
  rescue
    # OK
  end

  def schedule_params
    params.require(:schedule).permit(people_attributes: [:name, :timezone, available_at: []])
  end
end
