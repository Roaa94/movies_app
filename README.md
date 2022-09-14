# Movies App

![Coverage](coverage_badge.svg)
[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)
[![HitCount](https://hits.dwyl.com/roaa94/movies_app.svg?style=flat-square&show=unique)](http://hits.dwyl.com/roaa94/movies_app)

A Flutter app that uses the "[The Movie DB](https://www.themoviedb.org/)" api to fetch popular people and their info (their movies, images, ..etc). [(API version 3 is used)](https://developers.themoviedb.org/3/people/get-popular-people)


🎨 [Design inspiration](https://dribbble.com/shots/7902411-Actors-Tracking-App/attachments/499926?mode=media)

### Content

* [Running the App](#running-the-app)
* [Previews](#previews)
* [App Architecture & Folder Structure](#app-architecture-and-folder-structure)
* [Http Caching](#http-caching)
* [Infinite Scroll Functionality](#infinite-scroll-functionality)
* [Testing with Riverpod](#testing-with-riverpod)
    1. [Dart-only testing](#1-dart-only-testing) 
    2. [Flutter Widget Tests](#2-flutter-widget-tests)

## Running the App
An api key from The Movie DB is required to run the app. Then you can run the app by adding the following run arguments:
```
--dart-define=TMDB_API_KEY=<YOUR_API_KEY>
```

## Previews

### Inifnite Scrolling & Hero Transition

(Paginated list with Riverpod providers, [more information below](#infinite-scroll-functionality) 👇🏼)

<div style="display: flex">
<img style="display: inline-block" src="https://user-images.githubusercontent.com/50345358/181906034-a33123c5-cddc-4d38-a8f2-e5c616cc5d48.gif" />

<img style="display: inline-block" src="https://user-images.githubusercontent.com/50345358/181905989-e2cb9205-7100-4212-bb4e-794900dcc68f.gif" />
</div>

## App Architecture and Folder Structure

The code of the app implements clean architecture to separate the UI, domain and data layers with a feature-first approach for folder structure.

#### Folder Structure

```
lib
├── core
│   ├── configs
│   ├── exceptions
│   ├── models
│   ├── services
│   │   ├── http
│   │   └── storage
│   └── widgets
├── features
│   ├── media
│   │   ├── enums
│   │   ├── models
│   │   ├── providers
│   │   ├── repositories
│   │   └── views
│   │       ├── pages
│   │       └── widgets
│   ├── people
│   │   ├── enums
│   │   ├── models
│   │   ├── providers
│   │   ├── repositories
│   │   └── views
│   │       ├── pages
│   │       └── widgets
│   └── tmdb-configs
│       ├── enums
│       ├── models
│       ├── providers
│       └── repositories
├── main.dart
└── movies_app.dart
```
    
* `main.dart` file has services initialization code and wraps the root `MoviesApp` with a `ProviderScope`
* `movies_app.dart` has the root `MaterialApp` and fetches the TMDB configs necessary to generate links for the images of the TMDB API endpoints inside the app
* The `core` folder contains code shared across features
    * `configs` contain general styles (colors, themes & text styles)
    * `services` abstract app-level services with their implementations
        *  `http` service is implemented with [`Dio`](https://pub.dev/packages/dio) and uses a `CacheInterceptor` to achieve caching by using the `StorageService` ([more information about caching below](#http-caching) 👇🏼)
        *  `storage` service is implemented with [`Hive`](https://pub.dev/packages/hive_flutter)
        *  Service locator pattern and Riverpod are used to abstract services when used in other layers.

For example:
```dart
final storageServiceProvider = Provider<StorageService>(
  (_) => HiveStorageService(),
);

// Usage:
// ref.watch(storageServiceProvider)
```
* The `features` folder: the repository pattern is used to decouple logic required to access data sources from the domain layer. For example, the `PeopleRepository` abstracts and centralizes the various functionality required to access `People` from the TMDB API.

```dart
abstract class PeopleRepository {
  String get path;

  String get apiKey;

  Future<Person> getPersonDetails(
    int personId, {
    bool forceRefresh = false,
    required TMDBImageConfigs imageConfigs,
  });
  
  //...
}
```
The repository implementation with the `HttpService`:

```dart
class HttpPeopleRepository implements PeopleRepository {
  final HttpService httpService;

  HttpPeopleRepository(this.httpService);

  @override
  String get path => '/person';

  @override
  String get apiKey => Configs.tmdbAPIKey;

  @override
  Future<Person> getPersonDetails(
    int personId, {
    bool forceRefresh = false,
    required TMDBImageConfigs imageConfigs,
  }) async {
    final responseData = await httpService.get(
      '$path/$personId',
      forceRefresh: forceRefresh,
      queryParameters: {
        'api_key': apiKey,
      },
    );

    return Person.fromJson(responseData).populateImages(imageConfigs);
  }
  
  //...
}
```
Using Riverpod `Provider` to access this implementation:

```dart
final peopleRepositoryProvider = Provider<PeopleRepository>(
  (ref) {
    final httpService = ref.watch(httpServiceProvider);

    return HttpPeopleRepository(httpService);
  },
);
```
And finally accessing the repository implementation from the UI layer using a Riverpod `FutureProvider`:

```dart
final personDetailsProvider = FutureProvider.family<Person, int>(
  (ref, personId) async {
    final peopleRepository = ref.watch(peopleRepositoryProvider);
    final tmdbConfigs = await ref.watch(tmdbConfigsProvider.future);

    return await peopleRepository.getPersonDetails(
      personId,
      imageConfigs: tmdbConfigs.images,
    );
  },
);
```
Notice how the abstract `HttpService` is accessed from the repository implementation and then the abstract `PeopleRepository` is accessed from the UI and how each of these layers acheive separation and scalability by providing the ability to switch implementation and make changes and/or test each layer seaparately. ([More about testing 👇🏼](#testing))

## Http Caching

To achieve caching http requests and the ability to show content to the user even when an error or loss of connectivity happens, a [`CacheInterceptor`](https://github.com/Roaa94/movies_app/blob/main/lib/core/services/http/dio-interceptors/cache_interceptor.dart) was created and added to `Dio`'s interceptor in the `DioHttpService` class. A Dio `Interceptor` has the following methods:

```dart
class CacheInterceptor implements Interceptor {
  final StorageService storageService;

  CacheInterceptor(this.storageService);
  
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
  }
}
```
By depending on our `StorageService` we were able to cache a reposnse when it doesn't exist in storage and when its `age` duration has not passed, and return that cache in case of error in the `onError` method.

## Infinite Scroll Functionality

Infinite scrolling was achieved by utilizing Riverpod's providers and the ListView's `itemBuilder` param whithout needing the complication of listening to scrolling events. The itemBuilder runs on each item build when it comes into view, if the data of this item is available it displays it, if it's not, the next page is fetched. Here is the code with explanation in the comments:

#### The providers you need:

```dart
/// The FutureProvider that does the fetching of the paginated list of people
final paginatedPopularPeopleProvider =
    FutureProvider.family<PaginatedResponse<Person>, int>(
  (ref, int pageIndex) async {
    final peopleRepository = ref.watch(peopleRepositoryProvider);
    // The API request:
    return await peopleRepository.getPopularPeople(page: pageIndex + 1);
  },
);

/// The provider that has the value of the total count of the list items
///
/// The [PaginatedResponse] class contains information about the total number of
/// pages and the total results in all pages along with a list of the provided type
///
/// An example response from the API for any page looks like this:
/// {
///   "page": 1,
///   "results": [], // list of 20 items
///   "total_pages": 500,
///   "total_results": 10000 // Value taken by this provider
/// }
final popularPeopleCountProvider = Provider<AsyncValue<int>>((ref) {
  return ref.watch(paginatedPopularPeopleProvider(0)).whenData(
        (PaginatedResponse<Person> pageData) => pageData.totalResults,
      );
});

/// The provider that provides the Person data for each list item
///
/// Initially it throws an UnimplementedError because we won't use it before overriding it
final currentPopularPersonProvider = Provider<AsyncValue<Person>>((ref) {
  throw UnimplementedError();
});
```

#### Using this in the widgets code

```dart

/// The provider that provides the Person data for each list item
///
/// Initially it throws an UnimplementedError because we won't use it before overriding it
final currentPopularPersonProvider = Provider<AsyncValue<Person>>((ref) {
  throw UnimplementedError();
});

class PopularPeopleList extends ConsumerWidget {
  const PopularPeopleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final popularPeopleCount = ref.watch(popularPeopleCountProvider);

    // The ListView's count is from the popularPeopleCountProvider which
    // by watching it here, causes the first fetch with a page index of 0
    return popularPeopleCount.when(
      loading: () => const CircularProgressIndicator(),
      data: (int count) {
        return ListView.builder(
          itemCount: count,
          itemBuilder: (context, index) {
            // At this point the paginatedPopularPeopleProvider stores the values of the
            // list items of at least the first page
            //
            // (index ~/ 20): Performing a truncating division of the list item index by the number of
            // items per page gives us the value of the current page that we then access using the
            // family modifier of the paginatedPopularPeopleProvider provider
            // This way calling 21 ~/ 20 = 1 will fetch the second page,
            // and 41 ~/ 20 = 2 will fetch the 3rd page, and so on.
            final AsyncValue<Person> currentPopularPersonFromIndex = ref
                .watch(paginatedPopularPeopleProvider(index ~/ 20))
                .whenData((pageData) => pageData.results[index % 20]);

            return ProviderScope(
              overrides: [
                // Override the Unimplemented provider
                currentPopularPersonProvider
                    .overrideWithValue(currentPopularPersonFromIndex)
              ],
              child: const PopularPersonListItem(),
            );
          },
        );
      },
      // Handle error
      error: (_, __) => const Icon(Icons.error),
    );
  }
}

class PopularPersonListItem extends ConsumerWidget {
  const PopularPersonListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Here we don't need to do anything but listen to the currentPopularPersonProvider's
    // AsyncValue that was overridden in the ListView's builder
    final AsyncValue<Person> personAsync =
        ref.watch(currentPopularPersonProvider);

    return Container(
      child: personAsync.when(
        data: (Person person) => Container(/* ... */), // List item content
        loading: () => const CircularProgressIndicator(), // Handle loading
        error: (_, __) => const Icon(Icons.error), // Handle Error
      ),
    );
  }
}
```


## Testing

The `test` folder mirrors the `lib` folder in addition to some test utilities. And more tests will be added. 

[`http_mock_adapter`](https://pub.dev/packages/http_mock_adapter) is used to test the `DioHttpService` and mock http requests.

[`hive_test`](https://pub.dev/packages/hive_test) is used to test the `HiveStorageService` and mock storage methods.

[`mocktail`](https://pub.dev/packages/mocktail) is used to mock dependecies.

### Testing with Riverpod

Testing with Riverpod is hassle-free and simple. You can test your providers separately from Flutter, and you can test how they behave in your widgets with widget testing. You can find helpful information about this in the [official docs](https://riverpod.dev/docs/cookbooks/testing). But let's see examples from this repo to have a look at both methods for different kinds of Riverpod providers.

#### 1. Dart-only Testing

Simply we can read our providers with a `ProviderContainer` and we should make sure to dispose it and not share it between tests. The `ProviderContainer` takes an `overrides` param which you can provide your mocks to.

#### 1.1 Testing the simple `Provider` provider:

This is the simplest provider and it's the easiest to test:

```dart
final foo = Provider<String>((_) => 'bar');

void main() {
  test('foo is a bar', () {
    final providerContainer = ProviderContainer();
    addTearDown(providerContainer.dispose);

    expect(providerContainer.read(foo), equals('bar'));
  });
}
```

In this app, I am making sure my abstract services and repository providers return the correct implementations by doing these simple tests:

```dart
// service provider
final storageServiceProvider = Provider<StorageService>((_) => HiveStorageService());

// test
void main() {
  test('serviceProvider returns HiveStorageService', () {
    final providerContainer = ProviderContainer();
    addTearDown(providerContainer.dispose);

    expect(
      providerContainer.read(storageServiceProvider),
      isA<HiveStorageService>(),
    );
  });
}
```

#### 1.2 Testing the `FutureProvider` provider:

Let's take our `tmdbConfigsProvider` as an example:

```dart
final tmdbConfigsProvider = FutureProvider<TMDBConfigs>((ref) async {
  final tmdbConfigsRepository = ref.watch(tmdbConfigsRepositoryProvider);

  return await tmdbConfigsRepository.get();
});
```

And here is how we can test it separately from Flutter:

```dart
// Mocks
class MockTMDBConfigsRepository extends Mock implements TMDBConfigsRepository {}

class Listener<T> extends Mock {
  void call(T? previous, T value);
}

// Test
void main() {
  final TMDBConfigsRepository mockTMDBConfigsRepository =
      MockTMDBConfigsRepository();

  test('fetches TMDB configs', () async {
    when(() => mockTMDBConfigsRepository.get(forceRefresh: false))
        .thenAnswer((_) async => DummyConfigs.tmdbConfigs);

    final tmdbConfigsListener = Listener<AsyncValue<TMDBConfigs>>();

    final providerContainer = ProviderContainer(
      overrides: [
        // Replace the TMDB Configs repository with the Mock Repository
        tmdbConfigsRepositoryProvider
            .overrideWithValue(mockTMDBConfigsRepository),
      ],
    );

    addTearDown(providerContainer.dispose);

    providerContainer.listen<AsyncValue<TMDBConfigs>>(
      tmdbConfigsProvider,
      tmdbConfigsListener,
      fireImmediately: true,
    );

    // Perform first reading, expects loading state
    final firstReading = providerContainer.read(tmdbConfigsProvider);
    expect(firstReading, const AsyncValue<TMDBConfigs>.loading());

    // Listener was fired from `null` to loading AsyncValue
    verify(() => tmdbConfigsListener(
          null,
          const AsyncValue<TMDBConfigs>.loading(),
        )).called(1);

    // Perform second reading, by waiting for the request, expects fetched data
    final secondReading = await providerContainer.read(tmdbConfigsProvider.future);
    expect(secondReading, DummyConfigs.tmdbConfigs);

    // Listener was fired from loading to fetched values
    verify(() => tmdbConfigsListener(
      const AsyncValue<TMDBConfigs>.loading(),
      const AsyncValue<TMDBConfigs>.data(DummyConfigs.tmdbConfigs),
    )).called(1);
    
    // No further listener events fired
    verifyNoMoreInteractions(tmdbConfigsListener);
  });
}
```

#### 2. Flutter Widget Tests

We can simply wrap our pumped widget in our widget test with a `ProviderScope` and provide it with the mocks using the `overrides` param.

Let's see how we can test the same `tmdbConfigsProvider` to see how if it behaves as we want in our root `MoviesApp` widget. Basically it should render the `AppLoader` widget while loading, the `ErrorView` widget in case of error, and finally the `PopularPeoplePage` widget when the request completes successfully.

```dart
void main() {
  final TMDBConfigsRepository mockTMDBConfigsRepository =
      MockTMDBConfigsRepository();

  testWidgets('renders ErrorView for request error',
      (WidgetTester tester) async {
    when(() => mockTMDBConfigsRepository.get(forceRefresh: false))
        .thenThrow('An Error Occurred!');

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          // Replace the TMDB Configs repository with the Mock Repository
          tmdbConfigsRepositoryProvider
              .overrideWithValue(mockTMDBConfigsRepository),
        ],
        child: const MoviesApp(),
      ),
    );

    // Initially loading
    expect(find.byType(AppLoader), findsOneWidget);

    // Re-render to make sure fetching is finished
    await tester.pumpAndSettle();

    // Shows error view
    expect(find.byType(ErrorView), findsOneWidget);
  });

  testWidgets(
    'renders PopularPeoplePage widget on request success',
    (WidgetTester tester) async {
      when(() => mockTMDBConfigsRepository.get(forceRefresh: false))
          .thenAnswer((_) async => DummyConfigs.tmdbConfigs);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            // Replace the TMDB Configs repository with the Mock Repository
            tmdbConfigsRepositoryProvider
                .overrideWithValue(mockTMDBConfigsRepository),
          ],
          child: const MoviesApp(),
        ),
      );

      // Initially loading
      expect(find.byType(AppLoader), findsOneWidget);

      // Re-render to make sure fetching is finished
      await tester.pumpAndSettle();

      expect(find.byType(PopularPeoplePage), findsOneWidget);
    },
  );
}
```


To explore the test coverage, run tests with --coverage argument
```
flutter test --coverage
```
Then generate coverage files
```
genhtml coverage/lcov.info -o coverage/html
```
Then open the html files:
```
open coverage/html/index.html
```
