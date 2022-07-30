# Movies App

A Flutter app that uses the "[The Movie DB](https://www.themoviedb.org/)" api to fetch popular people and their info (their movies, images, ..etc). [(API version 3 is used)](https://developers.themoviedb.org/3/people/get-popular-people)


🎨 [Design inspiration](https://dribbble.com/shots/7902411-Actors-Tracking-App/attachments/499926?mode=media)

## Running the App
An api key from The Movie DB is required to run the app. Then you can run the app by adding the following run arguments:
```
--dart-define=TMDB_API_KEY=<YOUR_API_KEY>
```

## Previews

### Inifnite Scrolling 

(Paginated list with Riverpod providers, [more information below](#infinite-scroll-functionality) 👇🏼)

![infinite-scrolling](https://user-images.githubusercontent.com/50345358/181906034-a33123c5-cddc-4d38-a8f2-e5c616cc5d48.gif)

### Hero Transition

![hero_animation](https://user-images.githubusercontent.com/50345358/181905989-e2cb9205-7100-4212-bb4e-794900dcc68f.gif)


## App Architecture and Folder Structure

(More information will be added)

## Infinite Scroll Functionality

(More information will be added)

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
