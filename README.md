# Biblioteca Volta Mobile

This project aims to facilitate the management of an online library by providing a user-friendly interface. It allows basic users to browse books, view their borrowed books, receive notifications, and access their profiles. Users can also view detailed information about each book, including its categories, language, description, and availability in the physical library.
Administrators have additional functionalities, such as adding books via ISBN lookup from the Google Books API. The server processes and manages the retrieved book information before making it available to the application. Alternatively, administrators can manually input book details. They can modify existing book information, add or remove book copies, lend books, and perform actions similar to those of basic users.
The business logic of this application is written in Kotlin and shared across the iOS and Android platforms. The user interface is platform-specific, utilizing Kotlin Jetpack Compose for Android and SwiftUI for iOS.

## Features

- **User Features:**
  - Browse books
  - View borrowed books
  - Receive notifications
  - Access user profile

- **Book Features:**
  - View detailed book information
  - Categories, language, description, availability

- **Admin Features:**
  - Add books via ISBN lookup
  - Manual book entry
  - Modify existing book information
  - Add or remove book copies
  - Lend books

## Technology Stack

- **Backend:**
  - Language: Kotlin
  - Framework: Ktor

- **Frontend:**
  - Logic Business:
    - Language: Kotlin
    - Framework: Kotlin Multiplatform System
      
  - Android:
    - Language: Kotlin
    - Framework: Kotlin Jetpack Compose
      
  - iOS:
    - Language: Swift
    - Framework: SwiftUI

## Installation:

1. Clone the repository to your local machine.
   ```
   git clone https://github.com/eliorodr2104/Biblioteca_Volta_Mobile.git
   ```

2. Open the project in Android Studio IDE.

3. Build and run the project.


## License

This project is licensed under the [MIT License](LICENSE).
