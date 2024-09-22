# MovieZ

A cool app to find out Trending and Now Playing Movies powered by themoviedb.org API.

## Installation

In order to set the environment for the App and the proper service information and Auth Token, create a file in the root of your project called: .envconfig

```bash
vi .envconfig
```

There you can set the Services Information required to consume the API
(Note: Not the API_Key but the Auth Bearer Token) 

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

