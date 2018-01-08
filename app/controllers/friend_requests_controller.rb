class FriendRequestsController < ApplicationController
	before_action :set_friend_request, except: [:index, :create]
	before_action :authenticate_user!

	def create
		friend = User.find(params[:friend_id])
		@friend_request = current_user.friend_requests.new(friend: friend)
		if @friend_request.save
			flash[:notice] = "Friend request sent"
			redirect_to friend
		else
			flash[:alert] = "You have already sent this user a friend request"
			redirect_to users_path
		end
	end
	def index
		@incoming = FriendRequest.where(friend: current_user)
		@outgoing = current_user.friend_requests
	end
	def update
		@friend_request.accept
		flash[:notice] = "friend_added!"
		redirect_to root_path
	end
	def destroy
		@friend_request.destroy
	end

	private 
	def set_friend_request
		@friend_request = FriendRequest.find(params[:id])
	end
end