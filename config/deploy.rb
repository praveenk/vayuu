set :application, "vayuu"
set :repository, "git@github.com:praveenk/vayuu.git" 
set :deploy_to, "/home/www/vayuu.com"
set :deploy_via, :remote_cache
set :branch, "master"
set :domain, "vayuu.com"
set :scm_verbose, true
set :use_sudo, false


default_run_options[:pty] = true
set :user, "root"
set :scm_passphrase, "flysharefly"
set :scm, "git"
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "vayuu.com"                          # Your HTTP server, Apache/etc
role :app, "vayuu.com"                          # This may be the same as your `Web` server
role :db,  "vayuu.com", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
 end
