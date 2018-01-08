class FriendsController < ApplicationController
	before_action :set_friend, only: :destroy
  before_action :authenticate_user!

  def index
    @friends = current_user.friends
  end
  def destroy

     current_user.remove_friend(@friend)
     flash[:notice] = "You are no longer friends with #{@friend.name}"
     redirect_to root_path
   end
 private

 def set_friend
  @friend = current_user.friends.find(params[:id])
end
end