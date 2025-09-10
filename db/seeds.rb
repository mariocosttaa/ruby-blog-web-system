# This file contains all the record creation needed to seed the database with its default values.
# The data can be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Create a user
user = User.find_or_create_by!(name: 'Admin', email: 'admin@example.com') do |user|
  user.name = 'Admin'
  user.password = '12345678'
  user.password_confirmation = '12345678'
end

# Create categories
categories = [
  { name: 'Web Development', description: 'Discussions about modern web development frameworks, libraries, and techniques.' },
  { name: 'AI & Machine Learning', description: 'Exploring the frontiers of artificial intelligence and machine learning.' },
  { name: 'Software Architecture', description: 'Best practices for designing scalable and maintainable software systems.' },
  { name: 'DevOps & Cloud', description: 'CI/CD, infrastructure as code, and cloud computing platforms.' },
  { name: 'Programming Languages', description: 'In-depth articles about various programming languages and their ecosystems.' },
  { name: 'Career & Growth', description: 'Advice and insights for a successful career in the tech industry.' },
  { name: 'Databases', description: 'Everything about SQL, NoSQL, and data storage solutions.' },
  { name: 'Security', description: 'Best practices for writing secure code and protecting against vulnerabilities.' }
]

categories.each do |category_attrs|
  Category.find_or_create_by!(name: category_attrs[:name]) do |category|
    category.description = category_attrs[:description]
    category.slug = category_attrs[:name].parameterize
  end
end

# Create tags
tags = [
  'Ruby', 'Rails', 'JavaScript', 'TypeScript', 'React', 'Vue.js', 'Angular', 'Node.js',
  'Python', 'Django', 'Flask', 'Java', 'Spring', 'Go', 'Rust', 'Elixir', 'Phoenix',
  'Docker', 'Kubernetes', 'Terraform', 'AWS', 'GCP', 'Azure', 'PostgreSQL', 'MySQL',
  'MongoDB', 'Redis', 'GraphQL', 'REST', 'Microservices', 'Monolith', 'TDD', 'BDD'
]

tags.each do |tag_name|
  Tag.find_or_create_by!(name: tag_name)
end

