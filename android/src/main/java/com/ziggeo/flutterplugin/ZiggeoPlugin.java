package com.ziggeo.flutterplugin;

import android.content.Context;
import android.net.Uri;
import android.text.TextUtils;

import com.ziggeo.androidsdk.Ziggeo;

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
                ziggeo.setClientAuthToken(serverAuthToken);
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
            case "uploadFromFileSelector":
                final HashMap<String, String> extraArgs = call.argument("args");
                ziggeo.uploadFromFileSelector(extraArgs);
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
            default:
                result.notImplemented();
        }
    }
}
