class SchedulesController < ApplicationController
  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  private

  def load_group
    @group = Group.find_by_uuid(params[:group_id])
  end
end
