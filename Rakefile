require 'data_mapper'
require './app/app.rb'

namespace :db do

  desc "Non Destructive Upgrade"
  task :upgrade do
    DataMapper.finalize
    DataMapper.auto_upgrade!
    puts 'Auto-Upgrade Complete - No Data Lost'
  end

  desc "Destructive Upgrade"
  task :migrate do
    DataMapper.finalize
    DataMapper.auto_migrate!
    puts 'Auto-Migrate Complete - All Data Lost'
  end

end
