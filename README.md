# Campaign Dispatcher

Rails application for automating customer feedback collection campaigns with real-time progress tracking.

## Prerequisites

- Ruby 3.2.2+
- PostgreSQL
- Redis

## Setup

### Docker (Recommended)

```bash
docker-compose up
```

Application available at http://localhost:3000

### Local Setup

1. Start PostgreSQL and Redis:
   ```bash
   docker-compose up -d postgres redis
   ```

2. Install dependencies and setup:
   ```bash
   bundle install
   bin/rails db:create db:migrate
   ```

3. Run:
   ```bash
   bin/dev
   ```

## Running Tests

```bash
bundle exec rspec
```

## Tech Stack

- Ruby on Rails 7.2.3
- PostgreSQL
- Hotwire (Turbo & Stimulus)
- Sidekiq + Redis
- Tailwind CSS
- RSpec

### Design Decisions

• Status enums stored in DB with defaults — avoids callback surprises  
• DispatchCampaignJob updates only application state  
• Turbo streams react to model commits — no UI logic in background jobs  

### Future Improvements

• Counter cache for large campaigns  
• API endpoints for non-Hotwire clients  
• Stronger error handling and retries
