class GroupsController < ApplicationController
  before_filter :load_group, :only => [:show]

  def show
  end

  def new
    @group = Group.new
    @schedule = @group.schedules.build
  end

  def create
    sched = params[:group].delete(:schedule)
    @group = Group.new(params[:group])
    @schedule = @group.schedules.build(sched)
    if @group.save
      flash.notice = "Group created"
      redirect_to group_url(@group)
    else
      flash.alert = ["Group not created", @group.errors.full_messages + @schedule.errors.full_messages].join(', ')
      render :new
    end
  end

  private

  def load_group
    @group = Group.find(params[:id])
  end
end
