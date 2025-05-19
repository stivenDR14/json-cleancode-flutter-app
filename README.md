# mint_test

**mint_test** is a modern Flutter application that implements a clean and scalable architecture, using professional patterns and libraries such as BLoC, Dio, GetIt, dependency injection, and the repository pattern. The project is designed to be easily maintainable, testable, and extensible.

---

## Table of Contents

- [General Architecture](#general-architecture)
- [Libraries and Patterns Used](#libraries-and-patterns-used)
- [Project Structure](#project-structure)
- [Data Modeling](#data-modeling)
- [Data Flow and States](#data-flow-and-states)
- [Dependency Injection and Singleton](#dependency-injection-and-singleton)
- [Repository Pattern](#repository-pattern)
- [UI and User Experience](#ui-and-user-experience)
- [How to Run the Project](#how-to-run-the-project)

---

## General Architecture

The project follows the principles of **Clean Architecture**, clearly separating the presentation, domain, and data layers. This allows for decoupled development, where each layer has well-defined responsibilities and can evolve independently.

- **Presentation:** Widgets, Cubits/BLoC, pages, and UI components.
- **Domain:** Entities, abstract repositories, business logic.
- **Data:** Repository implementations, data sources, network models.

---

## Libraries and Patterns Used

### 1. **BLoC / Cubit**

- Uses `flutter_bloc` for reactive and decoupled state management.
- Cubits manage presentation logic and expose states to the UI.

### 2. **Dio**

- Robust HTTP client for consuming REST APIs.
- Allows interceptors, error handling, and advanced request configuration.

### 3. **GetIt**

- Dependency injection container (Service Locator).
- Allows registering singletons and factories to access services and repositories from anywhere in the app.

### 4. **Repository Pattern**

- An abstraction (`ResourcesRepository`) is defined in the domain layer.
- The concrete implementation (`ResourcesRepositoryImpl`) lives in the data layer and uses Dio to fetch information.
- Allows changing the data source (API, local, mock) without affecting business logic or UI.

### 5. **Dependency Injection and Singleton**

- All main dependencies (Dio, repositories, localization) are registered as singletons in GetIt.
- This ensures that there is a single instance of each service and facilitates testing and maintenance.

---

## Project Structure

```
lib/
├── core/
│   ├── constants/         # Colors, themes, texts, and localization
│   └── resources/         # General utilities (e.g., JsonReader)
├── config/
│   ├── di/                # Dependency injection (GetIt)
│   ├── provider/          # Providers setup (BlocProvider)
│   └── router/            # App routing
├── features/
│   └── tabs-layout/
│       ├── data/          # Repository implementations
│       ├── domain/        # Entities and abstract repositories
│       └── presentation/  # Cubits, pages, and UI widgets
│   └── content/
│       └── presentation/  # Reusable widgets (e.g., SearchBar, Items, Table)
└── main.dart              # App entry point
```

---

## Data Modeling

Data is modeled using pure Dart classes, with `fromJson` and `toJson` methods to facilitate serialization/deserialization.

Example of modeling:

```dart
class SlotData {
  final String categoryName;
  final String eventName;
  final List<SlotGroup> slotGroups;
  // ...
}

class SlotGroup {
  final String slotGroupName;
  final List<Resource> resources;
  // ...
}

class Resource {
  final String firstName;
  final String name;
  final String userId;
  final String photo;
  final List<String> certificates;
  // ...
}
```

This allows for safe and typed handling of information throughout the app.

---

## Data Flow and States

1. **The UI** (e.g., a page with tabs) requests data through a Cubit.
2. **The Cubit** calls the abstract repository, which is injected via GetIt.
3. **The Repository** implements the logic to fetch the data (e.g., using Dio to make an HTTP request).
4. **The Cubit** emits states (`Loading`, `Loaded`, `Error`) that the UI listens to and reacts by showing loaders, data, or error messages.
5. **The UI** automatically updates according to the emitted state.

---

## Dependency Injection and Singleton

In `config/di/locator.dart`, all main dependencies are initialized and registered:

```dart
final locator = GetIt.instance;

Future<void> initializeDependencies() async {
  final dio = Dio(...);
  locator.registerSingleton<Dio>(dio);
  locator.registerSingleton<ResourcesRepository>(ResourcesRepositoryImpl(dio: dio));
  // Other services...
}
```

This allows accessing any service from anywhere in the app without having to pass them manually.

---

## Repository Pattern

The abstract repository defines the interface:

```dart
abstract class ResourcesRepository {
  Future<SlotData> getData();
}
```

The concrete implementation uses Dio to fetch the data:

```dart
class ResourcesRepositoryImpl implements ResourcesRepository {
  final Dio _dio;

  ResourcesRepositoryImpl({required Dio dio}) : _dio = dio;

  @override
  Future<SlotData> getData() async {
    final response = await _dio.get('/endpoint');
    return SlotData.fromJson(response.data);
  }
}
```

This allows decoupling the data source from the business logic and UI, facilitating testing and scalability.

---

## UI and User Experience

- **Responsive and Adaptive:** All UI components are designed to be responsive, adapting to both mobile and desktop devices.
- **Reusable Components:** Widgets like `CustomSearchBar`, `Items`, and `CertificatesTable` allow for a consistent and modern experience.
- **Animations and UX:** Smooth animations are used for list deployment, icon rotation, and button appearance, improving user interaction.
- **Themes and Colors:** Colors and styles are centralized in `AppColors` and global themes, ensuring visual coherence throughout the app.

---

## How to Run the Project

1. **Clone the repository:**

   ```sh
   git clone <repo-url>
   cd mint_test
   ```

2. **Install dependencies:**

   ```sh
   flutter pub get
   ```

3. **Configure lib/core/constants/localization/labels.dart file if necessary.**

4. **Run the app:**
   ```sh
   flutter run
   ```

---

## Conclusion

This project is a robust example of how to structure a professional Flutter application using Clean Architecture, BLoC, dependency injection, repository pattern, and good UI/UX practices.  
The modular structure and the use of advanced patterns facilitate maintenance, scalability, and collaboration in development teams.

---

Questions about any pattern, section, or flow? Don't hesitate to ask!
