ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings={
  :adress => "smtp.gmail.com",
  :port => 587,
  :domain => "smtp.gmail.com",
  :user_name => "garik.piton@gmail.com",
  :password => "kjvfqvtyz",
  :authentication => "plain",
  :enable_starttls_auto => true
}
