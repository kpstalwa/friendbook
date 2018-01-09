class CommentsController < ApplicationController
	before_action :authenticate_user!
	def create
		@comment = current_user.comments.new
		@comment.post = Post.find_by(id: params[:comment][:test_id])
		@comment.content = params[:comment][:content]
		if @comment.save
			flash[:notice] = "Comment successful!"
			redirect_to root_path
		else
			flash[:alert] = "Failed to comment"
			redirect_to root_path
		end
	end
	def destroy
	end
end
