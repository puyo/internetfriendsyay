# Manage people resources.
class PeopleController < ApplicationController
  before_action :load_schedule
  before_action :load_person, only: [:edit, :update, :destroy]
  before_action :massage_available_at_params, only: [:create, :update]

  def new
    @person = @schedule.people.build(timezone: user.timezone)
  end

  def create
    @person = @schedule.people.new(person_params)
    if @person.save
      flash.notice = "Person #{@person.name.inspect} added"
      redirect_to @schedule
    else
      flash.alert = @person.errors.full_messages.join(', ')
      render 'new'
    end
  end

  def edit
  end

  def update
    if @person.update_attributes(person_params)
      flash.notice = "Person #{@person.name.inspect} updated"
      redirect_to @schedule
    else
      flash.alert = @person.errors.full_messages.join(', ')
      render 'edit'
    end
  end

  def destroy
    @person.destroy
    flash.notice = "Person #{@person.name.inspect} removed"
    redirect_to @schedule
  end

  private

  def load_person
    @person = @schedule.people.find(params[:id])
  end

  def load_schedule
    @schedule = Schedule.find_by_uuid(params[:schedule_id])
  end

  def massage_available_at_params
    params[:person][:available_at] = params[:person][:available_at].keys
  rescue
    # OK
  end

  def person_params
    params.require(:person).permit(:name, :timezone, available_at: [])
  end
end
