# Discover Nature

[![Project Proposal](https://img.shields.io/badge/View-Project_Proposal-3fa66e?style=for-the-badge)](https://mravaloarison.github.io/discover-nature-proposal/)
[![Python API](https://img.shields.io/badge/Flask_API-Github_Repository-2D8659?style=for-the-badge&logo=flask)](https://github.com/mravaloarison/nat-geo-api-mvp)

An iOS mobile application that transforms smartphones into tools for ecological discovery, combining daily science education with real-time local wildlife exploration.

[![Swift](https://img.shields.io/badge/Swift-6.0+-orange.svg)](https://swift.org)
[![iOS](https://img.shields.io/badge/iOS-26.0+-blue.svg)](https://www.apple.com/ios/)
[![Firebase](https://img.shields.io/badge/Firebase-12.6.0-yellow.svg)](https://firebase.google.com)

## Overview

Discover Nature is a Mobile app for ecological discovery. This API serves as a backend that:

- **Generates personalized wildlife fun facts** using Google's Gemini AI
- **Creates adaptive daily quizzes** tailored to user knowledge
- **Curates science news** from multiple sources including National Geographic
- **Integrates with biodiversity databases** (iNaturalist, GBIF) for real-time data

This project is part of a **National Geographic Level I Grant Proposal** aimed at addressing the growing disconnect between digital-native generations and the natural world.

## Features

### Home View: Daily Discovery
- **5 curated species facts** presented daily through engaging "Did You Know?" cards
- Latest science news

### Explore View: Local Biodiversity
- Interactive map showing nearby wildlife observations
- Powered by **iNaturalist's real-time observation data**
- Location-based species discovery within your immediate area

### Favorites: Personal Collection
- Store users Favorite species/observations/fun facts

### Games: Adaptive Learning
- **AI-generated daily quizzes** tailored to user's saved favorites
- Multiple-choice questions testing biodiversity/science knowledge

### Search: Intelligent Discovery
- Look up any species
- Comprehensive **GBIF database** information
- Natural language queries like "endangered birds in California"

## Screenshots

*Coming soon - App currently in development*

## Architecture

### Key Dependencies

```swift
- FirebaseCore 
- FirebaseAuth
- FirebaseFirestore
- FirebaseAI
- FirebaseAnalytics
```

### Design Patterns

- **MVVM Architecture**: Clean separation of concerns with ViewModels managing business logic
- **Observable Framework**: Modern Swift Observation for reactive state management
- **Environment Objects**: Shared state management across views
- **Async/Await**: Modern concurrency for network requests

## Requirements

- **iOS**: 26.0 or later
- **Xcode**: 26.0 or later
- **Swift**: 6.0 or later
- **Active Internet Connection**: Required for API calls
- **Location Services**: Required for explore features

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/mravaloarison/nat-geo-ios-mvp.git
cd nat-geo-ios-mvp
```

### 2. Install Dependencies

The project uses Swift Package Manager. Dependencies will be resolved automatically when you open the project in Xcode.

### 3. Backend Setup

Clone and set up the Python API backend:

```bash
git clone https://github.com/mravaloarison/nat-geo-api-mvp.git
cd nat-geo-api-mvp
# Follow backend setup instructions in that repository
```

### 4. Open in Xcode

```bash
open NatGeoProject.xcodeproj
```

## Configuration

### Firebase Configuration

1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com)
2. Download `GoogleService-Info.plist`
3. Replace the existing file in the project root
4. Update the following in your Firebase console:
   - Enable Authentication
   - Create Firestore database
   - Enable Firebase AI features

### API Endpoints

Update the following URLs in the respective managers to point to your backend:

**AIManager.swift**
```swift
var urlString: String { "http://YOUR_BACKEND_URL:5000/fun-facts" }
```

**NewsManager.swift**
```swift
var urlEndPoint: String { "http://YOUR_BACKEND_URL:5000/science_news" }
```

**QuizzesManager.swift**
```swift
var urlEndPoint: String { "http://YOUR_BACKEND_URL:5000/generate_quizz_route" }
```

### Location Permissions

The app requires location permissions. The usage description is already configured in the project:

```
"This app requires your device's location"
```

## API Integration

### External APIs Used

1. **iNaturalist API**: Species observations and taxonomy data
   - Base URL: `https://api.inaturalist.org/v1/`
   - No API key required
   - Rate limits apply

2. **Google Gemini API**: AI-generated content
   - Managed through Firebase AI
   - Requires API key in backend

3. **NewsAPI**: Science news aggregation
   - Managed through backend
   - Requires API key

4. **GBIF API**: Biodiversity database
   - Integration planned
   - No API key required

## Project Structure

```
NatGeoProject/
├── Models/
│   ├── Constants.swift           # App-wide constants
│   ├── GeminiModelData.swift     # AI-generated content models
│   ├── LocationModelData.swift   # Location data structures
│   ├── SearchScope.swift         # Search scope enumeration
│   └── SpeciesModelData.swift    # Species and observation models
├── ViewModels/
│   ├── AIManager.swift           # Gemini AI integration
│   ├── ExploreManager.swift      # Exploration features logic
│   ├── GeocodeService.swift      # Location services
│   ├── LocationManager.swift     # CoreLocation management
│   ├── NewsManager.swift         # News fetching logic
│   ├── ObservationManager.swift  # Single observation details
│   ├── QuizzesManager.swift      # Quiz generation and state
│   ├── SearchManager.swift       # Species search logic
│   └── ViewsManager.swift        # Global view state
├── Views/
│   ├── App/
│   │   ├── Challenges/          # Quiz views
│   │   ├── Explore/             # Map and observation views
│   │   ├── Favorite/            # Favorites collection
│   │   ├── Home/                # Home feed with facts and news
│   │   ├── Search/              # Search interface
│   │   ├── UserLocation/        # Location display
│   │   └── Utils/               # Reusable UI components
│   └── MainAppView.swift         # Main tab container
├── Assets.xcassets/              # Images and colors
├── GoogleService-Info.plist      # Firebase configuration
├── NatGeoProjectApp.swift        # App entry point
└── utils.swift                   # Helper functions
```

## Roadmap

- [x] MVP with core endpoints
- [x] AI-generated fun facts
- [x] Quiz generation system
- [x] News aggregation
- [ ] User authentication
- [ ] Personalized content based on location
- [ ] A/B testing analytics integration
- [ ] Rate limiting and caching
- [ ] Comprehensive API documentation (Swagger/OpenAPI)

---

## Contributing

This project is currently in development as part of a grant proposal. Contributions, suggestions, and feedback are welcome!

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

**Mami Ravaloarison**

- LinkedIn: [@mravaloarison](https://www.linkedin.com/in/mravaloarison)
- GitHub: [@mravaloarison](https://github.com/mravaloarison)

## Acknowledgments

- **National Geographic Society** - For the grant opportunity and inspiration
- **iNaturalist & GBIF** - For biodiversity data
- **Google Gemini AI** - For powering intelligent content generation
- Open-source community for excellent tools and libraries

## Support

For questions or support regarding this project, please:
- Open an issue on GitHub
- Contact via [LinkedIn](https://www.linkedin.com/in/mravaloarison)
