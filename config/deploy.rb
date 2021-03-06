require "bundler/capistrano"

#set :whenever_command, "bundle exec whenever" # uncomment this if you need whenever integration
#require "whenever/capistrano"                 # uncomment this if you need whenever integration

load 'deploy/assets'
set :rvm_ruby_string, '1.9.3'
# Load RVM's capistrano plugin.
require "rvm/capistrano"
set :rvm_type, :system

set :application, "project"
set :repository,  "ssh://your_username@gitent-scm.com/git/gradus/#{application}"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
dpath = "/opt/#{application}"
set :user, "root"
set :use_sudo, false
set :ssh_options, :forward_agent => true
set :deploy_to, dpath
set :rails_env, "production"
#set :rake, "/usr/local/rvm/gems/ruby-#{rvm_ruby_string}/bin/rake"
set :rake, "bundle exec rake"
set :keep_releases, 5

role :web, "ip"                          # Your HTTP server, Apache/etc
role :app, "ip"                          # This may be the same as your `Web` server
role :db,  "ip", :primary => true # This is where Rails migrations will run

#after "deploy:update_code", :link_assets  # use this task for linking assets
#after "deploy:update_code", :copy_uploads # use this task for copying assets
before "deploy:assets:precompile", :copy_database_settings

task :link_assets, roles => :app do
  assets_path = "#{shared_path}/assets"
  run "ln -s #{assets_path} #{release_path}/public/assets"
end

task :copy_uploads, roles => :app do
  uploads_path = "#{previous_release}/public/uploads"
  run "cp -r #{uploads_path} #{release_path}/public"
end

task :copy_database_settings, roles => :app do
  database = "#{shared_path}/database.yml"
  run "cp #{database} #{release_path}/config"
end

task :show_log do
  run "tail -f #{current_path}/log/#{rails_env}.log"
end

set :unicorn_conf, "#{current_path}/config/unicorn.rb"
set :unicorn_pid, "#{shared_path}/pids/unicorn.pid"

# - for unicorn - #
namespace :deploy do
  desc "Start application"
  task :start, :roles => :app do
    run "cd #{deploy_to}/current && bundle exec unicorn_rails -Dc #{unicorn_conf} -E production"
  end

  desc "Stop application"
  task :stop, :roles => :app do
    run "[ -f #{unicorn_pid} ] && kill -QUIT `cat #{unicorn_pid}`"
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "if [ -f #{unicorn_pid} ]; then kill -USR2 `cat #{unicorn_pid}`; else cd #{deploy_to}/current && bundle exec unicorn_rails -c #{unicorn_conf} -E #{rails_env} -D; fi"
  end

end
