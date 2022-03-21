# Ziggeo's Flutter SDK

## Index

1. [Why Ziggeo's Flutter SDK?](#why-us)
2. [Prerequisites](#prerequisites)
	1. [Download](#download)
	2. [Dependencies](#dependencies)
	3. [Install](#install)
3. [Demo](#demo)
4. [Codes](#codes)
	1. [Init](#init)
	2. [Recorder](#recorder)
		1. [Video Camera Recorder](#video-recorder)
		2. [Video Screen Recorder](#screen-recorder)
		3. [Audio Recorder](#audio-recorder)
	3. [Player](#player)
		1. [Video Player](#video-player)
		2. [Audio Player](#audio-player)
	4. [QR Scanner](#qr-scanner)
	5. [Configs](#configs)
		1. [Theming](#theming)
		2. [Recorder Configs](#recorder-config)
	6. [Events / Callbacks](#events)
		1. [Global Callbacks](#callbacks-global)
		2. [Recorder Callbacks](#callbacks-recorder)
		3. [Player Callbacks](#callbacks-player)
		4. [Sensor Callbacks](#callbacks-sensor)
	7. [API](#api)
		1. [Request Cancellation](#api-cancel)
		2. [Videos API](#api-videos)
		3. [Video Streams API](#api-video-streams)
	8. [Authentication](#authentication)
5. [Compiling and Publishing App](#compile)
6. [Update Information](#update)
7. [Changelog](#changelog)


## Why Ziggeo's Flutter SDK? <a name="why-us"></a>

Ziggeo is award winning and powerfull whitelabel media SAAS. It allows you to quickly start creating apps with support for video, audio and image in the way that is simple and reliable.

Ziggeo's Flutter SDK is utilizing the API to bring you a native library you can add to your project. Just add to project and allow your application evolve into something much more, something video!

It offers you pre-built functionality to call and manipulate. This library also offers you direct access to the Ziggeo API as well if you want to do more things yourself.

### Who it is for?

Do you need a video library that can be seamlesly integrated into your existing app?

Want something that is simple and easy to use?

Need to have it available for both iOS and Android?

You need some powerful features high end video apps provide?

Want to provide a great video experience for your own customers?

If any of the above is "Yes" then you are in the right place as this SDK is for you!

## Prerequisites <a name="prerequisites"></a>

### Download <a name="download"></a>

You will want to either download the SDK zip file or to pull it in as git repository into your own project.

### Dependencies<a name="dependencies"></a>

Please use latest build tools and sdk version when compiling.

### Install<a name="install"></a>

Standard setps are needed to add and start using Ziggeo's Flutter SDK within your project.

## Demo<a name="demo"></a>

[This repository](https://github.com/Ziggeo/Flutter-SDK) has an example directory which would allow you to see how it can be used.

## Codes<a name="codes"></a>

This section will introduce you to the most common ways you would integrate our video library into your app.

### Init<a name="init"></a>

```
final String appToken = "YOUR_APP_TOKEN_HERE";
Ziggeo ziggeo = new Ziggeo(appToken);
```
- You can grab your appToken by logging [into your](https://ziggeo.com/signin) account and under application you will use > Overview you will see the app token.

### Recorder<a name="recorder"></a>

Ziggeo supports different media formats and offers multiple recorder options for you.
1. Video Camera Recorder
2. Video Screen Recorder
3. Audio Recorder

Each will be showcased within its own section bellow.

#### Video (Camera) Recorder<a name="video-recorder"></a>

You can utilze it as fullscreen as well as embedding recorder. The fullscreen recorder is useful when you want your recorder to take entire screen.

The embedded recorder is useful when you want your recorder to be part of your app. For example if you had an avatar in your app and you want it to be a quick video.

```
ziggeo.startCameraRecorder();
```

- See [Configs](#configs) section bellow to see how to configure the recorder with more specific options, instead of using defaults

#### Video (Screen) Recorder<a name="screen-recorder"></a>

By utilizing the following you will be creating a foreground service for screen recording

```
ziggeo.startScreenRecorder();
```

#### Audio Recorder<a name="audio-recorder"></a>

Audio Recorder can be added in 2 ways. As a fullscreen recorder and the embedded audio recorder.

The fullscreen audio recorder is useful when you want your recorder to take entire screen.

The embedded audio recorder is useful when you want your recorder to be part of your app. For example if you wanted the player to be something that is present while giving higher focus to other elements.

**Create fullscreen Audio Recorder**

```
ziggeo.startAudioRecorder();
```

**Create embedded Audio Recorder**

* Embeddable Audio Recorder is currently not available


### Player<a name="player"></a>

Capturing different types of media expects support for playback of the same. As such Ziggeo has a player for different type of media you might capture and use within your apps.

Ziggeo provides to following player:
1. Video Player
2. Audio Player

Each will be showcased within its own section bellow.

#### Video Player<a name="video-player"></a>

Player can be used to play local videos, videos from other services and of course videos from Ziggeo servers.

Just like recorder, the player can too be implemented as fullscreen or as embedded video player.

**Create fullscreen Video Player**

Standard Playback

```
ziggeo.startPlayerFromToken(List<String> videoTokens);
```

Playback from third-party source

```
ziggeo.startPlayerFromPath(List<String> videoPaths);
```

**Create embedded Video Player**

* Embedded Video Player is currently not available

#### Audio Player<a name="audio-player"></a>

Player can be used to play local audios, as well as audios from other services and of course audios from Ziggeo servers.

Just like video player, the audio player can be used as fullscreen or as embedded audio player.

**Create fullscreen Audio Player**

Standard Playback

```
ziggeo.startAudioPlayer(List<String> audioTokens);
```

Playback from third-party source

```
ziggeo.startAudioPlayer(List<String> path);
```

**Create embedded Audio Player**

* Embedded Audio Player is currently not available

### QR Scanner<a name="qr-scanner"></a>

QR Scanner makes it easy for your code to retrieve data from the captured QR code.

```
ziggeo.startQrScanner();
```

### Configs<a name="configs"></a>

Each embeddings (players and recorders) has default config and often a config you can set a bit differently if you wanted to.

This section will show you various options at your disposal.

#### Theming<a name="theming"></a>

* Theming is currently not available

#### Recorder Config<a name="recorder-config"></a>

Our recorder is utilizing helper class to define different properties of the recorder element. So we would always define it first. The recorder config is mutual for both audio and video recorders.

```
var recorderConfig = new RecorderConfig();
```

**Set max duration**

The duration of the recording is always set as endless, meaning there is no limit in how long your video or audio recording can be. The value for this is 0.

If you set it up with 30000 this would be equal to 30 seconds of recording, after which the recording will be automatically stopped.

- When set, this time will also be used in the elapsed time indicator at the top-right corner.
- Note: Duration is in milliseconds.

```
recorderConfig.maxDuration = 0;
```

**Set countdown time**

When camera capture is started, the person might not be ready or might need to adjust the device before they are ready for capture. By default our recorder offers 3 seconds before the actual recording starts.

- Note: If you set it to 0, the person recording themselves might need to turn their phone, flip camera, or to align themselves first before they would actually start so we suggest keeping it somewhere within 2-5 seconds.
- Note: Delay is set in seconds.

```
recorderConfig.startDelay = 3;
```

**Auto start recorder**

By default the recorder will show an option to start recording process. This is usually the preferred way for most use cases. In some use cases you might prefer that the recorder starts as soon as it is loaded up within the app. In such cases you can set the the following as true.

- Note: You might also want to check out `startDelay()` as well.

```
recorderConfig.shouldAutoStartRecording = false;
```

**Set which camera you prefer**

This option allows you to select which camera should be used for recording. By default the back camera is used, however you can change it with this option.

- Note: You can choose `facingFront` or `facingBack`

```
recorderConfig.facing = RecorderConfig.facingBack;
```

**Set the quality of recording**

Set the quality that you want to use for your video recording. Usually the higher the quality, the better, however in some specific usecases where quality is not as important you could use this option to change it.
The default quality is `qualityHigh`.

- Note: You can choose `qualityHigh`, `qualityMedium` and `qualityLow`.

```
recorderConfig.videoQuality = RecorderConfig.qualityHigh;
```

**Forbid camera switch during recording**

By default we allow the camera to be switched within the recorder. Sometimes this might not be desirable, and if so you can forbid the ability to switch by setting this to true.

```
recorderConfig.shouldDisableCameraSwitch = false;
```

**Submit videos immediately**

By default all videos are immediately sent to our servers. This allows them to be processed and to go through all of the workflows that you have set.
In some cases, you might want to show you button to confirm the video before it is sent or any other action you prefer, in which case you can delay this action.

- Note: You might also be interested in `shouldConfirmStopRecording`. 

```
recorderConfig.shouldSendImmediately = true;
```

**Show stop dialog**

In some cases you might want to be able to confirm after the recording is stopped. You could do that with our `shouldConfirmStopRecording` part of `recorderConfig`.

```
recorderConfig.shouldConfirmStopRecording = true;
```

* Confirm dialog is automatically created. At the moment it is not possible to create custom one.

**Set Extra Arguments**
This can be used to specify effect profiles, video profiles, custom data, tags, etc.

```
recorderConfig.extraArgs = map;
```

##### Extra arguments examples

**Working with Custom Data**

Custom data is set with extraArgs and represents a JSON Object as string. This custom-data can be anything that you want to attach to the media you are recording or uploading.

```
var args = new Map<String, dynamic>();
args["data"] = "{\"key\":\"value\"}";

recorderConfig.extraArgs = args;
```

**Applying Effect Profile**

If you would like to add your logo or apply some effect to every video that you record or upload, you will want to use effect profiles. They can be used by specifying the effect profile token or key.

- Note: If you are using effect profile key, please add `_` (underscore) before the name, even if the name has underscore within it (the first underscore is removed to match the key you are specifying).

```
var args = new Map<String, dynamic>();
args["effect_profile"] = "1234567890";

recorderConfig.extraArgs = args;
```

**Set Video Profile**

Video profiles allow you to create video in various resolutions of interest. For example if you want to upload a 1080p video and want to have its versions available in SD format as well, this would be the way to do it.

You can add the video profile token by adding video profile token or video profile key.

- Note: If you are using video profile key, please add `_` (underscore) before the name, even if the name has underscore within it (the first underscore is removed to match the key you are specifying).

```
var args = new Map<String, dynamic>();
args["video_profile"] = "1234567890";

recorderConfig.extraArgs = args;
```

* All recorders are using the same recorder config class as described above.

### Events / Callbacks<a name="events"></a>

Callbacks allow you to know when something happens. They fire in case of some event happening, such as if error occurs. This way you can design your app to fine detail and be able to provide you customers with great experience.

We have separated the events that are available to you into several different categories.

Before doing that, you will need to register a callback and this is done within the `recorderConfig`. If you are unsure how it is created please check section above [dedicated to it](#configs)

**Register callback**

```
recorderConfig.eventsListener = new RecorderEventsListener(...)
```

#### Global Callbacks<a name="callbacks-global"></a>


Global callbacks happen for both player and recorder. It usually does not depend on the embed method you have used, however each callback has additional details next to it.

**Error**

Ups, something unexpected happened! Now it's your time to react.

The following callback is called at any point in time when some error happens. It will also provide you with throwable parameter.

```
onError: (exception) => {}
```

**Loaded**

The embedding (player, recorder) is loaded up for the very first time after it was created

```
onLoaded: () => {}
```

#### Recorder Callbacks<a name="callbacks-recorder"></a>

The callbacks in this section are specific to recorder only. This means that they will not fire at all for the player embeds.

The callbacks are listed in the order that they should appear in within your code.

- Note: Some callbacks might not be called. For example if video is uploaded and not recorded, recording specific callbacks will never fire.

**Permissions are given**

Gets triggered when someone gives OK for our system to use camera, microphone and file storage.

```
onAccessGranted: () => {}
```

**Permissions are not given**

Some permissions are not given, so we can not do much at this point.

- Note: `permissions` parameter will share a list of permissions that were not granted.

```
onAccessForbidden: (permissions) => {}
```

**Camera is available**

Sometimes you might want to know that there is/are camera(s) available. This callback will fire when even one camera is available.

```
onHasCamera: () => {}
```

**Camera unavailable**

Most often the mobile device will have camera, however there are cases when camera can be disconnected, or it is otherwise unavailable. In such case, this event will fire.

```
onNoCamera: () => {}
```

**Microphone is available**

Most devices will have microphone available. It could however happen that it is not available, or that it is completely disconnected. This event will fire once we find any microphone.

```
onHasMicrophone: () => {}
```

**Microphone unavailable**

In most cases, the event above will be raised. In some specific cases, the microphone might not be available, at which time this event will be raised instead.

```
onNoMicrophone: () => {}
```

**Ready to record**

In most cases, once permissions are given, the recording can start and as such this callback will fire. It means that camera is ready and that all permissions are granted. All that is left is to start recording.

```
onReadyToRecord: () => {}
```

**Countdown to recording**

If you want to know when the countdown is shown, this event will be useful. It will be raised during countdown and right before the `recordingStarted` event.

- Note: The timeLeft will provide you with the seconds as they are shown on screen.

```
onCountdown: (time) => {}
```

**Recording has started**

This event fires once recording has just started. This is useful if you want to know that the video was recording and not upload since upload events will fire for all.

It can also be useful if you are using embedded recorder and you want to stop all other activities and bring more focus to the capture.

```
onRecordingStarted: () => {}
```

**Recording in progress**

This event is raised when recording is in process. This is a continuous update notification that will fire through entire duration of recording process.

- Note: `progress` parameter will let you know how much time has passed since the recording had started.

```
onRecordingProgress: (progress) =>
```

**Recording cancelled**

Want to detect if someone cancels the recording? Use this event to know when someone cancelled the recording and closed the screen.

```
onCanceledByUser: () => {} 
```

**Recording Finished**

This event will be raised when recording had just finished. It will happen in cases when the end user clicks on Stop button as well as if there was duration or size limit that was reached.

```
onRecordingStopped: (path) => {}
```

**Confirm Recording**

Need to make sure someone confirms the video submission? Use this callback and record its action on your side as you like.

As this might be a requirement in some countries you are utilizing your app, you can easily use this for any sort of confirmation of captured video.

- Note: Our code only fires this event. It is up to you to then use this event to capture and save that someone confirmed the use of the video and in what way. This is done so as it offers you most flexibility in what you want to do and how.
- Note: This will only be fired if you set the `shouldSendImmediately` to false. You can see more about it in the [Recorder Config](#recorder-config) section above.

```
onManuallySubmitted: () => {}
```

**Uploading started**

Want to know when upload starts? In that case you will want to listen to this event. It will be raised every time uploads start to happen.

```
onUploadingStarted: (path) => {}
```

**Upload progress**

Do you want to know the progress of the uploads? This event will be continuously raised as the uploaded data changes, allowing you to track the progress of every upload.  

```
onUploadProgress: (token, path, current, total) => {}
```

**Upload finished**

Want to know once upload finishes? Then you would want to listen to this event. Our SDK will raise it once all uploading is complete.

```
onUploaded: (token, path) => {}
```

**Media Verified**

Do you want to know if the media just uploaded can be processed? In most cases this is true, however in rare cases, it might not be possible.

This utilizes our quick check algorithm to inspect the media before it is sent to processing to see that it can actually be processed. This allows you to react if something is wrong with the media, before the processing stages. It also offers you a way to skip the processing stages, since once verified client side code can do anything, even if not related to the media.

```
onVerified: (token) =>  {}
```

**Processing**

While we do not offer an insight into how much of the media was processed, we can tell you how long it is going for. This event will be raised for the entire duration of media processing.

```
onProcessing: (token) => {}
```

**Processing Finished**

Interested in knowing when the media is successfully processed? Listening for this event will allow you to know just that. As soon as it fires, the media is available for playback

```
onProcessed: (token) => {}
```

#### Player Callbacks<a name="callbacks-player"></a>

**Media playback available**

Want to know once the player can play the video? This event will let you know once the media is available for playback. By listening to it, you can avoid listening to progress events as it will fire once the media is ready regardless if it has to be processed first, or if it is waiting to download the media to make it available for playback

```
onReadyToPlay: () => {}
```

**Playback started**

Want to react when playback is started? This event will be raised every time the playback is started.

```
onPlaying: () => {}
```

**Playback paused**

What to react when someone pause's the video?. This event will be raised when the Pause button is clicked.

- Note: It will also fire at the end of the video

```
onPaused: () => {}
```

**Playback Ended**

Want to know when the media playback ends? This event will be raised any time the playback reaches the end of media length.

```
onEnded: () => {}
```

**Playback seeking**

Want to know if and where to someone changes the point of playback (seeks the media)? This event will be raised when the person watching the media moves the player's progress indicator to a new position. This will fire for both going forward as well as going back in playback.

- Note: The value returned will be milliseconds of time when seek operation was set to, looking from the start.

```
onSeek: (seekPos) => {}
```

#### Sensor Callbacks<a name="callbacks-sensor"></a>

* Sensor callbacks are currently not available

### API<a name="api"></a>

Our API is split into unique segments. The main one is videos. This deals with the video and videos as a whole.

Now as each video can have streams (sub videos) we also have an API that can deal with each stream as well.

For example, removing a video will remove all of its streams. On the other hand when removing a single stream, the rest of streams and the video itself will stay available. Of course, except that one stream.

Ziggeo also has APIs for other nodes, however there is a difference in API features available for client vs server side SDKs. The client side SDK calls, are safe to be called from app, while server side SDKs and their calls should only be used on server side and then passed over to your app.

If you have any questions about the specifics, do reach out to our [support team](mailto:suppport@ziggeo.com)

#### Request Cancellation<a name="api-cancel"></a>

* Cancel request is not currently available

#### Videos API<a name="api-videos"></a>


**Find videos**

A way to find the videos based on your query and show them off. By default it is 50, however it can return back up to 100 videos at a time. Pagination control is also present.

- Note: For each call the videos will be returned from the newest first (by default).

```
/**
  * @param args     - limit: Limit the number of returned videos. Can be set up to 100.
  *                 - skip: Skip the first [n] entries.
  *                 - reverse: Reverse the order in which videos are returned.
  *                 - states: Filter videos by state
  *                 - tags: Filter the search result to certain tags
  */
ziggeo.videos.index(Map<String, String> args);
```

**Get video info**

A way for you to get info about the specific video, utilizing its video token or key.

- Note: Keys have to start with underscore, regardless of if they have it in their name already or not.

```
/**
  * @param videoTokenOrKey - video token or key.
  */
ziggeo.videos.get(String videoTokenOrKey);
```

**Get Video URL**

Want to get a direct URL of the video from Ziggeo servers? Use this method to retrieve the same.

- Note: Keys have to start with underscore, regardless of if they have it in their name already or not.

```
/**
  * @param videoTokenOrKey - video token or key.
  */
ziggeo.videos.getVideoUrl(String videoTokenOrKey);
```

**Get Poster Image URL**

If you are looking to retrieve the URL to the image/snapshot/poster used for the video, you can do that by utilizing bellow method.

- Note: Keys have to start with underscore, regardless of if they have it in their name already or not.

```
/**
  * @param videoTokenOrKey - video token or key.
  */
ziggeo.videos.getImageUrl(String videoTokenOrKey);
```

**Download video**

* Not yet available

**Download image/snapshot**

* Not yet available

**Create a video**

If you have video uploading code that you can not remove right away, however want to utilize Ziggeo, you could make a call to the video create API instead. That way your existing codes are used to create a new video in your Ziggeo app.

- Note: When setting a key, you do not need to include underscore as prefix. Even if you do, you will still need to include one in other calls.

```
/**
  * @param args     - file: Video file to be uploaded
  *                 - min_duration: Minimal duration of video
  *                 - max_duration: Maximal duration of video
  *                 - tags: Video Tags
  *                 - key: Unique (optional) name of video
  *                 - volatile: Automatically removed this video if it remains empty
  */
ziggeo.videos.create(Map<String, String> args);
```

**Update a video**

```
/**
  * @param videoTokenOrKey - video token or key.
  * @param argsMap         - min_duration: Minimal duration of video
  *                        - max_duration: Maximal duration of video
  *                        - tags: Video Tags
  *                        - key: Unique (optional) name of video
  *                        - volatile: Automatically removed this video if it remains empty
  *                        - expiration_days: After how many days will this video be deleted
  * @param callback        - callback to receive action result
  */
ziggeo.videos.update(String videoTokenOrKey, Map<String, String> args);
```

**Delete the video**

Use your video token or key to permanently remove the video from your app.

- Note: Keys have to start with underscore, regardless of if they have it in their name already or not.

```
/**
  * @param videoTokenOrKey - video token or key.
  */
ziggeo.videos.destroy(String videoTokenOrKey);
```

#### Video Streams API<a name="api-video-streams"></a>

Streams are sub sections of each higher category. In this specific case, these are streams (or sub sections) of videos. Since each video can have different number of streams we might want to do something with them.

Example of different streams could be:
1. Your original stream (original and unmodified data that we got)
2. Default stream (stream after processing original stream)
3. Alternate resolutions
4. Streams with effects (for example with logo applied)
5. Variations of above

**Create new video stream**

It is possible to create the empty placeholder for the new data. It takes the video token or key under which the new stream should be created.

- Note: Keys have to start with underscore, regardless of if they have it in their name already or not.

```
/**
  * @param videoTokenOrKey - video for which stream will be created
  */
ziggeo.streams.create(String videoTokenOrKey, File file, Map<String, String> args);
```

**Attach image**

* Not yet available

**Attach video**

* Not yet available

**Download video stream**

* Not yet available

**Download image**

* Not yet available

**Get video stream info**

* Not yet available

**Delete the stream**

Using video token or key and the stream token you can remove any specific stream that you like.

- Note: Keys have to start with underscore, regardless of if they have it in their name already or not.
- Note: You will need to have [Authentication token](#authentication) (by default) for this request. Never hardcode the auth token into your app, it should always be retrieved as unique value from your server. For more details, please reach out to our [support team](mailto:support@ziggeo.com).

```
/**
  * @param videoTokenOrKey  - video token
  * @param streamTokenOrKey - stream to remove
  */
ziggeo.streams.destroy(String videoTokenOrKey, String streamTokenOrKey);
```

### Authentication<a name="authentication"></a>

Our API is utilizing patent pending authorization token system. It allows you to secure and fine tune what someone can do and for how long.

The following will be needed if you have enabled the authorization tokens in your app.

- Note: This shows you how to add and utilize auth tokens. On client side, the auth tokens should never be created, nor stored permanently. Ideally, you will create the auth tokens within your server and then if you decide, pass that token to the specific client to allow them to do something within certain timeframe. Hardcoding permanent auth tokens would make it possible for anyone to find them and use, regardless of your desired workflow just by inspecting your app code.

Both client and server side auth tokens have equal say in what one can do. The difference is in how they are created.

#### Client Auth<a name="authentication-client"></a>

This section helps you set up a client auth token to be used in the requests you send to our servers. The client auth is created on your server without reaching to our servers first. This is ideal for high speed communication.

```
ziggeo.setClientAuthToken(String authData)
```

#### Server Auth<a name="authentication-server"></a>

The following will help you utilize the server side auth tokens. The server side auth tokens are created on your server as well, however they are created by passing the grants object to our server. Our server then sends you a short token that you can use in any of the calls you make, per the grants you specified.

```
ziggeo.setServerAuthToken(String token);
```

## Compiling and Publishing App<a name="compile"></a>

All the standard compiling and publishing steps apply.

For more details regarding Android please see [Flutter docs for Android](https://docs.flutter.dev/deployment/android).
For more details regarding iOS please see [Flutter docs for iOS](https://docs.flutter.dev/deployment/ios).

## Update Information<a name="update"></a>


## Changelog<a name="Changelog"></a>

If you are interested in our changelog you can find it as a separate file next to this readme. It is named as [CHANGELOG.md](CHANGELOG.md)