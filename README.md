# MovieZ

A cool app to find out Trending and Now Playing Movies powered by themoviedb.org API.

## Features
* As a User I should be able to list the most popular movies. 
* As a User I should be able to list the now playing movies. 
* As a User I should see the option to change between a list and a grid view. 
* As a User I should be able to see for each movie the following details :
  * Name
  * Poster
  * Genres
  * Overview
  * Popularity
  * Release date
  * Languages
  * Vote average
* As a User I should be able to save my favorite movies and I want to see my stored preferences when I open the app again (offline access).
* As a User I should be able to keep scrolling and new results should appear (pagination).
* As a User I should be able to search for a movie with a given title locally in real time.
* * As a User I should see the different possible errors (error handling).
  * UnitTesting/ Basic UITesting

## Bonus 🔥
* Multi Language (EN, ES)
* Dark Mode
* Logger heleper
* Local movies search feature
* Modular Design
* Architecture diagram

## Installation

In order to run the app, a configuration file needs to be created to set the environment for the App and the proper service information like Auth Token.

### Create a file in the root of your project called: `.envconfig`

```bash
vi .envconfig
```

There you must set the Services Information required to consume the API
(⚠️ Note: Not the API_Key but the Auth Bearer Token) 

## Usage

```bash
//
//  EnvConfig.xcconfig
//  Moviez
//
//

//Please Set your API TOKEN
API_TOKEN=YOUR_TOKEN

//Please Set the App Environment (MOCK | DEV | PROD)
APP_ENVIRONMENT=DEV

//Please Set the corresponding Network Services Host Information
HOST_SCHEME=https
HOST_BASE_URL=api.themoviedb.org
HOST_IMAGE_URL=image.tmdb.org

```

Then just run the project and enjoy!!!

## App Architecture

The app was built using Clean Architecture and MVVM in SwiftUI, with Clean architecture we aim for the separation of concerns among components and as for MVVM, along with TCA, are ones of the most viable options to use for SwiftUI app architecture, hence MVVM was selected since it is a more traditional and widely adopted pattern, separating concerns between UI, presentation logic, and data/business logic.

High Level Design of the MovieZ App:

<img width="1326" alt="app_architecture" src="https://github.com/user-attachments/assets/d9ca4b4c-75dc-4e86-9552-9becdc0fbdfc">

## How to get a token from TheMovieDB
To access to TheMovieDB API is neccessary get a API KEY and access token: 
* To register for an API key, click the [API link](https://www.themoviedb.org/settings/api) from within your account settings page.

Also you can read more about the API over [here](https://developer.themoviedb.org/docs).
