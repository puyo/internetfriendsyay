class PeopleController < ApplicationController
  before_filter :load_group

  def new
    @person = @group.people.build(:timezone => @user.timezone)
  end

  def create
    @person = @group.people.new(params[:person])
    if @person.save
      redirect_to group_url(@group), :notice => 'Person added'
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

  def load_group
    @group = Group.find(params[:group_id])
  end

  def check_signed_in
    if not signed_in?
      flash.alert = 'You must be signed on to manage people'
      redirect_to group_url(@group)
    end
  end
end
