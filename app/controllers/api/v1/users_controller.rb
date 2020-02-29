class Api::V1::UsersController < ApplicationController
	before_action :authenticate_user!

	def user_profile
		follows = User.where(id: current_user.follows.pluck(:user_id)).where.not(id: current_user.id)
		render json: {user: current_user, following: current_user.following, followers: follows}
	end

	def follow
		if current_user.follows.where(following_id: params[:follow][:user_id]).present?
			render json: {message: "You are already following this user"}
		else
			follow  = current_user.follows.new(following_id: params[:follow][:user_id])
			if follow.save
				render json: {message: "User followed successfully"}
			else
				render json: {message: "User followed successfully", errors: follow.errors.messages}
			end
		end
	end

	def unfollow
		follows = current_user.follows.where(following_id: params[:follow][:user_id]).destroy_all
		if follows.present? && follows.destroy_all 
			render json: {message: "User unfollowed successfully"}
		else
			render json: {message: "There is some problem in unfollowing user."}
		end
	end
end
