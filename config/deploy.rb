# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'safty_weather'
set :deploy_user, 'deploy'

set :scm, :git
set :repo_url, 'https://github.com/dtby/safty_weather'

# Default branch is :master
set :branch, 'master'

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/deploy/safty_weather'

# Default value for :scm is :git
set :scm, :git
set :unicorn_config, "#{ fetch(:deploy_to) }current/config/unicorn.rb"
set :unicorn_pid, '/home/deploy/safty_weather/shared/tmp/pids/unicorn.pid'

set :rails_env, 'production'
set :assets_roles, [:web, :app]

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5


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

namespace :symlink do

  desc 'Symlink database'
  task :database_yml do
    on roles(:all) do
      execute "rm -rf #{ release_path }/config/database.yml"
      execute "ln -sfn #{ shared_path }/config/database.yml #{ release_path }/config/database.yml"
    end
  end

  desc 'Symlink secret'
  task :secret do
    on roles(:all) do
      execute "rm -rf #{ release_path }/config/secrets.yml"
      execute "ln -sfn #{ shared_path }/config/secrets.yml #{ release_path }/config/secrets.yml"
    end
  end
end


namespace :db do
  desc 'rake db:seed'
  task :seed do
    on roles(:all) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'db:drop'
        end
      end
    end
  end
end

after 'deploy:publishing', 'unicorn:restart'
before 'bundler:install', 'symlink:database_yml'
before 'bundler:install', 'symlink:secret'
