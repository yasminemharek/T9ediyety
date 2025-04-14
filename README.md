# T9ediyety

A mobile application for budget-conscious grocery shopping with real-time collaboration.

## Features

- User authentication
- Budget management
- Product list creation with priority settings
- Price optimization suggestions
- Real-time list sharing
- Purchase history tracking
- Product barcode scanning
- Promotion suggestions

## Tech Stack

- **Frontend**: Flutter for cross-platform mobile development
- **Backend**: Node.js with Express
- **Database**: MySQL
- **Real-time**: Socket.IO

## Getting Started

### Prerequisites

- Flutter SDK
- Node.js & npm
- MySQL

### Installation

#### Backend Setup
1. Navigate to the backend directory: `cd backend`
2. Install dependencies: `npm install`
3. Copy `.env.example` to `.env` and update the values
4. Run database migrations: `npm run migrate`
5. Start the server: `npm run dev`

#### Mobile Setup
1. Navigate to the mobile directory: `cd mobile_front`
2. Install dependencies: `flutter pub get`
3. Update the API endpoint in `lib/config/constants.dart`
4. Run the app: `flutter run`

## Project Structure

### Mobile (Flutter)
- `/mobile`
  - `/lib`
    - `/config` - App configuration and constants
    - `/models` - Data models
    - `/screens` - UI screens
    - `/widgets` - Reusable UI components
    - `/services` - API services and data providers
    - `/utils` - Helper functions and utilities
    - `/providers` - State management providers
    - `/theme` - App theme configuration
    - `main.dart` - Application entry point
  - `/assets` - Images, fonts, and other static assets
  - `/test` - Unit and widget tests

### Backend (Node.js)
- `/backend`
  - `/config` - Server configuration
  - `/controllers` - Request handlers
  - `/models` - Database models
  - `/routes` - API route definitions
  - `/middleware` - Custom middleware
  - `/services` - Business logic
  - `/utils` - Helper functions
  - `/migrations` - Database migration scripts
  - `server.js` - Server entry point

### Documentation
- `/docs`
  - `architecture.md` - System architecture diagrams
  - `api_spec.md` - API documentation
  - `db_schema.md` - Database schema
  - `setup.md` - Setup instructions

## Contributing

### Getting Started
1. Fork the repository
2. Create your feature branch: `git checkout -b feature/amazing-feature`
3. Commit your changes: `git commit -m 'Add some amazing feature'`
4. Push to the branch: `git push origin feature/amazing-feature`
5. Open a Pull Request

### Code Style Guidelines
- Follow the Dart style guide for Flutter code
- Follow the Airbnb JavaScript style guide for backend code
- Write meaningful commit messages
- Update documentation when necessary

### Pull Request Process
1. Ensure all tests pass
2. Update the README.md with details of changes if applicable
3. The PR requires review from at least one maintainer
4. PRs will be merged once approved


## License

This project is licensed under the MIT License - see the LICENSE file for details.
