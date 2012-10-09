class CommentsController < ApplicationController
  def create
    @tweet = Tweet.find(params[:tweet_id])
    @comment = @tweet.comments.new(params[:comment])
    if @comment.save
 #     TweetsMailer.comment_notification(@comment).deliver
    end
  end
  def destroy
   @comment = Comment.find(params[:id])
   @comment.destroy
  end
end

