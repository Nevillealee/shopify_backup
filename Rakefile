# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

namespace :import do
  desc 'import zobha orders'
  task 'zobha' => :environment do |t, args|
    ZobhaOrder.new.import
  end

  desc 'import marika orders'
  task 'marika' => :environment do |t, args|
    MarikaOrder.new.import
  end

  desc 'import ellie orders'
  task 'ellie' => :environment do |t, args|
    EllieOrder.new.import
  end
end
