class TweetsMailer < ActionMailer::Base
  default from: "from@example.com"
  def comment_notification(comment)
    @comment = comment
    mail(:to => "garik.piton@gmail.com", :subject => "Notification about comment")
  end
end
