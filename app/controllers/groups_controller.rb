class GroupsController < ApplicationController
  before_filter :load_group, :only => [:show]

  def show
  end

  def new
    @group = Group.new
    @schedule = @group.schedules.build
  end

  def create
    @group = Group.new(params[:group])
    if @group.save
      redirect_to group_url(@group), :notice => 'Group created'
    else
      flash.now.alert = @group.errors.full_messages.join(', ')
      render :new
    end
  end

  private

  def load_group
    @group = Group.find(params[:id])
  end
end
