namespace :db do
  desc "Migrate data from SQLite to PostgreSQL"
  task migrate_from_sqlite: :environment do
    puts "Starting migration from SQLite to PostgreSQL..."
    
    # Check if SQLite database exists
    sqlite_path = Rails.root.join("storage", "development.sqlite3")
    unless File.exist?(sqlite_path)
      puts "SQLite database not found at #{sqlite_path}. Nothing to migrate."
      exit
    end
    
    # Create a temporary SQLite connection
    sqlite_config = {
      adapter: 'sqlite3',
      database: sqlite_path.to_s
    }
    
    ActiveRecord::Base.establish_connection(sqlite_config)
    
    # Get all tables
    tables = ActiveRecord::Base.connection.tables
    
    puts "Found #{tables.length} tables to migrate: #{tables.join(', ')}"
    
    # Switch back to PostgreSQL
    ActiveRecord::Base.establish_connection(Rails.env.to_sym)
    
    # Migrate each table
    tables.each do |table|
      next if table == 'schema_migrations' || table == 'ar_internal_metadata'
      
      puts "Migrating table: #{table}"
      
      # Get data from SQLite
      ActiveRecord::Base.establish_connection(sqlite_config)
      records = ActiveRecord::Base.connection.execute("SELECT * FROM #{table}")
      columns = records.fields
      
      # Switch to PostgreSQL
      ActiveRecord::Base.establish_connection(Rails.env.to_sym)
      
      # Clear existing data in PostgreSQL
      ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{table} RESTART IDENTITY CASCADE") rescue nil
      
      # Insert data into PostgreSQL
      records.each do |record|
        values = columns.map { |col| record[col] }
        placeholders = columns.map { |col| "?" }.join(", ")
        column_names = columns.join(", ")
        
        sql = "INSERT INTO #{table} (#{column_names}) VALUES (#{placeholders})"
        ActiveRecord::Base.connection.execute(
          ActiveRecord::Base.sanitize_sql_array([sql] + values)
        )
      end
      
      puts "  Migrated #{records.length} records"
    end
    
    puts "Migration completed successfully!"
  end
  
  desc "Backup SQLite database before migration"
  task backup_sqlite: :environment do
    sqlite_path = Rails.root.join("storage", "development.sqlite3")
    backup_path = Rails.root.join("storage", "development_backup_#{Time.current.strftime('%Y%m%d_%H%M%S')}.sqlite3")
    
    if File.exist?(sqlite_path)
      FileUtils.cp(sqlite_path, backup_path)
      puts "SQLite database backed up to: #{backup_path}"
    else
      puts "SQLite database not found. Nothing to backup."
    end
  end
end