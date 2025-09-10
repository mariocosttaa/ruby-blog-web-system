# 🚀 Ruby Blog Web System

[![Ruby](https://img.shields.io/badge/Ruby-3.2+-red.svg)](https://www.ruby-lang.org/)
[![Rails](https://img.shields.io/badge/Rails-8.0.2-red.svg)](https://rubyonrails.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-13+-blue.svg)](https://www.postgresql.org/)
[![Docker](https://img.shields.io/badge/Docker-20+-blue.svg)](https://www.docker.com/)
[![TailwindCSS](https://img.shields.io/badge/TailwindCSS-3.0+-38B2AC.svg)](https://tailwindcss.com/)
[![Devise](https://img.shields.io/badge/Devise-Auth-purple.svg)](https://github.com/heartcombo/devise)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

A modern, feature-rich blog management system built with Ruby on Rails 8, featuring a beautiful admin panel, public-facing blog, and comprehensive content management capabilities.

## 📋 Table of Contents

- [🚀 Quick Start](#-quick-start)
- [✨ Features](#-features)
- [🏗️ Architecture](#️-architecture)
- [🛠️ Tech Stack](#️-tech-stack)
- [📦 Installation](#-installation)
- [📊 Database Schema](#-database-schema)
- [🎨 Frontend Features](#-frontend-features)
- [🔐 Authentication & Security](#-authentication--security)
- [🧪 Testing](#-testing)
- [📁 Project Structure](#-project-structure)
- [🔧 Configuration](#-configuration)
- [📈 Performance Features](#-performance-features)
- [🌐 Deployment](#-deployment)
- [🤝 Contributing](#-contributing)
- [📄 License](#-license)

## 🚀 Quick Start

### Prerequisites
- Docker and Docker Compose installed
- Git

### 1. Clone and Setup
```bash
# Clone the repository
git clone https://github.com/yourusername/ruby-blog-web-system.git
cd ruby-blog-web-system

# Build the Docker containers
docker-compose build

# Start the services (PostgreSQL + Rails)
docker-compose up -d
```

### 2. Database Setup
```bash
# Run database migrations
docker-compose exec web rails db:migrate

# Seed with sample data
docker-compose exec web rails db:seed
```

### 3. Build Assets
```bash
# Build TailwindCSS and other assets
docker-compose exec web rails assets:precompile
```

### 4. Access the Application
- **Public Blog**: http://localhost:3000
- **Admin Panel**: http://localhost:3000/panel/dashboard

### 5. Default Admin Account
After running `rails db:seed`, you can log in with:
- **Email**: `admin@example.com`
- **Password**: `12345678`

### 6. Development Mode
For development with live reloading:
```bash
# Use the development compose file
docker-compose -f docker-compose.dev.yml up

# Or run individual services
docker-compose up postgres
bin/dev
```

### 7. Run Tests
```bash
# Run the complete test suite
docker-compose exec web rails test

# Run specific test files
docker-compose exec web rails test test/controllers/panel/posts_controller_test.rb
```

### 8. Stop the Application
```bash
# Stop all services
docker-compose down

# Stop and remove volumes (clean slate)
docker-compose down -v
```

## ✨ Features

### 🎯 Core Features
- **📝 Blog Management**: Complete CRUD operations for posts, categories, and tags
- **👥 User Authentication**: Secure user registration and login with Devise
- **🎨 Modern UI**: Responsive design with TailwindCSS and dark/light theme support
- **📱 Mobile-First**: Fully responsive design optimized for all devices
- **🔍 Search Functionality**: Full-text search across posts and content
- **💬 Comment System**: Public commenting with moderation capabilities
- **📂 Content Organization**: Categories and tags for content categorization
- **🖼️ Media Management**: Image uploads with Active Storage
- **🔒 Admin Panel**: Secure admin interface for content management

### 🎨 UI/UX Features
- **🌓 Theme Toggle**: Dark and light mode support
- **📱 Responsive Design**: Mobile-first approach with TailwindCSS
- **🎭 Modern Animations**: Smooth transitions and hover effects
- **🎨 Custom Styling**: CSS variables for consistent theming
- **📊 Dashboard Analytics**: Visual content management interface
- **🔍 Advanced Search**: Real-time search with filtering options

### 🔧 Technical Features
- **🔐 Secure Authentication**: Devise-based user management
- **🆔 HashID Integration**: Secure, non-sequential ID generation
- **📊 Database Relations**: Well-structured many-to-many relationships
- **🧪 Test Coverage**: Comprehensive test suite with Rails testing framework
- **⚡ Performance**: Optimized queries and caching strategies
- **🔒 Security**: CSRF protection, parameter sanitization, and secure headers

## 🏗️ Architecture

### MVC Pattern Implementation
```
app/
├── models/          # Data layer (ActiveRecord models)
├── views/           # Presentation layer (ERB templates)
├── controllers/     # Logic layer (Rails controllers)
└── helpers/         # View helpers and utilities
```

### Namespace Organization
- **`Panel::`** - Admin interface controllers and views
- **`Public::`** - Public-facing blog controllers and views
- **`ApplicationController`** - Base controller with shared functionality

### Database Design
- **Normalized Schema**: Proper foreign key relationships
- **Junction Tables**: Many-to-many relationships for posts-categories and posts-tags
- **Indexing Strategy**: Optimized indexes for performance
- **Data Integrity**: Foreign key constraints and validations

## 🛠️ Tech Stack

### Backend
- **Ruby 3.2+** - Programming language
- **Rails 8.0.2** - Web application framework
- **PostgreSQL 13+** - Primary database
- **Devise** - Authentication solution
- **Hashids** - Secure ID generation
- **Active Storage** - File uploads and attachments

### Frontend
- **TailwindCSS 3.0+** - Utility-first CSS framework
- **Stimulus** - Modest JavaScript framework
- **Turbo** - SPA-like page acceleration
- **Importmap** - JavaScript module management
- **ERB** - Embedded Ruby templating

### Development Tools
- **Rails Testing** - Built-in testing framework (comprehensive test suite)
- **Docker** - Containerization and development environment
- **Docker Compose** - Multi-container orchestration
- **RuboCop** - Code linting and formatting
- **Brakeman** - Security vulnerability scanner

### Deployment
- **Docker** - Containerization
- **Docker Compose** - Production orchestration
- **PostgreSQL** - Production database
- **Puma** - Web server
- **Kamal** - Container deployment (optional)

## 📦 Installation

### Prerequisites
- Docker 20+ and Docker Compose
- Git

### Clone the Repository
```bash
git clone https://github.com/yourusername/ruby-blog-web-system.git
cd ruby-blog-web-system
```

### Docker Setup
```bash
# Build the containers
docker-compose build

# Start the services
docker-compose up -d

# Run database setup
docker-compose exec web rails db:migrate
docker-compose exec web rails db:seed

# Build assets
docker-compose exec web rails assets:precompile
```

### Development Setup (Alternative)
If you prefer local development without Docker:

```bash
# Install Ruby 3.2+ and PostgreSQL
# Install dependencies
bundle install
bin/importmap install

# Setup database
rails db:create
rails db:migrate
rails db:seed

# Start development server
bin/dev
```

Visit `http://localhost:3000` to see the application.

## 📊 Database Schema

### Core Tables

#### Users Table
```sql
users
├── id (Primary Key)
├── name (String, Required)
├── surname (String, Optional)
├── email (String, Unique, Required)
├── encrypted_password (String, Required)
├── reset_password_token (String, Unique)
├── reset_password_sent_at (DateTime)
├── remember_created_at (DateTime)
├── created_at (DateTime)
└── updated_at (DateTime)
```

#### Posts Table
```sql
posts
├── id (Primary Key)
├── user_id (Foreign Key → users.id)
├── title (String, Required, Unique)
├── slug (String, Required, Unique)
├── description (Text, Required)
├── image (String, Optional)
├── status (Boolean, Default: true)
├── created_at (DateTime)
└── updated_at (DateTime)
```

#### Categories Table
```sql
categories
├── id (Primary Key)
├── name (String, Required, Unique)
├── slug (String, Required, Unique)
├── description (Text, Optional)
├── status (Boolean, Default: true)
├── created_at (DateTime)
└── updated_at (DateTime)
```

#### Tags Table
```sql
tags
├── id (Primary Key)
├── name (String, Required, Unique)
├── status (Boolean, Default: true)
├── created_at (DateTime)
└── updated_at (DateTime)
```

### Junction Tables

#### Post Categories (Many-to-Many)
```sql
post_categories
├── id (Primary Key)
├── post_id (Foreign Key → posts.id)
├── category_id (Foreign Key → categories.id)
├── created_at (DateTime)
└── updated_at (DateTime)
```

#### Post Tags (Many-to-Many)
```sql
post_tags
├── id (Primary Key)
├── post_id (Foreign Key → posts.id)
├── tag_id (Foreign Key → tags.id)
├── created_at (DateTime)
└── updated_at (DateTime)
```

#### Post Comments
```sql
post_comments
├── id (Primary Key)
├── post_id (Foreign Key → posts.id)
├── name (String, Required)
├── email (String, Required, Validated)
├── comment (Text, Required)
├── status (Boolean, Default: true)
├── created_at (DateTime)
└── updated_at (DateTime)
```

### Active Storage Tables
- **active_storage_attachments** - File attachments
- **active_storage_blobs** - File metadata
- **active_storage_variant_records** - Image variants

## 🎨 Frontend Features

### Theme System
The application features a sophisticated theme system with:

#### CSS Variables
```css
:root {
    --purple-dark: #6B21A8;
    --purple-light: #A855F7;
    --black: #1A1A1A;
    --white: #FFFFFF;
    --gray-light: #F5F5F5;
    --gray-dark: #2D2D2D;
}
```

#### Dark/Light Mode Support
- Automatic theme detection
- Manual theme toggle
- Persistent theme preferences
- Smooth transitions between themes

#### Responsive Design
- Mobile-first approach
- Breakpoint system:
  - `sm`: 640px
  - `md`: 768px
  - `lg`: 1024px
  - `xl`: 1280px

### Component Library
- **Cards**: Post cards with hover effects
- **Buttons**: Primary, secondary, and outline variants
- **Forms**: Styled form elements with validation
- **Modals**: Confirmation dialogs and alerts
- **Navigation**: Responsive navigation bars
- **Badges**: Status indicators and category tags

### Animation System
- **Fade In**: Smooth content appearance
- **Slide Up**: Progressive content loading
- **Hover Effects**: Interactive element feedback
- **Loading States**: User feedback during operations

## 🔐 Authentication & Security

### Devise Integration
The application uses Devise for authentication with the following modules:

```ruby
devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :validatable
```

### Security Features
- **CSRF Protection**: Built-in Rails CSRF tokens
- **Parameter Sanitization**: Strong parameters for all forms
- **SQL Injection Prevention**: ActiveRecord ORM protection
- **XSS Protection**: ERB auto-escaping
- **Secure Headers**: Content Security Policy
- **Password Security**: Bcrypt encryption

### Access Control
- **Admin Routes**: Protected with `authenticate_user!`
- **Public Routes**: Open access for blog content
- **User Context**: Current user available in all controllers

### HashID Security
- **Non-sequential IDs**: Prevents enumeration attacks
- **Model-specific Salts**: Different salts for each model
- **Configurable Length**: 12-character hash IDs

```ruby
# Example HashID configuration
HASHIDS_POST = Hashids.new("post-id", 12)
HASHIDS_CATEGORY = Hashids.new("category-id", 12)
HASHIDS_TAG = Hashids.new("tag-id", 12)
```

## 🧪 Testing

### Test Structure
```
test/
├── controllers/     # Controller tests
├── models/         # Model tests
├── fixtures/       # Test data
├── integration/    # Integration tests
└── system/         # System tests
```

### Test Coverage
- **Model Tests**: Validations, associations, and methods
- **Controller Tests**: Complete CRUD testing for all controllers
- **Panel Tests**: Admin functionality with authentication
- **Public Tests**: Public-facing functionality and user experience
- **Integration Tests**: User workflows and API endpoints
- **System Tests**: End-to-end browser testing

### Running Tests
```bash
# Run all tests (Docker)
docker-compose exec web rails test

# Run all tests (Local)
rails test

# Run specific test files
docker-compose exec web rails test test/controllers/panel/posts_controller_test.rb

# Run with coverage
COVERAGE=true docker-compose exec web rails test
```

### Test Examples
```ruby
# Model test example
class PostTest < ActiveSupport::TestCase
  test "should create post with valid attributes" do
    post = Post.new(title: "Test Post", description: "Test Description")
    assert post.valid?
  end
end

# Controller test example
class PostsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get posts_url
    assert_response :success
  end
end
```

## 📁 Project Structure

```
ruby-blog-web-system/
├── app/
│   ├── assets/              # Static assets
│   │   ├── images/         # Image files
│   │   ├── stylesheets/    # CSS files
│   │   └── tailwind/       # TailwindCSS configuration
│   ├── controllers/        # Application controllers
│   │   ├── panel/         # Admin panel controllers
│   │   └── public/        # Public blog controllers
│   ├── helpers/           # View helpers
│   ├── javascript/        # JavaScript files
│   ├── mailers/           # Email templates
│   ├── models/            # ActiveRecord models
│   └── views/             # ERB templates
│       ├── panel/         # Admin panel views
│       └── public/        # Public blog views
├── config/                # Application configuration
│   ├── initializers/      # Initializer files
│   └── locales/           # Internationalization
├── db/                    # Database files
│   ├── migrate/          # Database migrations
│   └── seeds.rb          # Seed data
├── test/                  # Test files
├── public/                # Public static files
├── storage/               # Active Storage files
└── tmp/                   # Temporary files
```

## 🔧 Configuration

### Environment Variables
Create a `.env` file in the root directory:

```env
# Database
DATABASE_URL=postgresql://postgres:password@localhost:5432/ruby_blog_web_system_development
DATABASE_USERNAME=postgres
DATABASE_PASSWORD=password
DATABASE_HOST=localhost

# Rails
RAILS_ENV=development
SECRET_KEY_BASE=your_secret_key_base

# Devise
DEVISE_SECRET_KEY=your_devise_secret_key
```

### Database Configuration
```yaml
# config/database.yml
default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>

development:
  <<: *default
  database: ruby_blog_web_system_development

test:
  <<: *default
  database: ruby_blog_web_system_test

production:
  <<: *default
  database: ruby_blog_web_system_production
  username: <%= ENV['DATABASE_USERNAME'] %>
  password: <%= ENV['DATABASE_PASSWORD'] %>
  host: <%= ENV['DATABASE_HOST'] %>
```

### TailwindCSS Configuration
```javascript
// tailwind.config.js
module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      colors: {
        purple: {
          dark: '#6B21A8',
          light: '#A855F7'
        }
      }
    }
  },
  plugins: []
}
```

## 📈 Performance Features

### Database Optimization
- **Eager Loading**: Prevents N+1 queries
- **Database Indexes**: Optimized for common queries
- **Query Optimization**: Efficient ActiveRecord queries

### Caching Strategy
- **Page Caching**: Static page caching
- **Fragment Caching**: Partial view caching
- **Query Caching**: Database query caching

### Asset Optimization
- **Propshaft**: Modern asset pipeline
- **Image Optimization**: Responsive image handling
- **CSS Purging**: Unused CSS removal

### Performance Monitoring
- **Query Analysis**: Slow query identification
- **Memory Usage**: Application memory monitoring
- **Response Times**: Request timing analysis

## 🌐 Deployment

### Docker Deployment
```dockerfile
# Dockerfile
FROM ruby:3.2-alpine
RUN apk add --no-cache build-base postgresql-dev
WORKDIR /app
COPY Gemfile* ./
RUN bundle install
COPY . .
RUN rails assets:precompile
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
```

### Docker Compose Production
```yaml
# docker-compose.yml
version: '3.8'
services:
  web:
    build: .
    ports:
      - "3000:3000"
    environment:
      - DATABASE_URL=postgresql://postgres:password@postgres:5432/ruby_blog_web_system_production
    depends_on:
      - postgres
    volumes:
      - ./storage:/app/storage

  postgres:
    image: postgres:13
    environment:
      - POSTGRES_DB=ruby_blog_web_system_production
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=password
    volumes:
      - postgres_data:/var/lib/postgresql/data

volumes:
  postgres_data:
```

### Kamal Deployment
```yaml
# config/deploy.yml
service: ruby-blog-web-system
image: your-registry/ruby-blog-web-system
servers:
  web:
    - 192.168.0.1
registry:
  server: your-registry.com
  username: your-username
  password: your-password
```

### Production Considerations
- **Database**: Consider PostgreSQL for production
- **Web Server**: Use Puma with reverse proxy
- **SSL**: Enable HTTPS with Let's Encrypt
- **Monitoring**: Set up application monitoring
- **Backups**: Regular database backups

## 🤝 Contributing

### Development Setup
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new features
5. Ensure all tests pass
6. Submit a pull request

### Code Style
- Follow Ruby style guide
- Use RuboCop for linting
- Write meaningful commit messages
- Add documentation for new features

### Pull Request Process
1. Update README if needed
2. Add tests for new functionality
3. Ensure CI passes
4. Request review from maintainers

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Ruby on Rails Team** - For the amazing framework
- **TailwindCSS Team** - For the utility-first CSS framework
- **Devise Team** - For the authentication solution
- **Hashids** - For secure ID generation
- **Contributors** - All contributors who helped improve this project

---

**Made with ❤️ using Ruby on Rails**

For questions or support, please open an issue on GitHub or contact the maintainers.

## 🚀 Quick Commands

### Docker Commands
```bash
# Start all services
docker-compose up -d

# Build containers
docker-compose build

# Run Rails commands
docker-compose exec web rails [command]

# Run tests
docker-compose exec web rails test

# Database operations
docker-compose exec web rails db:migrate
docker-compose exec web rails db:seed

# Console access
docker-compose exec web rails console

# Stop services
docker-compose down
```

### Local Development Commands
```bash
# Start development server
bin/dev

# Run tests
rails test

# Create migration
rails generate migration CreateTableName

# Run migrations
rails db:migrate

# Seed database
rails db:seed

# Console access
rails console

# Generate controller
rails generate controller ControllerName

# Generate model
rails generate model ModelName

# Check routes
rails routes

# Database console
rails dbconsole
```

---

*This README is automatically generated and maintained. For the most up-to-date information, please refer to the project documentation.*