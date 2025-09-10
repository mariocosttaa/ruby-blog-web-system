# 🚀 Ruby Blog Web System

[![Ruby](https://img.shields.io/badge/Ruby-3.2+-red.svg)](https://www.ruby-lang.org/)
[![Rails](https://img.shields.io/badge/Rails-8.0.2-red.svg)](https://rubyonrails.org/)
[![SQLite](https://img.shields.io/badge/SQLite-3-blue.svg)](https://www.sqlite.org/)
[![TailwindCSS](https://img.shields.io/badge/TailwindCSS-3.0+-38B2AC.svg)](https://tailwindcss.com/)
[![Devise](https://img.shields.io/badge/Devise-Auth-purple.svg)](https://github.com/heartcombo/devise)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

A modern, feature-rich blog management system built with Ruby on Rails 8, featuring a beautiful admin panel, public-facing blog, and comprehensive content management capabilities.

## 📋 Table of Contents

- [✨ Features](#-features)
- [🏗️ Architecture](#️-architecture)
- [🛠️ Tech Stack](#️-tech-stack)
- [📦 Installation](#-installation)
- [🚀 Quick Start](#-quick-start)
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
- **SQLite 3** - Database (development)
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
- **Rails Testing** - Built-in testing framework
- **Capybara** - Integration testing
- **Selenium** - Browser automation
- **RuboCop** - Code linting and formatting
- **Brakeman** - Security vulnerability scanner

### Deployment
- **Kamal** - Container deployment
- **Docker** - Containerization
- **Puma** - Web server
- **Thruster** - HTTP acceleration

## 📦 Installation

### Prerequisites
- Ruby 3.2 or higher
- Rails 8.0.2 or higher
- SQLite 3
- Node.js (for asset compilation)
- Git

### Clone the Repository
```bash
git clone https://github.com/yourusername/ruby-blog-web-system.git
cd ruby-blog-web-system
```

### Install Dependencies
```bash
# Install Ruby gems
bundle install

# Install JavaScript dependencies
bin/importmap install
```

### Database Setup
```bash
# Create and migrate database
rails db:create
rails db:migrate

# Seed with sample data
rails db:seed
```

### Start the Server
```bash
# Development server
rails server

# Or use the dev script
bin/dev
```

Visit `http://localhost:3000` to see the application.

## 🚀 Quick Start

### 1. Access the Application
- **Public Blog**: `http://localhost:3000`
- **Admin Panel**: `http://localhost:3000/panel/dashboard`

### 2. Default Admin Account
After running `rails db:seed`, you can log in with:
- **Email**: `admin@example.com`
- **Password**: `12345678`

### 3. Create Your First Post
1. Navigate to the admin panel
2. Click "Create Post"
3. Fill in the post details
4. Add categories and tags
5. Upload an image (optional)
6. Publish your post

### 4. Explore Features
- **Public Blog**: Browse posts, categories, and tags
- **Search**: Use the search functionality
- **Comments**: Add comments to posts
- **Admin Management**: Manage all content from the admin panel

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
- **Controller Tests**: Actions, redirects, and responses
- **Integration Tests**: User workflows and API endpoints
- **System Tests**: End-to-end browser testing

### Running Tests
```bash
# Run all tests
rails test

# Run specific test files
rails test test/models/post_test.rb

# Run with coverage
COVERAGE=true rails test
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
DATABASE_URL=sqlite3:db/development.sqlite3

# Rails
RAILS_ENV=development
SECRET_KEY_BASE=your_secret_key_base

# Devise
DEVISE_SECRET_KEY=your_devise_secret_key
```

### Database Configuration
```yaml
# config/database.yml
development:
  adapter: sqlite3
  database: db/development.sqlite3
  timeout: 5000

test:
  adapter: sqlite3
  database: db/test.sqlite3

production:
  adapter: sqlite3
  database: db/production.sqlite3
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
RUN apk add --no-cache build-base sqlite-dev
WORKDIR /app
COPY Gemfile* ./
RUN bundle install
COPY . .
RUN rails assets:precompile
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
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

```bash
# Start development server
rails server

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