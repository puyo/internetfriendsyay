class PeopleController < ApplicationController
  before_filter :load_schedule
  before_filter :load_person, only: [:edit, :update, :destroy]

  respond_to :html

  def new
    @person = @schedule.people.build(timezone: user.timezone)
  end

  def create
    @person = @schedule.people.new(params[:person])
    if @person.save
      flash.notice = "Person #{@person.name.inspect} added"
    else
      flash.alert = @person.errors.full_messages.join(', ')
    end
    respond_with(@schedule, @person)
  end

  def edit
  end

  def update
    if @person.update_attributes(params[:person])
      flash.notice = "Person #{@person.name.inspect} updated"
    else
      flash.alert = @person.errors.full_messages.join(', ')
    end
    respond_with(@schedule, @person)
  end

  def destroy
    @person.destroy
    flash.notice = "Person #{@person.name.inspect} removed"
    respond_with(@schedule, @person)
  end

  private

  def load_person
    @person = @schedule.people.find(params[:id])
  end

  def load_schedule
    @schedule = Schedule.find_by_uuid(params[:schedule_id])
  end
end
