require "active_record"
require "bundler/setup"

module Dummy
  require_relative "dummy/compatibility"
  require_relative "dummy/application"
  require_relative "../config/environment"
  require_relative "../app/models/user.rb"
end

migrate_path = File.expand_path("../db/migrate/", __FILE__)
if ActiveRecord::VERSION >= '6.0'
  ActiveRecord::MigrationContext.new(migrate_path, ActiveRecord::SchemaMigration).migrate
elsif ActiveRecord::VERSION >= '5.2'
  ActiveRecord::MigrationContext.new(migrate_path).migrate
else
  ActiveRecord::Migrator.migrate(migrate_path)
end
