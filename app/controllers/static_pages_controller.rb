class StaticPagesController < ApplicationController
  before_action :authenticate_user!, except: :home
  def home
  	if user_signed_in?
			@post = current_user.posts.build
			@feed_items = current_user.feed.paginate(page: params[:page])

		end
  end
  def index
  	@users = current_user.friends.paginate(page: params[:page])
  end
end
