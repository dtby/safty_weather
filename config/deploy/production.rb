role :app, %w{deploy@139.196.38.11}
role :web, %w{deploy@139.196.38.11}
role :db,  %w{deploy@139.196.38.11}

set :unicorn_config, "#{ fetch(:deploy_to) }current/config/unicorn.rb"
set :unicorn_pid, '/home/deploy/safty_weather/shared/tmp/pids/unicorn.pid'

set :rails_env, 'production'
set :assets_roles, [:web, :app]

namespace :deploy do
  task :start, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && RAILS_ENV=production bundle exec unicorn_rails -c #{unicorn_config} -D"
  end

  task :stop, :roles => :app, :except => { :no_release => true } do
    run "if [ -f #{unicorn_pid} ]; then kill -QUIT `cat #{unicorn_pid}`; fi"
  end

  task :restart, :roles => :app, :except => { :no_release => true } do
    # 用USR2信号来实现无缝部署重启
    run "if [ -f #{unicorn_pid} ]; then kill -s USR2 `cat #{unicorn_pid}`; fi"
  end
end