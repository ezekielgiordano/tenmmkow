class MembershipsController < ApplicationController
  before_action :authenticate_user!

  def new
    @armies = Army.all
    @group = Group.find(params[:group_id])
    @membership = Membership.new
  end

  def create
    @armies = Army.all
    @group = Group.find(params[:group_id])
    @membership = Membership.new(membership_params)
    @membership.group = @group
    @membership.user = current_user

    if @membership.save
      flash[:notice] = 'Group joined successfully'
      redirect_to group_path(@group)
    else
      flash.now[:notice] = @membership.errors.full_messages.join(' * ')
      render :new
    end
  end

  private

  def membership_params
    params.require(:membership).permit(:army_id)
  end
end
