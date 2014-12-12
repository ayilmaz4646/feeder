require 'resque/tasks'
#require 'resque/scheduler/tasks'

namespace :resque do
  task :setup do
    require 'resque'
    require 'resque-scheduler'

    Resque.redis = 'localhost:6379'
    Resque.schedule = YAML.load_file('resque_schedule.yml')

    require 'jobs'
  end
end