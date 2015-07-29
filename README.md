## Rain Shield
Rain Shield is a project that tells if it will be raining today. It does so by getting current location and downloading forecast data. Instead of presenting table view with each forecast it filters considerable items to those from today and then checks if any has rain prognose. I believe this is true MVP to the problem presented in user story.

The WeatherForecast object contains all received forecast items. Using that information it is possible to easily extend the app to show detailed forecast below the main section.

## Requirements

- iOS 8.0+
- Xcode 7 beta 4

#### Installation
 - don't forget to run 'pod install' after cloning the project. 
 - use only .xcworkspace file, otherwise Unit Tests target won't compile.


###Biggest known impediments

 - Weather only refreshes one time after application load (not perfect at all)
 - No UI tests yet, this makes view controller completely untested


