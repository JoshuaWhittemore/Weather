# README

## TLDR
This repo is for a Rails app that provides the weather and forecast for locations in the United States.

Once deployed, a user can enter a location into a form on the root page of the app to get the forecast and the weather at that location.

1. Enter location
The location can be entered in several ways, including:
* a zip code, like '01770'
* a city & state, like "New York, New York" or "New York NY", etc.
* a full address, like "1600 Pennsylvania Ave, Washington, D.C, 20500" etc.

![Index Page](/images/index-page.png)

2. App returns page with current weather at location and extended forecast.

![Index Page](/images/show-page.png)

## Dependencies
* The app was developed on Ruby 3.1.1 and Rails 7.1.1.
* The app uses the geocoder gem, which will hit the free service provided by Nominatim.  This is rate limited to 1-2 requests per second.
* The app also uses the openweathermap one call 2.5 API to get the weather.  This is limited to 1000 requests per day (free tier).
* I used `standardrb` to lint my code. 


## Test coverage
* There is test coverage, although not as much as I would like.
```bash
(base) weather $ rails test -v
Running 6 tests in a single process (parallelization threshold is 50)
Run options: -v --seed 24026

# Running:

WeatherServiceTest#test_gets_weather_data = 0.22 s = .
LocationServiceTest#test_finds_regular_address = 0.01 s = .
LocationServiceTest#test_finds_by_city_and_state = 0.01 s = .
LocationServiceTest#test_finds_by_zip_code_only = 0.01 s = .
WeatherControllerTest#test_should_get_index = 0.34 s = .
WeatherControllerTest#test_should_get_show = 0.03 s = .

Finished in 0.621461s, 9.6547 runs/s, 19.3093 assertions/s.
6 runs, 12 assertions, 0 failures, 0 errors, 0 skips
(base) weather
```

## TODO

There is a lot more that could be done.  Top of mind for me would be:

* Setup CI/CL process in github, of course.
* Broaden the test coverage, especially the presentation code in the view files and the code in the WeatherHelper class.
* Along those lines, use the TimeCop gem to test that the caching is working properly.
* Internationalize the app by providing support for locations outside the US and the capacity to switch to metric units and temperatures in Celsius.
* I'm using an environmental variable to hide the API key for the OpenWeatherMap service, it would be safer to keep it in Vault or something similar.  Same for the database passwords.
* I was pressed for time so I did not add as many comments I as normally would to make the code more comprehensible to others & myself.
* I usually squash my commits between releases, but I did not do it this time in case someone is interested in my process.  I apologize for my commit messages, some of which are not informative.
* Some places I used `#dig` where I was only going one layer deep and I should've used square brackets instead.

