# Realtime Search Analytics

Realtime Search Analytics is a Ruby on Rails application that provides users with the ability to search through a vast repository of articles and gain insights on search trends and behaviors.

## Features

1. **User Authentication**: Users can sign in to have a personalized experience.
2. **Search Functionality**: Allows users to search for articles. The search results provide article titles and content.
3. **Search Analytics**:
   - Admin users can view global analytics data, such as the most frequently searched queries and individual user search behaviors.
   - Real-time saving and updating of search queries based on certain conditions.
4. **Trending Searches**: An endpoint that provides the top 10 trending search queries.

## Setup and Installation

1. **Clone the Repository**:

```bash
git clone https://github.com/karayamanemre/realtime_search_analytics.git
cd realtime_search_analytics
```

2. **Install Dependencies**

Make sure you have Ruby, Rails, and Bundler installed.

```bash
bundle install
```

3. **Database Setup**

```bash
rails db:create db:migrate
```

4. **Start the Server**

```bash
rails s
```

Visit http://localhost:3000 in your browser.

## How to Test

1. **Set up Testing Dependencies**

If you haven't set up RSpec and other testing tools, follow the initial setup mentioned in previous answers.

Run Tests:
From the application root directory, run:

```bash
rspec
```
