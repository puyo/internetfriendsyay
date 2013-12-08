class PeopleController < ApplicationController
  before_filter :load_schedule
  before_filter :load_person, only: [:edit, :update, :destroy]

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

  def person_params
    params.require(:person).permit!
  end
end
