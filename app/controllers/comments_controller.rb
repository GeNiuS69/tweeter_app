class CommentsController < ApplicationController
  def create
    @tweet = Tweet.find(params[:tweet_id])
    @comment = @tweet.comments.new(params[:comment])
    if @comment.save
      TweetsMailer.comment_notification(@comment).deliver
    end
      redirect_to tweet_path(@tweet)
  end
end
