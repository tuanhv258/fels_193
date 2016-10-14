class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find_by id: params[:followed_id]
    current_user.follow @user
    current_user.create_activity Activity.activity_types[:follow], @user.id
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Relationship.find_by(id: params[:id]).followed
    current_user.unfollow @user
    current_user.create_activity Activity.activity_types[:unfollow], @user.id
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
