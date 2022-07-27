# Movies App

A Flutter app that uses the "[The Movie DB](https://www.themoviedb.org/)" api to fetch popular people and their info (their movies, images, ..etc). [(API version 3 is used)](https://developers.themoviedb.org/3/people/get-popular-people)


🎨 [Design inspiration](https://dribbble.com/shots/7902411-Actors-Tracking-App/attachments/499926?mode=media)

## Running the App
An api key from The Movie DB is required to run the app. Then you can run the app by adding the following run arguments:
```
--dart-define=TMDB_API_KEY=<YOUR_API_KEY>
```

## Test Coverage

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

(More information about App Architecture and folder structure will be added)
