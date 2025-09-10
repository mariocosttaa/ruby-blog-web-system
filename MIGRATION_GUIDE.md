# SQLite to PostgreSQL Migration Guide

This guide will help you migrate your Ruby on Rails 8 blog application from SQLite to PostgreSQL using Docker.

## What's Changed

### 1. Database Configuration
- **Gemfile**: Replaced `sqlite3` gem with `pg` gem
- **database.yml**: Updated to use PostgreSQL adapter with environment variables
- **Dockerfile**: Added PostgreSQL client libraries (`postgresql-client`, `libpq-dev`)

### 2. Docker Configuration
- **docker-compose.yml**: PostgreSQL and Redis services for production
- **docker-compose.dev.yml**: Development environment with app container
- **init-multiple-databases.sh**: Script to create multiple databases

### 3. Migration Tools
- **migrate_sqlite_to_postgres.rake**: Rake task to migrate data from SQLite to PostgreSQL
- **Updated deploy.yml**: Kamal deployment configuration for PostgreSQL

## Migration Steps

### Step 1: Install Dependencies
```bash
bundle install
```

### Step 2: Start PostgreSQL with Docker
```bash
# For development
docker-compose -f docker-compose.dev.yml up -d postgres redis

# Or for production services only
docker-compose up -d postgres redis
```

### Step 3: Backup Your SQLite Data (Optional but Recommended)
```bash
bundle exec rake db:backup_sqlite
```

### Step 4: Create PostgreSQL Databases
```bash
bundle exec rake db:create
```

### Step 5: Run Migrations
```bash
bundle exec rake db:migrate
```

### Step 6: Migrate Data from SQLite (if you have existing data)
```bash
bundle exec rake db:migrate_from_sqlite
```

### Step 7: Verify Migration
```bash
bundle exec rake db:seed
bundle exec rails console
```

## Development Workflow

### Using Docker Compose for Development
```bash
# Start all services (app + postgres + redis)
docker-compose -f docker-compose.dev.yml up

# Or run in background
docker-compose -f docker-compose.dev.yml up -d

# View logs
docker-compose -f docker-compose.dev.yml logs -f app

# Stop services
docker-compose -f docker-compose.dev.yml down
```

### Using Local Development
```bash
# Start only database services
docker-compose up -d postgres redis

# Run Rails locally
bundle exec rails server
```

## Environment Variables

The application now uses these environment variables for database configuration:

- `POSTGRES_HOST`: Database host (default: localhost)
- `POSTGRES_USER`: Database username (default: postgres)
- `POSTGRES_PASSWORD`: Database password (default: postgres)
- `POSTGRES_PORT`: Database port (default: 5432)

## Production Deployment

### Using Kamal
1. Update your `.kamal/secrets` file with `POSTGRES_PASSWORD`
2. Deploy with: `bundle exec kamal deploy`

### Manual Docker Deployment
```bash
# Build image
docker build -t ruby_blog_web_system .

# Run with PostgreSQL
docker run -d \
  -e POSTGRES_HOST=your-postgres-host \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=your-password \
  -e RAILS_MASTER_KEY=your-master-key \
  -p 3000:3000 \
  ruby_blog_web_system
```

## Troubleshooting

### Common Issues

1. **Connection refused**: Make sure PostgreSQL is running and accessible
2. **Authentication failed**: Check your `POSTGRES_PASSWORD` environment variable
3. **Database doesn't exist**: Run `bundle exec rake db:create` first
4. **Migration errors**: Check that all your migrations are compatible with PostgreSQL

### Useful Commands

```bash
# Check database connection
bundle exec rails runner "puts ActiveRecord::Base.connection.execute('SELECT version()').first"

# Reset database (WARNING: This will delete all data)
bundle exec rake db:drop db:create db:migrate db:seed

# View PostgreSQL logs
docker-compose logs postgres

# Connect to PostgreSQL directly
docker-compose exec postgres psql -U postgres -d ruby_blog_development
```

## Data Migration Notes

- The migration script preserves all your existing data
- Foreign key constraints are handled automatically
- The script creates a backup of your SQLite database before migration
- If migration fails, you can restore from the backup

## Performance Considerations

- PostgreSQL generally offers better performance for concurrent operations
- Consider adding database indexes for frequently queried columns
- Use connection pooling for production environments
- Monitor database performance with tools like `pg_stat_statements`

## Next Steps

1. Test your application thoroughly
2. Update your CI/CD pipeline to use PostgreSQL
3. Consider setting up database backups
4. Monitor database performance in production
5. Remove SQLite-related files if no longer needed

## Support

If you encounter issues during migration:
1. Check the logs: `docker-compose logs`
2. Verify environment variables
3. Ensure all dependencies are installed
4. Check database connectivity