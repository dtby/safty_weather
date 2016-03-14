role :app, %w{deploy@139.196.38.11}
role :web, %w{deploy@139.196.38.11}
role :db,  %w{deploy@139.196.38.11}

set :rails_env, 'production'

set :assets_roles, [:web, :app]
set :deploy_to, '/home/deploy/safty_weather/'

set :unicorn_config, "#{ fetch(:deploy_to) }current/config/unicorn.rb"
set :unicorn_pid, '/home/deploy/safty_weather/shared/tmp/pids/unicorn.pid'

namespace :unicorn do
  desc 'Zero-downtime restart of Unicorn'
  task :restart do
    # 用USR2信号来实现无缝部署重启
    on roles(:all) do
      execute "if [ -f #{ fetch(:unicorn_pid) } ]; then kill -s USR2 `cat #{ fetch(:unicorn_pid) }`; fi"
    end
  end

  desc 'Start unicorn'
  task :start do
    on roles(:all) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :bundle, "exec unicorn_rails -E production -c #{ fetch(:unicorn_config) } -D"
        end
      end
    end
  end

  desc 'Stop unicorn'
  task :stop do
    on roles(:all) do
      execute "if [ -f #{fetch(:unicorn_pid) } ]; then kill -QUIT `cat #{ fetch(:unicorn_pid) }`; fi"
    end
  end
end

after 'deploy:publishing', 'unicorn:restart'