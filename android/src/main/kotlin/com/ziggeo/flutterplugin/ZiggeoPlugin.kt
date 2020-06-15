package com.ziggeo.flutterplugin

import android.net.Uri
import android.os.Handler
import android.os.Looper
import com.ziggeo.androidsdk.IZiggeo
import com.ziggeo.androidsdk.Ziggeo
import com.ziggeo.androidsdk.callbacks.FileSelectorCallback
import com.ziggeo.androidsdk.callbacks.RecorderCallback
import com.ziggeo.androidsdk.callbacks.UploadingCallback
import com.ziggeo.androidsdk.qr.QrScannerCallback
import com.ziggeo.androidsdk.recorder.MicSoundLevel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.PluginRegistry.Registrar
import timber.log.Timber
import java.io.File

class ZiggeoPlugin(private val ziggeo: IZiggeo,
                   private val recorderCallbackChannel: MethodChannel,
                   private val mainThread: Handler
) : MethodCallHandler {

    init {
        prepareCallbacks()
    }

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val fromFlutterToNativeChannel = MethodChannel(registrar.messenger(), "ziggeo")
            val recorderCallbackChannel = MethodChannel(registrar.messenger(), "recorder")
            val context = registrar.activeContext()!!
            fromFlutterToNativeChannel.setMethodCallHandler(
                    ZiggeoPlugin(Ziggeo(context),
                            recorderCallbackChannel,
                            Handler(Looper.getMainLooper())
                    )
            )
            Timber.plant(Timber.DebugTree())
        }
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "setAppToken" -> call.argument<String>("appToken")?.let {
                ziggeo.appToken = it
            }
            "getAppToken" -> result.success(ziggeo.appToken)
            "setClientAuthToken" -> call.argument<String>("clientAuthToken")?.let {
                ziggeo.setClientAuthToken(it)
            }
            "getClientAuthToken" -> result.success(ziggeo.clientAuthToken)
            "setServerAuthToken" -> call.argument<String>("serverAuthToken")?.let {
                ziggeo.setClientAuthToken(it)
            }
            "getServerAuthToken" -> result.success(ziggeo.serverAuthToken)
            "startCameraRecorder" -> {
                ziggeo.startCameraRecorder()
            }
            "startAudioRecorder" -> ziggeo.startAudioRecorder()
            "startPlayer" -> if (call.hasArgument("tokens")) {
                call.argument<List<String>>("tokens")?.let {
                    ziggeo.startPlayer(*it.toTypedArray())
                }
            } else {
                call.argument<List<String>>("paths")?.let {
                    val size = it.size
                    val uris = arrayOfNulls<Uri>(size)
                    var pos = 0
                    while (pos < size) {
                        uris[pos] = Uri.parse(it[0])
                        pos++
                    }
                    ziggeo.startPlayer(*uris)
                }
            }
            "uploadFromFileSelector" -> {
                ziggeo.uploadFromFileSelector(
                        call.argument<HashMap<String, String>>("args")
                )
            }
            "startScreenRecorder" -> ziggeo.startScreenRecorder(null)
            "setRecorderConfig" -> {
                (call.arguments as? HashMap<*, *>)?.let {
                    val config = ziggeo.recorderConfig
                    (it["shouldShowFaceOutline"] as? Boolean)?.let { value ->
                        config.shouldShowFaceOutline = value
                    }
                    (it["isLiveStreaming"] as? Boolean)?.let { value ->
                        config.isLiveStreaming = value
                    }
                    (it["shouldAutoStartRecording"] as? Boolean)?.let { value ->
                        config.shouldAutoStartRecording = value
                    }
                    (it["startDelay"] as? Int)?.let { value ->
                        config.startDelay = value
                    }
                    (it["shouldSendImmediately"] as? Boolean)?.let { value ->
                        config.shouldSendImmediately = value
                    }
                    (it["shouldDisableCameraSwitch"] as? Boolean)?.let { value ->
                        config.shouldDisableCameraSwitch = value
                    }
                    (it["videoQuality"] as? Int)?.let { value ->
                        config.videoQuality = value
                    }
                    (it["facing"] as? Int)?.let { value ->
                        config.facing = value
                    }
                    (it["maxDuration"] as? Int)?.let { value ->
                        config.maxDuration = value * 1000L
                    }
                    (it["shouldEnableCoverShot"] as? Boolean)?.let { value ->
                        config.shouldEnableCoverShot = value
                    }
                    (it["shouldConfirmStopRecording"] as? Boolean)?.let { value ->
                        config.shouldConfirmStopRecording = value
                    }
                    (it["extraArgs"] as? HashMap<String, String>)?.let { value ->
                        config.extraArgs = value
                    }
                }
            }
            "startQrScanner" -> ziggeo.startQrScanner()
            "setQrScannerConfig" -> {
                (call.arguments as? HashMap<*, *>)?.let {
                    val config = ziggeo.qrScannerConfig
                    (it["shouldCloseAfterSuccessfulScan"] as? Boolean)?.let { value ->
                        config.shouldCloseAfterSuccessfulScan = value
                    }
                }
            }
            "setUploadingConfig" -> {
                (call.arguments as? HashMap<*, *>)?.let {
                    val config = ziggeo.uploadingConfig
                    (it["shouldUseWifiOnly"] as? Boolean)?.let { value ->
                        config.shouldUseWifiOnly = value
                    }
                    (it["syncInterval"] as? Int)?.let { value ->
                        config.syncInterval = value.toLong()
                    }
                    (it["shouldTurnOffUploader"] as? Boolean)?.let { value ->
                        config.shouldTurnOffUploader = value
                    }
                }
            }
            "setFileSelectorConfig" -> {
                (call.arguments as? HashMap<*, *>)?.let {
                    val config = ziggeo.fileSelectorConfig
                    (it["maxDuration"] as? Int)?.let { value ->
                        config.maxDuration = value.toLong()
                    }
                }
            }
            else -> result.notImplemented()
        }
    }

    private fun prepareCallbacks() {
        ziggeo.qrScannerConfig.callback = object : QrScannerCallback() {
            override fun loaded() {
                fireCallback("loaded")
            }

            override fun accessGranted() {
                fireCallback("accessGranted")
            }

            override fun accessForbidden(forbiddenPermissions: MutableList<String>) {
                fireCallback("accessForbidden", forbiddenPermissions)
            }

            override fun error(exception: Throwable) {
                fireCallback("error", exception.toString())
            }

            override fun onQrDecoded(value: String) {
                super.onQrDecoded(value)
                fireCallback("onQrDecoded", value)
            }

            override fun canceledByUser() {
                super.canceledByUser()
                fireCallback("canceledByUser")
            }

            override fun noCamera() {
                super.noCamera()
                fireCallback("noCamera")
            }

            override fun noMicrophone() {
                super.noMicrophone()
                fireCallback("noMicrophone")
            }

            override fun hasCamera() {
                super.hasCamera()
                fireCallback("hasCamera")
            }

            override fun hasMicrophone() {
                super.hasMicrophone()
                fireCallback("hasMicrophone")
            }
        }
        ziggeo.fileSelectorConfig.callback = object : FileSelectorCallback() {
            override fun loaded() {
                fireCallback("loaded")
            }

            override fun accessGranted() {
                fireCallback("accessGranted")
            }

            override fun accessForbidden(forbiddenPermissions: MutableList<String>) {
                fireCallback("accessForbidden", forbiddenPermissions)
            }

            override fun error(exception: Throwable) {
                fireCallback("error", exception.toString())
            }

            override fun canceledByUser() {
                fireCallback("canceledByUser")
            }

            override fun uploadSelected(paths: MutableList<String>) {
                fireCallback("uploadSelected", paths)
            }
        }
        ziggeo.uploadingConfig.callback = object : UploadingCallback() {
            override fun processing(token: String) {
                fireCallback("processing", token)
            }

            override fun uploadProgress(token: String, file: File, current: Long, total: Long) {
                val args: MutableMap<String, Any> = HashMap()
                args["token"] = token
                args["path"] = file.absolutePath
                args["current"] = current
                args["total"] = total
                fireCallback("uploadProgress", args)
            }

            override fun processed(token: String) {
                fireCallback("processed", token)
            }

            override fun verified(token: String) {
                fireCallback("verified", token)
            }

            override fun uploadingStarted(path: String) {
                fireCallback("uploadingStarted", path)
            }

            override fun uploaded(path: String, token: String) {
                val args: MutableMap<String, Any> = HashMap()
                args["token"] = token
                args["path"] = path
                fireCallback("uploaded", args)
            }

            override fun error(exception: Throwable) {
                fireCallback("error", exception.toString())
            }
        }

        ziggeo.recorderConfig.callback = object : RecorderCallback() {
            override fun noMicrophone() {
                fireCallback("noMicrophone")
            }

            override fun hasMicrophone() {
                fireCallback("hasMicrophone")
            }

            override fun hasCamera() {
                fireCallback("hasCamera")
            }

            override fun microphoneHealth(level: MicSoundLevel) {
                fireCallback("microphoneHealth", level.name)
            }

            override fun loaded() {
                fireCallback("loaded")
            }

            override fun accessGranted() {
                fireCallback("accessGranted")
            }

            override fun accessForbidden(forbiddenPermissions: MutableList<String>) {
                fireCallback("accessForbidden", forbiddenPermissions)
            }

            override fun error(exception: Throwable) {
                fireCallback("error", exception.toString())
            }

            override fun canceledByUser() {
                fireCallback("canceledByUser")
            }

            override fun noCamera() {
                fireCallback("noCamera")
            }

            override fun streamingStarted() {
                fireCallback("streamingStarted")
            }

            override fun recordingStopped(path: String) {
                fireCallback("recordingStopped", path)
            }

            override fun readyToRecord() {
                fireCallback("readyToRecord")
            }

            override fun recordingStarted() {
                fireCallback("recordingStarted")
            }

            override fun recordingProgress(secondsPast: Long) {
                fireCallback("recordingProgress", secondsPast)
            }

            override fun onPictureTaken(path: String) {
                fireCallback("onPictureTaken", path)
            }

            override fun streamingStopped() {
                fireCallback("streamingStopped")
            }

            override fun manuallySubmitted() {
                fireCallback("manuallySubmitted")
            }

            override fun countdown(secondsLeft: Int) {
                fireCallback("countdown", secondsLeft)
            }
        }
    }

    private fun fireCallback(methodName: String, args: Any? = null) {
        mainThread.post {
            recorderCallbackChannel.invokeMethod(methodName, args)
        }
    }

}
