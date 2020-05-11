# Ziggeo's Flutter SDK

## Index

1. [Why Ziggeo's Flutter SDK?](#why-us)
3. [Codes](#codes)
    1. [Init](#init)
    2. [Recorder](#recorder)
    3. [Player](#player)
    4. [Events / Callbacks](#events)
    5. [API](#API)
    6. [Examples](#examples)
4. [Update Information](#update)
5. [Changelog](#changelog)

## Why Ziggeo's Flutter SDK? <a name="why-us"></a>

Ziggeo is powerfull whitelabel video SAAS that helps people be part and lead the video revolution. It has award winning multimedia API and its CEO and CTO can often be seen talking in various events around the world.

Ziggeo's Flutter SDK is utilizing the API to bring you a native library you can add to your project. Just add to project and allow your application evolve into something much more, something video!

It offers you pre-built functionality to call and manipulate. This library also offers you direct access to the Ziggeo API as well if you want to do more things yourself.

### Who it is for?

Do you have a complex Flutter app that is missing that one key ingredient - the video?

Do you need a video library that can be seamlesly integrated into your existing app?

Want something that is simple and easy to use?

You need some powerful features high end video apps provide?

Want to provide a great video experience for your own customers?

If any of the above is "Yes" then you are in the right place as this SDK is for you!

## Codes<a name="codes"></a>

This section will introduce you to the most common ways you would integrate our video library into your app.

### Init<a name="init"></a>

```
final String appToken = "YOUR_APP_TOKEN_HERE";
Ziggeo ziggeo = new Ziggeo(appToken);
```

### Recorder<a name="recorder"></a>

The fullscreen recorder is useful when you want your recorder to take entire screen.

The embedded recorder is useful when you want your recorder to be part of your app. For example if you had an avatar in your app and you want it to be a quick video.

**Create fullscreen Video Recorder**

```
ziggeo.startCameraRecorder();
```

- See examples section to see how to configure the recorder with more specific options, instead of using defaults

### Player<a name="Player"></a>

Player can be used to play local videos, videos from other services and of course videos from Ziggeo servers.

**Create fullscreen Video Player**

URI playback
```
ziggeo.startPlayerFromPath(List<String> videoPaths);
```

Playback from Ziggeo servers
```
ziggeo.startPlayerFromToken(List<String> videoTokens);
```

### Events / Callbacks<a name="events"></a>

Callbacks allow you to know when something happens. They fire in case of some event happening, such as if error occurs. This way you can design your app to fine detail and be able to provide you customers with great experience.

We have separated the events that are available to you into several different categories.

### Common

Common callbacks happen for both player and recorder, each callback has additional details next to it.

Ups, something unexpected happened! Now it's your time to react.
```
onError: (exception) => {}
```
Some permissions are not given, so we can not do much at this point
```
onAccessForbidden: (permissions) => {}
```

### Recorder

The callbacks in this section are specific to recorder only. This means that they will not fire for the player at all.

Recording has just started
```
onRecordingStarted: () => {}
```

Want to detect if someone cancels the recording?
```
onCanceledByUser: () => {} 
```

Recording has just finished
```
onRecordingStopped: (path) => {}
```

Want to know when upload starts?
```
onUploadingStarted: (path) => {}
```

Want to know the progress of the uploads?
```
onUploadProgress: (token, path, current, total) => {}
```

Want to know once upload finishes?
```
onUploaded: (token, path) => {}
```

Want to know if the video can be processed?

 - This utilizes our quick check algorithm to inspect the video before it is sent to processing and see that it can actually be processed. This allows you to react if something is wrong with the video
```
onVerified: (token) =>  {}
```
Interested in the progress of the processing / transcoding of the video?
```
onProcessing: (token) => {}
```

Interested knowing when the video is successfully processed?
```
onProcessed: (token) => {}
```

### API<a name="API"></a>

### Authentication

Our API is utilizing patent pending authorization token system. It allows you to secure and fine tune what someone can do and for how long.

The following will be needed if you have enabled the authorization tokens in your app.

Client Auth
```
ziggeo.setClientAuthToken(String token)
```

Server Auth
```
ziggeo.setServerAuthToken(String token);
```
### Examples

### Configure the recorder

Our recorder is utilizing helper class to define different properties of the recorder element. So we would always define it first
```
var recorderConfig = new RecorderConfig()
```

*Set max duration*
```
recorderConfig.maxDuration = 0; // seconds, 0 - endless by default
```

*Set countdown time*
```
recorderConfig.startDelay = 3; // seconds, default
```

*Auto start recorder*
```
recorderConfig.shouldAutoStartRecording = false; // default
```

*Set which camera you prefer*
```
recorderConfig.facing = RecorderConfig.facingBack; // default
```

*Set the quality of recording*
```
recorderConfig.videoQuality = RecorderConfig.qualityHigh; // default
```

*Can camera be switched during recording?*
```
recorderConfig.shouldDisableCameraSwitch = false; // default
```

*Should video be sent to Ziggeo servers right away?*
```
recorderConfig.shouldSendImmediately = true; // default
```

*Show stop dialog*
```
recorderConfig.shouldConfirmStopRecording = true; // default
```
   
*Register events listener*
```
recorderConfig.eventsListener = new RecorderEventsListener(...)
```

*Extra arguments to be sent*
```
recorderConfig.extraArgs = map;
```
This can be used to specify effect profiles, video profiles, custom data, etc.


### Extra arguments examples

*Custom data*
```
var args = new Map<String, dynamic>();
args["data"] = "{\"key\":\"value\"}";
recorderConfig.extraArgs = args;
```

*Effect Profile*
```
var args = new Map<String, dynamic>();
args["effect_profile"] = "1234567890";
recorderConfig.extraArgs = args;
```

*Video Profile*
```
var args = new Map<String, dynamic>();
args["video_profile"] = "1234567890";
recorderConfig.extraArgs = args;
```

## Changelog<a name="Changelog"></a>

If you are interested in our changelog you can find it as a separate file next to this readme. It is named as [CHANGELOG.md](CHANGELOG.md)
