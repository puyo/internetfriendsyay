class SchedulesController < ApplicationController
  before_filter :load_group

  def new
    @schedule = @group.schedules.build
  end

  def create
    @schedule = @group.schedules.new(params[:schedule])
    if @schedule.save
      redirect_to group_url(@group), :notice => 'Schedule created'
    else
      flash.now.alert = @schedule.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit
  end

  def update
  end

  private

  def load_group
    @group = Group.find(params[:group_id])
  end

  def check_signed_in
    if not signed_in?
      flash.alert = 'You must be signed on to manage schedules'
      redirect_to group_url(@group)
    end
  end
end
