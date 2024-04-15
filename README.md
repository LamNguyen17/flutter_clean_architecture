## 🚀 Project using Clean Architecture recommend by Google Developer
This guide encompasses best practices and recommended architecture for building robust, high-quality apps
- [Guide to app architecture (Gooogle Developers)](https://developer.android.com/topic/architecture?continue=https%3A%2F%2Fdeveloper.android.com%2Fcourses%2Fpathways%2Fandroid-architecture%3Fhl%3Dvi%23article-https%3A%2F%2Fdeveloper.android.com%2Ftopic%2Farchitecture)
## Medium
- [Read Medium about my article](https://medium.com/@jyxjrpp/clean-architecture-trong-react-native-3b2c5c5bf3e)
## Introduction
This sample demonstrates how one can

- Setup base architecture of Flutter app using Clean Architecture
- Use dependency injection for layers separation
- Make api calls using Axios plugin.

```
├── common
|   └── helper
├── data
|   ├── config
|   ├── datasources
|   ├── gateway
|   ├── helper
|   ├── models
|   └── repositories
├── di (dependency injection)
├── domain 
|   ├── entities
|   ├── repositories
|   └── usecases
└── presentation
    ├── assests
    ├── components
    ├── contants
    ├── features
    ├── localizations
    ├── navigations
    └── utils
```

#### Dependencies
- [Dio](https://pub.dev/packages/dio) : http client
- [Get_it](https://pub.dev/packages/get_it) : dependency injection
- [Flutter_bloc](https://pub.dev/packages/flutter_bloc) : Flutter Widgets that make it easy to implement the BLoC (Business Logic Component) design pattern
- [Rxdart](https://pub.dev/packages/rxdart) : RxDart extends the capabilities of Dart Streams and StreamControllers.
- [Dartz](https://pub.dev/packages/dartz) : Functional programming in Dart.

# Module Structure

<p align="center">
  <img src="https://camo.githubusercontent.com/a5485a38e6af7aa1055807a47e1833fc9a35eb7b997940b26936dcffae760623/68747470733a2f2f6d69726f2e6d656469756d2e636f6d2f6d61782f3737322f302a73664344456235373157442d374566502e6a7067" />
</p>

There are 3 main modules to help separate the code. They are Data, Domain, and Presentaion.

- **Data** contains Local Storage, APIs, Data objects (Request/Response object, DB objects), and the repository implementation.

- **Domain** contains UseCases, Domain Objects/Models, and Repository Interfaces

- **Presentaion** contains UI, View Objects, Widgets, etc. Can be split into separate modules itself if needed. For example, we could have a module called Device handling things like camera, location, etc.


# Package structure
- Using modular architecture to architect the app per feature to be easier and more readable and isolate the feature from each other

# Repository
- Bridge between Data layer and Domain layer
- Connects to data sources and returns mapped data
- Data sources include DB and Api

# UseCase
- Responsible for connecting to repository to retrieve necessary data. returns a Stream that will emit each update.
- This is where the business logic takes place.
- Returns data downstream.
- Single use.
- Lives in Domain (No Platform dependencies. Very testable).

# Presentation (Holder)
- Organizes data and holds View state.
- Talks to use cases.

# Presentation (View)
- View,updates UI

## 🚀 UI example
![alt text](https://github.com/LamNguyen17/flutter_clean_architecture/blob/master/lib/presentation/assets/images/img.png)