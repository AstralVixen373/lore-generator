# AI Character Generator

## Overview

AI Character Generator is a web application that allows users to create AI-generated fantasy characters and roleplay with them through contextual chat conversations.

The project combines character creation, AI-generated imagery, and conversational roleplay into a single immersive experience inspired by fantasy RPGs and storytelling tools.

The goal of this project is to practice:

- Ruby on Rails full-stack development
- AI integration with RubyLLM & OpenAI
- Authentication and user-specific content
- CRUD operations
- Relational database architecture
- Prompt engineering
- Responsive UI/UX fundamentals
- Team collaboration using Git & GitHub workflows

## Features

### Core features (MVP)

- Google Authentication using OmniAuth
- User authentication with Devise
- Create fantasy characters
- Edit and delete characters
- AI-generated fantasy character portraits
- Persistent character storage with PostgreSQL
- User-specific private character libraries
- Create chats linked to characters
- Roleplay conversations with AI characters
- Multiple chats per character
- Persistent chat history
- Protected routes and authenticated user access
- Production deployment on Heroku

### AI features

- AI-generated fantasy portraits using OpenAI image generation
- AI-powered roleplay conversations
- Contextual chat interactions linked to specific characters
- Prompt-engineered fantasy character generation workflow

### Bonus features

- AI-generated character lore and backstories
- Better conversational memory system
- Image regeneration system
- Expanded worldbuilding tools
- Conversation export system
- Mobile optimization
- Improved responsive design
- Dark mode
- Streaming AI responses

## Tech Stack

### Backend
- Ruby on Rails 8.1.3
- PostgreSQL
- Devise
- OmniAuth
- Turbo

### Frontend
- Bootstrap 5.3
- ERB templates
- SCSS

### AI Integration
- OpenAI API
- RubyLLM

### Deployment
- Heroku

## Data Model

### Database Relationships

```js
User has_many :characters
User has_many :chats

Character belongs_to :user
Character has_many :chats

Chat belongs_to :user
Chat belongs_to :character
Chat has_many :messages

Message belongs_to :chat
```

### Character Model

Each character stores
```js
{
  name: string,
  race: string,
  role: string,
  gender: string,
  personality: string,
  history: text,
  image_url: string
}
```

### Chat System

Each chat stores:
```js
{
  user_id: integer,
  character_id: integer,
  created_at: datetime
}
```

Each message stores:
```js
{
  chat_id: integer,
  role: string,
  content: text,
  created_at: datetime
}
```

## Application Architecture

### Core features

```js
CharactersController
- index
- show
- new
- create
- edit
- update
- destroy

ChatsController
- show
- create

MessagesController
- create
```

## AI Workflow

### Character Generation

```js
User Input
→ Character Prompt Construction
→ OpenAI Image Generation
→ Image Storage
→ Character Creation
```

### Chat System

```js
User Message
→ AI Prompt Contextualization
→ OpenAI Chat Completion
→ AI Response Persistence
→ Conversation Rendering
```

## Authentication Flow
- Users authenticate with Google OAuth
- Devise manages sessions and authentication
- Users can only access their own characters and chats
- Protected controller actions use current_user

## How to Run

### 1. Clone the repository
```js
git clone git@github.com:AstralVixen373/lore-generator.git
```

### 2. Install dependencies
```js
bundle install
```

### 3. Setup the database
```js
rails db:create
rails db:migrate
rails db:seed
```

### 4. Add environment variables
```js
OPENAI_API_KEY=your_key_here
GOOGLE_CLIENT_ID=your_google_client_id
GOOGLE_CLIENT_SECRET=your_google_client_secret
```

### 5. Start the Rails server
```js
rails server
```

## Project structure
```js
lore-generator/
├── app/
│   ├── assets/
│   ├── controllers/
│   ├── helpers/
│   ├── javascript/
│   ├── jobs/
│   ├── mailers/
│   ├── models/
│   └── views/
│    
├── bin 
├── config/
├── db/
│   ├── migrate/
│   ├── schema.rb
│   └── seeds.rb
│
├── lib/
├── log/
├── public/
├── script/
├── storage/
├── test/
├── tmp/
├── vendor/
├── .env
├── Dockerfiles
├── Gemfiles
├── Gitfiles
└── README.md
```

## Development Workflow

### Git Workflow
```js
git checkout -b feature-name
```

- One branch per feature
- Pull requests before merge
- No direct commits to master/main

## Development Checklist

### Day 1 — Project planning & Setup
- Defined project concept
- Defined MVP scope
- Created user stories
- Designed database schema
- Setup Rails application
- Configured PostgreSQL
- Deployed initial Heroku app

### Day 2 — Authentication & Core CRUD
- Setup Devise authentication
- Implemented Google OAuth
- Generated core models
- Built Characters CRUD

### Day 3 — AI Integration
- Integrated RubyLLM
- Connected OpenAI APIs
- Implemented AI image generation
- Added contextual roleplay chats
- Stored persistent conversations
- Added user ownership protection

### Day 4 — UI Polish & Improvements
- Improved UI consistency
- Added responsive layouts
- Added messages page (TO BE CONFIRMED)

### Day 5 — Debugging & Deployment
- Fixed production bugs
- Optimized database queries
- Final deployment & testing

## Security & Permissions
- Users cannot access other users’ characters
- Users cannot access other users’ chats
- Protected routes use authenticated sessions
- Sensitive API keys stored in environment variables

## Possible future Improvements
- Long-term AI memory system
- Regenerate portrait functionality
- Character relationship system
- Expanded worldbuilding tools
- Streaming AI responses
- Advanced prompt customization
- Mobile-first redesign
- Export/import character data

## Authors
Created by:
- AstralVixen373
- Balbo1
- MonsieurKapp 
- Redzvolt 
- TheoSoubraBelay

Built as part of a full-stack AI web development project using Ruby on Rails and OpenAI integrations.
