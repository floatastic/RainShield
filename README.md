## Rain Shield
Rain Shield is a single view project that tells if it will be raining today. Additionaly it presents following week weather forecast in a table view. The idea is to not use any third party dependencies in executable target, to present a whole solution to the problem, top to bottom. 

## Requirements

- iOS 8.0+
- Xcode 7 beta 4

###Installation
 - don't forget to run 'pod install' after cloning the project. 
 - use only .xcworkspace file, otherwise Unit Tests target won't compile.


####Known impediments

 - Weather only refreshes one time after application load (not perfect at all)
 - No UI tests yet, this makes view controller completely untested


