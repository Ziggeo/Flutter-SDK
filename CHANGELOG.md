## 0.2.6
----------------------------
* Added connection error callback.
## 0.2.5
----------------------------
* Migration SDK to github.
## 0.2.4
----------------------------
* Added pausable mode.

## 0.2.3
----------------------------
* Fixed Android 9 camera switch.

## 0.2.2
----------------------------
* Added blur mode support.

## 0.2.1
----------------------------
* Added audio, image api support.

## 0.2.0
----------------------------
* Added nullability support.
* Added cancelUpload method support.
* All changes from android native SDK v2.4.4

## 0.1.5
----------------------------
* Added support for a custom player/camera views.
* All changes from native SDK v2.2.4

## 0.1.4
----------------------------
* Fixed crash when starting analytics service in the background

## 0.1.3
----------------------------
* Added support for 1:1 aspect ratio

## 0.1.2
----------------------------
* Fixed mapping for server auth token

## 0.1.1
----------------------------
* New: added filters for file selector and switcher for grid/list modes
* New: changed toolbar icon in file selector from arrow to cross, other UI improvements
* Changes: 
  - `uploadingStarted` now contains `videoToken` instead of `path` in args
* Changed implementation for single-choice mode in file selector.
* Added ability to confirm uploading for file on Player screen.  
* Fixed session expiration issue which was blocking some cases for auth token.
* Fixed issue with sending analytics events when there is no app token. 
* Trimming request arguments 
* Changed UI for countdown timer 
* Dependencies updated 

## 0.1.0
Android support added in this version
  * Added demo and SDK functionality to demonstrate all common features for Android
  
## 0.0.1
Only Android support added in this version
  * set/get the application token
  * set/get the server auth token
  * start the camera recorder
  * start the video player (with tokens or paths)
  * upload files from the file selector
  * callbacks
