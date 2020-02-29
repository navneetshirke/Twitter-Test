class Api::V1::TweetsController < ApplicationController
	before_action :authenticate_user!

	def index
		render json: { tweets: current_user.tweets }
	end 

	def create
		tweet = current_user.tweets.new(tweet_params)
		if tweet.save
			render json: { tweet: tweet, message: "Tweet Created successfully" }
		else
			render json: { message: "There may be some error in creating tweet"}
		end
	end

	def show
		tweet = Tweet.find_by_id(params[:id])
		if tweet
			render json: { tweet: tweet, author: tweet.user}
		else
			render json: { message: "Can't find tweet with given id"}
		end
	end



	private

	def tweet_params
		params.require(:tweet).permit(:title, :body)
	end

end
