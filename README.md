# NYTimesDemo

### Get API key
  
  Create a free NYT developer account at http://developer.nytimes.com/ to get a NYT API Key.

### To run the app
  #### From terminal
  go to Terminal
  go to project location 
  run 
  xcodebuild \
  -workspace MyAwesomeApp.xcworkspace \
  -scheme MyAwesomeApp \
  -sdk iphonesimulator \
  -destination 'platform=iOS Simulator,name=iPhone 6,OS=8.1' \
  test | xcpretty
### To run the test

### Generate code coverage data

Clone this repository and build an app from command line.

    git clone 
    
    cd [PROJECT_DIRECTORY]
    
    xcodebuild -project NYTimesDemo.xcodeproj/ -scheme NYTimesDemo -derivedDataPath Build/ -destination 'platform=iOS Simulator,OS=11.4,name=iPhone 8 Plus' -enableCodeCoverage YES clean build test CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO

This will dump all the DerivedData inside the Build directory.

This will generate the code coverage data at path Build/Logs/Test

### Coverage report

We can use `xccov` command line tool with `xcrun` untility if thats not inside the `$PATH` 

* View Report in the plain format 

            $ xcrun xccov view Build/Logs/Test/*.xccovreport

*  View Report in the JSON format 

            $ xcrun xccov view --json Build/Logs/Test/*.xccovreport

* List the files available for the code coverage data 

            $ xcrun xccov view --file-list Build/Logs/Test/*.xccovarchive/

* Show the coverage for perticular file 
        
            $ xcrun xccov view --file ~/Desktop/Projects/NYTimesDemo/AppDelegate.swift  Build/Logs/Test/*.xccovarchive/