# Create posts with extended HTML descriptions for ~5-minute reading time
posts_data = [
  {
    title: 'Building a Blog with Ruby on Rails',
    description: "<h2>Introduction to Ruby on Rails</h2><p>Ruby on Rails, commonly known as Rails, is a powerful web framework that prioritizes developer productivity through conventions and simplicity. This guide walks you through building a feature-rich blog application, covering setup, models, authentication, testing, and deployment. We will use standard ASCII characters to ensure compatibility with Ruby's syntax, avoiding issues with special characters.</p><p>Begin by installing Ruby with a version manager like <code>rbenv</code> or <code>rvm</code>. Install Rails using <code>gem install rails</code>, then create a new project with <code>rails new blog --database=postgresql</code>. PostgreSQL is chosen for its reliability and scalability. Configure <code>config/database.yml</code> with your database credentials and run <code>rails db:setup</code> to initialize the database. This sets up the foundation for your application.</p><p>Generate models for <code>User</code> and <code>Post</code>. Use <code>rails g scaffold Post title:string description:text user:references</code> to create a Post model with CRUD functionality. For rich text editing, add <code>gem 'trix'</code> to your Gemfile and include <code>trix_editor_tag 'post_description'</code> in your form. Authentication is handled with Devise: add <code>gem 'devise'</code>, run <code>rails g devise:install</code>, and generate <code>rails g devise User</code>. Customize views for registration and login, adding features like email confirmation.</p><p>Add a commenting system with <code>rails g model Comment description:text user:references post:references</code>. Define associations in models to link comments to users and posts. Create a comment form on the post's show page using form helpers. Implement pagination with <code>gem 'will_paginate'</code>, configuring <code>@posts.paginate(page: params[:page], per_page: 10)</code>. Add tagging with <code>gem 'acts-as-taggable-on'</code> to categorize posts. For search, use Elasticsearch with <code>gem 'elasticsearch-model'</code>, indexing titles and descriptions.</p><p>Testing is critical. Add <code>gem 'rspec-rails'</code>, initialize with <code>rails g rspec:install</code>, and write tests like <code>expect(Post.new).to validate_presence_of(:title)</code>. Use SimpleCov for coverage analysis. Deploy to Heroku by creating a <code>Procfile</code> with <code>web: bundle exec puma -C config/puma.rb</code> and pushing with <code>git push heroku main</code>. Optimize assets with <code>rails assets:precompile</code>. Add caching with Redis and monitor with New Relic for performance.</p><p>This guide provides a complete roadmap for building a professional blog, assuming intermediate Ruby knowledge. The result is a scalable, secure application ready for production.</p>",
    tags: [ 'Ruby', 'Rails', 'PostgreSQL', 'TDD', 'Devise' ],
    categories: [ 'Web Development', 'Programming Languages' ]
  },
  {
    title: 'The Rise of TypeScript in Modern Web Development',
    description: "<h2>Why TypeScript?</h2><p>TypeScript, a statically typed JavaScript superset, has become essential for modern web development due to its type safety and tooling. This guide explores TypeScript's features, setup, and integration with frameworks like React and Next.js, ensuring no special characters disrupt the code.</p><p>TypeScript's type system catches errors early. Define interfaces like <code>interface User { name: string; age: number; }</code> to enforce structure. Type inference simplifies code, e.g., <code>let name = 'Alice'</code> is typed as string. Union types (<code>string | number</code>) and generics (<code>function identity<T>(arg: T): T</code>) enable flexible, reusable code. These features improve maintainability in large projects.</p><p>Install TypeScript with <code>npm install -g typescript</code> and initialize with <code>tsc --init</code>, creating <code>tsconfig.json</code>. Enable strict mode with <code>'strict': true</code>. For React, use <code>npx create-react-app my-app --template typescript</code>. Define typed props: <code>interface Props { title: string; }</code>. In Next.js, add <code>tsconfig.json</code> and rename files to <code>.tsx</code>. Build a task manager app, typing API responses with <code>interface Task { id: number; description: string; completed: boolean; }</code>.</p><p>Compared to JavaScript, TypeScript reduces runtime errors but adds a compilation step. Convert a Node.js API to TypeScript, typing routes like <code>app.get('/users', (req: Request, res: Response<User[]>) => { ... });</code>. Advanced features include mapped types and conditional types. Use ESLint with <code>eslint-plugin-typescript</code> and Jest with <code>ts-jest</code> for testing. Deploy to Vercel for production.</p><p>A real-world example, like a typed GraphQL resolver, shows TypeScript's benefits in ensuring robust, scalable code for modern web applications.</p>",
    tags: [ 'TypeScript', 'JavaScript', 'React', 'Node.js', 'Next.js' ],
    categories: [ 'Web Development' ]
  },
  {
    title: 'A Deep Dive into React Hooks',
    description: "<h2>Mastering React Hooks</h2><p>React Hooks, introduced in React 16.8, enable functional components to manage state and side effects, simplifying code. This guide covers key hooks, custom hooks, testing, and performance, using plain ASCII to ensure syntax compatibility.</p><p>Use <code>useState</code> for state: <code>const [count, setCount] = useState(0);</code>. Build a counter app with complex state, like <code>const [user, setUser] = useState({ name: '', age: 0 });</code>. Use <code>useEffect</code> for side effects: <code>useEffect(() => { fetch('/api/users').then(res => setUsers(res.json())); }, []);</code>. The empty array mimics componentDidMount.</p><p>Use <code>useContext</code> for global state and <code>useReducer</code> for complex logic. Build a task manager combining these, with <code>useReducer</code> managing tasks and <code>useContext</code> sharing settings. Create a <code>useFetch</code> hook: <code>function useFetch(url) { const [data, setData] = useState(null); useEffect(() => { fetch(url).then(res => setData(res.json())); }, [url]); return data; }</code>.</p><p>Avoid pitfalls like incorrect dependency arrays. Debug with React DevTools and test with <code>@testing-library/react</code>, using <code>renderHook</code>. Optimize with <code>useCallback</code> and <code>useMemo</code>. A real-time dashboard example with WebSocket integration demonstrates hooks in action, ensuring modular, efficient React code.</p>",
    tags: [ 'React', 'JavaScript', 'TypeScript', 'Hooks' ],
    categories: [ 'Web Development' ]
  },
  {
    title: 'Getting Started with Docker for Web Developers',
    description: "<h2>Docker for Web Developers</h2><p>Docker streamlines deployment by packaging apps into containers. This guide introduces Docker, containerizes a Node.js app, and covers deployment, using standard characters to avoid syntax issues.</p><p>Install Docker Desktop and verify with <code>docker --version</code>. Create a <code>Dockerfile</code> for a Node.js app: <code>FROM node:16\nWORKDIR /app\nCOPY package*.json ./\nRUN npm install\nCOPY . .\nCMD ['npm', 'start']</code>. Build with <code>docker build -t my-app .</code> and run with <code>docker run -p 3000:3000 my-app</code>. Use Docker Compose: <code>services: app: build: . ports: ['3000:3000'] mongo: image: mongo</code>.</p><p>Optimize with multi-stage builds and <code>.dockerignore</code>. Deploy to AWS ECS via AWS ECR. Integrate into CI/CD with GitHub Actions. A React app with Nginx example shows Docker's ability to ensure consistent environments across development and production.</p>",
    tags: [ 'Docker', 'Node.js', 'AWS', 'Docker Compose' ],
    categories: [ 'DevOps & Cloud' ]
  },
  {
    title: 'The Pros and Cons of Microservices Architecture',
    description: "<h2>Microservices Architecture</h2><p>Microservices break apps into independent services, offering scalability but adding complexity. This guide explores benefits, challenges, and tools, ensuring clean syntax.</p><p>Benefits include independent scaling and technology diversity. Build an e-commerce app with <code>OrderService</code> and <code>PaymentService</code> using REST. Challenges include data consistency and communication overhead. Use Kubernetes for orchestration and RabbitMQ for messaging. Monitor with Prometheus and Grafana.</p><p>Test with Pact for contract testing. A decision framework helps choose between microservices and monoliths. An Amazon case study illustrates real-world adoption.</p>",
    tags: [ 'Microservices', 'Kubernetes', 'REST', 'RabbitMQ' ],
    categories: [ 'Software Architecture' ]
  },
  {
    title: 'An Introduction to Test-Driven Development (TDD)',
    description: "<h2>TDD Fundamentals</h2><p>TDD ensures reliable code by writing tests first. This guide covers the TDD cycle in Ruby and JavaScript, building a calculator app.</p><p>For Ruby, use <code>gem 'rspec-rails'</code> and test: <code>RSpec.describe Calculator do it 'adds two numbers' do expect(Calculator.new.add(2, 3)).to eq(5) end end</code>. For JavaScript, use Jest: <code>test('adds two numbers', () => { expect(add(2, 3)).toBe(5); });</code>. Mock dependencies and test async code. Integrate with CI/CD and use SimpleCov for coverage.</p><p>An authentication module example shows TDD's benefits in reducing bugs.</p>",
    tags: [ 'TDD', 'Ruby', 'JavaScript', 'BDD', 'RSpec' ],
    categories: [ 'Programming Languages' ]
  },
  {
    title: 'GraphQL vs. REST: Which API Architecture is Right for You?',
    description: "<h2>GraphQL vs. REST</h2><p>GraphQL and REST are key API architectures. This guide compares them, builds sample APIs, and offers a decision framework.</p><p>REST uses resource endpoints, while GraphQL uses a single endpoint with flexible queries. Build a REST API with Express and a GraphQL API with Apollo Server. Test with Postman and GraphiQL. Address GraphQL's N+1 issue with DataLoader. A blog API example compares both approaches.</p>",
    tags: [ 'GraphQL', 'REST', 'Node.js', 'Apollo Server' ],
    categories: [ 'Software Architecture', 'Web Development' ]
  },
  {
    title: 'The Importance of CI/CD in Modern Software Development',
    description: "<h2>CI/CD Essentials</h2><p>CI/CD automates software delivery. This guide sets up a pipeline for a Rails app using GitHub Actions.</p><p>Define a workflow: <code>jobs: test: runs-on: ubuntu-latest steps: - uses: actions/checkout@v3 - uses: ruby/setup-ruby@v1 with: ruby-version: 3.2 - run: bundle exec rspec</code>. Deploy to AWS Elastic Beanstalk. Use RuboCop and SimpleCov. A blog app deployment shows CI/CD's impact.</p>",
    tags: [ 'CI/CD', 'Rails', 'AWS', 'GitHub Actions' ],
    categories: [ 'DevOps & Cloud' ]
  },
  {
    title: 'A Guide to Authentication and Authorization in Rails',
    description: "<h2>Securing Rails Apps</h2><p>Authentication and authorization secure apps. This guide uses Devise and Pundit in Rails, building a role-based app.</p><p>Add <code>gem 'devise'</code> and generate <code>rails g devise User</code>. Use Pundit for policies: <code>def update? user.admin? || record.user == user end</code>. Add OAuth with <code>omniauth-github</code>. A blog admin panel example ensures security.</p>",
    tags: [ 'Rails', 'Ruby', 'Security', 'Devise', 'Pundit' ],
    categories: [ 'Web Development', 'Security' ]
  },
  {
    title: 'The State of JavaScript in 2025',
    description: "<h2>JavaScript in 2025</h2><p>JavaScript drives web development. This guide covers ECMAScript updates, frameworks, and trends like WebAssembly.</p><p>New features include private fields and top-level await. Build a Next.js app with TypeScript. Use Vite for builds and Vitest for tests. A real-time dashboard example shows JavaScript's power.</p>",
    tags: [ 'JavaScript', 'TypeScript', 'React', 'Next.js', 'WebAssembly' ],
    categories: [ 'Web Development', 'Programming Languages' ]
  },
  {
    title: 'Functional Programming in Ruby',
    description: "<h2>Functional Ruby</h2><p>Functional programming emphasizes immutability. This guide applies FP in Ruby, building a data pipeline.</p><p>Use <code>map</code> and <code>reduce</code>: <code>[1, 2, 3].map { |n| n * 2 }</code>. Create lambdas: <code>double = ->(x) { x * 2 }</code>. Test with RSpec. An API processing example shows FP's benefits.</p>",
    tags: [ 'Ruby', 'Elixir', 'Functional Programming' ],
    categories: [ 'Programming Languages' ]
  },
  {
    title: 'Building Real-Time Applications with Action Cable',
    description: "<h2>Real-Time with Action Cable</h2><p>Action Cable enables real-time Rails features. This guide builds a chat app with WebSockets and Redis.</p><p>Add <code>gem 'redis'</code> and configure <code>config/cable.yml</code>. Generate <code>rails g channel Chat</code>. Broadcast with <code>ActionCable.server.broadcast</code>. A notification system example shows real-time capabilities.</p>",
    tags: [ 'Rails', 'Ruby', 'Redis', 'Action Cable' ],
    categories: [ 'Web Development' ]
  },
  {
    title: 'An Introduction to Natural Language Processing (NLP)',
    description: "<h2>NLP Basics</h2><p>NLP processes human language. This guide uses Python's NLTK and spaCy to build a sentiment analyzer.</p><p>Install <code>pip install nltk</code> and tokenize with <code>nltk.word_tokenize</code>. Use spaCy for NER and TextBlob for sentiment. Fine-tune BERT with Hugging Face. A review analyzer shows NLP's applications.</p>",
    tags: [ 'Python', 'NLP', 'Machine Learning', 'spaCy' ],
    categories: [ 'AI & Machine Learning' ]
  },
  {
    title: 'The Art of Refactoring',
    description: "<h2>Refactoring 101</h2><p>Refactoring improves code without changing behavior. This guide refactors an authentication module in Ruby and JavaScript.</p><p>Use method extraction and SOLID principles. Tools like RuboCop and ESLint help. Test with RSpec and Jest. An authentication example shows refactoring's impact.</p>",
    tags: [ 'Ruby', 'JavaScript', 'TDD', 'Refactoring' ],
    categories: [ 'Programming Languages' ]
  },
  {
    title: 'A Comparison of Popular CSS Frameworks',
    description: "<h2>CSS Frameworks</h2><p>CSS frameworks simplify styling. This guide compares Tailwind CSS, Bootstrap, and Foundation.</p><p>Use <code>npm install tailwindcss</code> for Tailwind. Build a landing page to compare features. Tailwind's utility-first approach contrasts with Bootstrap's components.</p>",
    tags: [ 'CSS', 'Tailwind', 'Bootstrap', 'Foundation' ],
    categories: [ 'Web Development' ]
  },
  {
    title: 'The SOLID Principles of Object-Oriented Design',
    description: "<h2>Understanding SOLID</h2><p>SOLID principles ensure maintainable code. This guide applies them in a Java Spring Boot app.</p><p>Refactor a monolithic class using Single Responsibility and other principles. Test with JUnit. A modular component example shows SOLID's benefits.</p>",
    tags: [ 'Java', 'Spring', 'SOLID' ],
    categories: [ 'Software Architecture', 'Programming Languages' ]
  },
  {
    title: 'An Introduction to Serverless Architecture',
    description: "<h2>Serverless Basics</h2><p>Serverless simplifies development. This guide builds a Node.js REST API with AWS Lambda.</p><p>Create a Lambda function: <code>exports.handler = async (event) => { ... }</code>. Deploy with Serverless Framework. A CRUD API shows serverless benefits.</p>",
    tags: [ 'AWS', 'Node.js', 'Serverless', 'Lambda' ],
    categories: [ 'DevOps & Cloud' ]
  },
  {
    title: 'The Role of a Tech Lead',
    description: "<h2>Tech Lead Responsibilities</h2><p>Tech leads guide teams and make technical decisions. This guide covers mentoring and planning.</p><p>Use Jira for task management. A technical debt scenario shows leadership challenges.</p>",
    tags: [ 'Career', 'Leadership', 'Project Management' ],
    categories: [ 'Career & Growth' ]
  },
  {
    title: 'A Guide to Pair Programming',
    description: "<h2>Pair Programming Guide</h2><p>Pair programming boosts code quality. This guide covers styles like driver-navigator in Ruby.</p><p>Use VS Code Live Share. A TDD feature-building example shows pair programming's benefits.</p>",
    tags: [ 'Ruby', 'TDD', 'Agile', 'Pair Programming' ],
    categories: [ 'Career & Growth' ]
  },
  {
    title: 'The Future of Remote Work in the Tech Industry',
    description: "<h2>Remote Work Trends</h2><p>Remote work reshapes tech. This guide explores benefits and challenges, using tools like Slack.</p><p>A GitLab case study shows remote operations. Strategies for productivity and hybrid models are covered.</p>",
    tags: [ 'Career', 'Remote Work', 'Collaboration' ],
    categories: [ 'Career & Growth' ]
  }
]

posts_data.each do |post_attrs|
  post = Post.create!(
    title: post_attrs[:title],
    description: post_attrs[:description],
    user: user,
    slug: post_attrs[:title].parameterize,
    status: true
  )

  # Associate categories and tags
  post.categories = Category.where(name: post_attrs[:categories]).to_a
  post.tags = Tag.where(name: post_attrs[:tags]).to_a
end

puts "Seed data created successfully!"
