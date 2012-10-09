class TweetsController < ApplicationController
  before_filter :update_counter, :only => :show
  def index
   @tweets = Tweet.order("created_at desc")
  end
  def new
    @tweet = Tweet.new
  end
  def popular
    @tweets = Tweet.order("counter desc")
    render :index
  end

  def create
    @tweet=Tweet.new(params[:tweet])
    if @tweet.save
      @tweet.update_attributes(:likes => 0)
      redirect_to tweets_path
    else
      render :new
    end
  end
  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to root_path
  end

  def show
    @tweet = Tweet.find(params[:id])
    @comment = @tweet.comments.new
  end
  def edit
    @tweet = Tweet.find(params[:id])
  end
  def update
    @tweet = Tweet.find(params[:id])
    if @tweet.update_attributes(params[:tweet])
         redirect_to root_path
    else render :edit
    end
  end
  def like
    @tweet = Tweet.find(params[:id])
    @tweet.update_attributes(:likes => (@tweet.likes + 1))
    redirect_to tweet_path(@tweet)
  end

  protected
  def update_counter
    @tweet = Tweet.find(params[:id])
    @tweet.update_attributes(:counter => (@tweet.counter+1))
  end
end
