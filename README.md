# SwiftUI Demo Project

This project is a collection of demos showcasing various SwiftUI and iOS features, focusing on reusable architecture, custom UI components, and clean mobile development patterns. Each demo highlights specific SwiftUI functionality, including animations, particle effects, and other UI interactions. The project is designed with modularity in mind, using embedded Swift packages to separate concerns and promote reuse.

## Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Architecture](#architecture)
- [Packages](#packages)
- [Demo List](#demo-list)
- [Requirements](#requirements)
- [Installation](#installation)
- [Contributing](#contributing)
- [How to Collaborate](#how-to-collaborate)
- [Credits](#credits)

## Overview

This SwiftUI Demo Project demonstrates key features of iOS development using SwiftUI, leveraging clean architecture principles. The project is built using reusable components and protocols encapsulated in embedded Swift packages for flexibility and scalability.

The main screen consists of a menu list, with each menu item presenting a demo container view. Each demo implements a SwiftUI feature, inspired by various blog posts, and highlights best practices for building modern iOS applications with SwiftUI.

## Features

- **Clean Mobile Architecture**: The project uses a modular architecture where each component follows the Single Responsibility Principle, making the codebase easy to extend and maintain.
- **Embedded Swift Packages**:
  - **Layout Package**: Contains reusable UI components to build scalable, responsive layouts.
  - **Architecture Package**: Provides core protocols that enforce separation of concerns and guide the implementation of the mobile architecture.
- **SwiftUI Demos**: Each demo showcases SwiftUI features, such as custom animations, particle effects, and more, drawing from a variety of resources.

## Architecture

The project follows a **clean architecture** pattern, focusing on the separation of UI, business logic, and data. Protocols are defined in the **Architecture package**, and client code conforms to these protocols to implement the specific app behavior. This ensures scalability, maintainability, and reusability across different parts of the project.

### Main Components:
- **Menu List**: The main menu presents a list of available demos, each of which is navigable to showcase the respective SwiftUI feature.
- **Demo Views**: Each demo container view illustrates a specific SwiftUI feature.
- **Reusable UI Components**: Components from the **Layout Package** are used throughout the app to maintain consistency and reusability.

## Packages

The project integrates several Swift packages for a clean and modular architecture:

### Layout Package
A package containing reusable SwiftUI components to facilitate building dynamic and flexible layouts.

### Architecture Package
A package defining protocols that structure the overall architecture, encouraging clear separation of UI and business logic.

## Demo List

Each demo is derived from a blog post or article that inspired the implementation. Below is the list of demos and the corresponding sources.

1. **Particle Effect Demo**  
   - Demonstrates custom particle effects using SwiftUI transitions.
   - **Inspired by**: [objc.io - Swift Talk # 418](https://talk.objc.io/episodes/S01E418-particle-effects-part-1)

_(Add more demos as necessary.)_

## Requirements

- iOS 14.0+ / iPadOS 14.0+
- Xcode 12.0+
- Swift 5.3+

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/swiftui-demo-project.git

2. Open the Xcode project:
    ```bash
    cd swiftui-demo-project
    open SwiftUIDemo.xcodeproj

3. Build and run the project on a simulator or device.

## Contributing

We welcome contributions to improve this project! If you’re interested in adding new SwiftUI demos, enhancing the architecture, or fixing bugs, feel free to contribute.

### How to Contribute

1.	Fork the repository.

2.	Create a new branch:
     ```bash
     git checkout -b feature/your-feature-name

3.  Commit your changes:
     ```bash
     git commit -m "Add new feature or fix"

4.	Push to your branch:
     ```bash
     git push origin feature/your-feature-name

5.	Create a Pull Request on GitHub.

### Pull Request Guidelines

- Ensure that your feature or fix adheres to the existing architecture patterns (or explain why a change is needed).
- Add or update tests if appropriate.
- Include documentation for any new functionality.
- Cite any external resources (such as blog posts or tutorials) you used for inspiration.

## How to Collaborate

We encourage collaboration from iOS developers interested in learning or experimenting with SwiftUI features. If you would like to collaborate with others on this project, here are some ways to get involved:

- Explore Issues: Check the [Issues](https://github.com/AppManJones/MobileShowcase/issues) tab to see if there are open bugs or features that you can help with.
- Open a Discussion: Use the [Discussions](https://github.com/AppManJones/MobileShowcase/discussions) tab to share ideas, propose new demos, or ask questions.
- Submit Feature Requests: If you have ideas for new demos or features, feel free to [submit a request](https://github.com/AppManJones/MobileShowcase/issues/new).

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.