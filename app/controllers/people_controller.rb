class PeopleController < ApplicationController
  before_filter :load_schedule

  def new
    @person = @schedule.people.build(:timezone => @user.timezone)
  end

  def create
    @person = @schedule.people.new(params[:person])
    if @person.save
      redirect_to schedule_url(@schedule), :notice => 'Person added'
    else
      flash.now.alert = @person.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit
  end

  def update
  end

  private

  def load_schedule
    @schedule = Schedule.find(params[:schedule_id])
  end

  def check_signed_in
    if not signed_in?
      flash.alert = 'You must be signed on to manage people'
      redirect_to schedule_url(@schedule)
    end
  end
end
