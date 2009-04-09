require 'active_record'  
require 'yaml'  

ACTIVE_RECORD_BASE = File.expand_path(File.dirname(__FILE__) + '/..')

db_config = {"adapter"=>"sqlite3", "database"=>"#{ACTIVE_RECORD_BASE}/db/test.db"}
ActiveRecord::Base.establish_connection(db_config)  
ActiveRecord::Base.logger = Logger.new(File.open('/dev/null', 'w'))

unless File.file?("#{ACTIVE_RECORD_BASE}/db/test.db")
  ActiveRecord::Migrator.migrate("#{ACTIVE_RECORD_BASE}/db/migrate")
end