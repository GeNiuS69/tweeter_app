class CommentsController < ApplicationController
  def create
    @tweet = Tweet.find(params[:tweet_id])
    @comment = @tweet.comments.new(params[:comment])
    if @comment.save
 #     TweetsMailer.comment_notification(@comment).deliver
           end
  end
  def destroy
   @tweet = Tweet.find(params[:tweet_id])
   @comment = @tweet.comments.find(params[:id])
   @comment.destroy
   redirect_to tweet_path(@tweet)
  end
end

