package com.ziggeo.flutterplugin;

import android.content.Context;
import android.net.Uri;
import android.text.TextUtils;

import com.ziggeo.androidsdk.Ziggeo;
import com.ziggeo.androidsdk.player.PlayerConfig;
import com.ziggeo.androidsdk.recorder.RecorderConfig;
import com.ziggeo.androidsdk.ui.theming.CameraRecorderStyle;
import com.ziggeo.androidsdk.ui.theming.PlayerStyle;

import java.util.HashMap;
import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import timber.log.Timber;

import static com.ziggeo.flutterplugin.Errors.EMPTY_TOKEN;

public class ZiggeoPlugin implements MethodCallHandler {

    private Ziggeo ziggeo;

    public ZiggeoPlugin(Context context) {
        ziggeo = new Ziggeo(context);
    }

    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "ziggeo");
        channel.setMethodCallHandler(new ZiggeoPlugin(registrar.activeContext()));
        Timber.plant(new Timber.DebugTree());
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        Timber.e("Method:%s Result:%s", call.toString(), result.toString());
        switch (call.method) {
            case "setAppToken":
                final String appToken = call.argument("appToken");
                if (!TextUtils.isEmpty(appToken)) {
                    ziggeo.setAppToken(appToken);
                } else {
                    result.error(EMPTY_TOKEN.code, EMPTY_TOKEN.msg, EMPTY_TOKEN.details);
                }
                break;
            case "getAppToken":
                result.success(ziggeo.getAppToken());
                break;
            case "setClientAuthToken":
                final String clientAuthToken = call.argument("clientAuthToken");
                ziggeo.setClientAuthToken(clientAuthToken);
                break;
            case "getClientAuthToken":
                result.success(ziggeo.getClientAuthToken());
                break;
            case "setServerAuthToken":
                final String serverAuthToken = call.argument("serverAuthToken");
                ziggeo.setServerAuthToken(serverAuthToken);
                break;
            case "getServerAuthToken":
                result.success(ziggeo.getServerAuthToken());
                break;
            case "startCameraRecorder":
                ziggeo.startCameraRecorder();
                break;
            case "startAudioRecorder":
                ziggeo.startAudioRecorder();
                break;
            case "startPlayer":
                if (call.hasArgument("tokens")) {
                    List<String> tokens = call.argument("tokens");
                    ziggeo.startPlayer(tokens.toArray(new String[]{}));
                } else {
                    List<String> paths = call.argument("paths");
                    final int size = paths.size();
                    Uri[] uris = new Uri[paths.size()];
                    for (int pos = 0; pos < size; pos++) {
                        uris[pos] = Uri.parse(paths.get(0));
                    }
                    ziggeo.startPlayer(uris);
                }
                break;
            case "uploadFromFileSelector": {
                final HashMap<String, String> extraArgs = call.argument("args");
                ziggeo.uploadFromFileSelector(extraArgs);
            }
            break;
            case "startScreenRecorder":
                ziggeo.startScreenRecorder(null);
                break;
            case "clearRecorded":
                result.success(ziggeo.clearRecorded());
                break;
            case "cancelRequest":
                ziggeo.cancelRequest();
                break;
            case "setRecorderConfig": {
                //TODO callback
                RecorderConfig.Builder recorderConfig = new RecorderConfig.Builder();

                final HashMap<String, Object> config = call.argument("config");
                if (config != null) {
                    Boolean showFaceOutline = (Boolean) config.get("showFaceOutline");
                    if (showFaceOutline != null) {
                        recorderConfig.showFaceOutline(showFaceOutline);
                    }

                    Boolean autostart = (Boolean) config.get("autostart");
                    if (autostart != null) {
                        recorderConfig.autostartRecording(autostart);
                    }

                    Integer startDelay = (Integer) config.get("startDelay");
                    if (startDelay != null) {
                        recorderConfig.startDelay(startDelay);
                    }

                    Boolean sendImmediately = (Boolean) config.get("sendImmediately");
                    if (sendImmediately != null) {
                        recorderConfig.sendImmediately(sendImmediately);
                    }

                    Boolean disableCameraSwitch = (Boolean) config.get("disableCameraSwitch");
                    if (disableCameraSwitch != null) {
                        recorderConfig.disableCameraSwitch(disableCameraSwitch);
                    }

                    Integer videoQuality = (Integer) config.get("videoQuality");
                    if (videoQuality != null) {
                        recorderConfig.quality(videoQuality);
                    }

                    Integer facing = (Integer) config.get("facing");
                    if (facing != null) {
                        recorderConfig.facing(facing);
                    }

                    Integer maxDuration = (Integer) config.get("maxDuration");
                    if (maxDuration != null) {
                        recorderConfig.maxDuration(maxDuration);
                    }

                    Boolean enableCoverShot = (Boolean) config.get("enableCoverShot");
                    if (enableCoverShot != null) {
                        recorderConfig.enableCoverShot(enableCoverShot);
                    }

                    Boolean confirmStopRecording = (Boolean) config.get("confirmStopRecording");
                    if (confirmStopRecording != null) {
                        recorderConfig.confirmStopRecording(confirmStopRecording);
                    }

                    HashMap<String, String> extraArgs = (HashMap<String, String>) config.get("extraArgs");
                    if (extraArgs != null) {
                        recorderConfig.extraArgs(extraArgs);
                    }

                    final HashMap<String, Object> style = (HashMap<String, Object>) config.get("style");
                    if (style != null) {
                        CameraRecorderStyle.Builder recorderStyle = new CameraRecorderStyle.Builder();

                        Boolean hideControls = (Boolean) style.get("hideControls");
                        if (hideControls != null) {
                            recorderStyle.hideControls(hideControls);
                        }

                        recorderConfig.style(recorderStyle.build());
                    }
                }
                ziggeo.setRecorderConfig(recorderConfig.build());
            }
            break;
            case "setPlayerConfig": {
                //TODO callback
                PlayerConfig.Builder playerConfig = new PlayerConfig.Builder();

                final HashMap<String, Object> config = call.argument("config");
                if (config != null) {
                    Boolean muted = (Boolean) config.get("muted");
                    if (muted != null) {
                        playerConfig.isMuted(muted);
                    }

                    Boolean showSubtitles = (Boolean) config.get("showSubtitles");
                    if (showSubtitles != null) {
                        playerConfig.showSubtitles(showSubtitles);
                    }

                    HashMap<String, String> extraArgs = (HashMap<String, String>) config.get("extraArgs");
                    if (extraArgs != null) {
                        playerConfig.extraArgs(extraArgs);
                    }

                    final HashMap<String, Object> style = (HashMap<String, Object>) config.get("style");
                    if (style != null) {
                        PlayerStyle.Builder playerStyle = new PlayerStyle.Builder();

                        Boolean hideControls = (Boolean) style.get("hideControls");
                        if (hideControls != null) {
                            playerStyle.hideControls(hideControls);
                        }

                        playerConfig.style(playerStyle.build());
                    }
                }
                ziggeo.setPlayerConfig(playerConfig.build());
            }
            break;
            default:
                result.notImplemented();
        }
    }
}
