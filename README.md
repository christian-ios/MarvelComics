# Marvel Comic Viewer
Overview
This project is a Marvel Comic Viewer app that displays a list of comics and details about a specific comic books using Marvel's Developer API. The app shows the comic book title, description, and cover image. It is built for iOS and demonstrates my approach to clean architecture, design patterns, and testing practices.

# Features
Displays list of comic books from Marvel's comic book endpoint
Allows user to search by comic book title
Displays the comic book title, description, and cover image.
Implements clean MVVM architecture.
Includes unit tests and UI tests.

# Architecture and Design
Architecture:
The app follows the Model-View-ViewModel (MVVM) architecture, which helps separate concerns and makes the code more maintainable and testable.
Model: Represents the data structures used in the app, to select the comic book details fetched from the Marvel API.
View: Consists of the UI components that display the data to the user.
ViewModel: Interfaces the Model and the View. It fetches data using the network services and the comic model to display on the Views.
Network Layer: Handles the API request and authentication to the Marvel Developer API. This layer includes a network manager that performs the network calls and decodes the JSON responses into model objects.
Testing: Includes both UI tests and unit tests to ensure the app's functionality and stability.

# Setup and Installation
Prerequisites
Xcode 15 or later
Tested on iPhone Simulator 17.4+

# Running the Project
Clone the repository:
git clone https://github.com/christian-ios/MarvelComics
Open the project in Xcode:
MarvelComics.xcodeproj
Build and run the project in Xcode.

# Frameworks Used
URLSession: For network requests
Codable: For JSON parsing
SwiftUI: For building the user interface
ObservableObject & @Published: For handling state and data binding in SwiftUI

---------------------------

# Adding Developer Keys
To use the Marvel Developer API, you need to add your own API keys. Follow these steps:
Sign up for a Marvel Developer account at Marvel Developer at https://developer.marvel.com/

Obtain your public and private API keys and add the keys to your Info.plist file:

<key>MarvelPublicKey</key>
<string>YOUR_PUBLIC_KEY</string>
<key>MarvelPrivateKey</key>
<string>YOUR_PRIVATE_KEY</string>

---------------------------

# Future Updates:
Implement read nNow feature
Mark as read feature
Add to library feature
Read Offline feature
Add additional UI Tests
Add App Icon
Add onboarding, to guide user on how to use the application
Add data parsistence to integrate image caching, and track read status, library and offline storage,

---------------------------
# Created by Christian Curiel
