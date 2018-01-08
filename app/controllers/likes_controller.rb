class LikesController < ApplicationController
	before_action :authenticate_user!
	def create
		@like = current_user.likes.new
		@like.post = Post.find_by(id: params[:post_id])
		#debugger
		if @like.save
			flash[:notice] = "Liked Post!"
			redirect_to root_path
		else
			flash[:alert] = "Unable to like"
			redirect_to root_path
		end
	end

	def destroy
		@like = Like.find_by({ user: current_user, post_id: params[:id]})
		@like.destroy
		flash[:notice] = "Unliked Post!"
		redirect_to root_path
	end	
end
