# Markt

Overview

This project demonstrates a modern iOS architecture using SwiftUI + UIKit, built to showcase seamless interaction between the two frameworks. The codebase follows a scalable MVVM-like architecture with dependency injection handled via a shared context (environment object).

⚙️ Tech Stack & Features
• ✅ UIKit-based foundation, allowing clean integration with both SwiftUI views and other UI layers
• ✅ MVVM-inspired structure with services injected into ViewModels
• ✅ Protocolized services for easy mocking and testability
• ✅ Fully native—no third-party libraries, even for image loading/caching
• ✅ Async/Await for clean and modern concurrency
• ✅ Core Data for local storage and persistence

🧪 Testing
• ✅ Services are protocolized to allow mocking and unit testing
• ⏳ ViewModels are not yet protocolized due to time constraints but structured to allow easy refactoring
♻️ Scalability & Cross-Platform Potential

The architecture is intentionally grounded in UIKit, making the project highly adaptable and scalable. 
The codebase can:
• Scale well with modular SwiftUI or pure UIKit UIs
• Be adapted to multi-platform environments like Flutter or React Native, by reusing service logic and data layers
• Serve as a base for shared business logic across mobile platforms

This flexibility makes it ideal for teams transitioning between UI technologies or aiming for cross-platform strategies.

📌 TODO
• Protocolize ViewModels for full testability
• Add UI Tests with XCTest
• Add accessibility support
