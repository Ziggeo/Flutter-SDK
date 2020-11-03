package com.ziggeo.flutterplugin

import android.net.Uri
import android.os.Handler
import com.ziggeo.androidsdk.IZiggeo
import com.ziggeo.androidsdk.callbacks.*
import com.ziggeo.androidsdk.qr.QrScannerCallback
import com.ziggeo.androidsdk.recorder.MicSoundLevel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import java.io.File
import java.util.*

class ZiggeoMainMethodChannel(private val ziggeo: IZiggeo,
                              private val recCallbackChannel: MethodChannel,
                              private val fsCallbackChannel: MethodChannel,
                              private val uplCallbackChannel: MethodChannel,
                              private val plCallbackChannel: MethodChannel,
                              private val qrCallbackChannel: MethodChannel,
                              private val mainThread: Handler
) : MethodCallHandler {

    init {
        prepareCallbacks()
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "setAppToken" -> call.argument<String>("appToken")?.let {
                ziggeo.appToken = it
            }
            "getAppToken" -> result.success(ziggeo.appToken)
            "setClientAuthToken" -> call.argument<String>("clientAuthToken")?.let {
                ziggeo.clientAuthToken = it
            }
            "getClientAuthToken" -> result.success(ziggeo.clientAuthToken)
            "setServerAuthToken" -> call.argument<String>("serverAuthToken")?.let {
                ziggeo.serverAuthToken = it
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
                    (it["shouldAllowMultipleSelection"] as? Boolean)?.let { value ->
                        config.shouldAllowMultipleSelection = value
                    }
                }
            }
            "setPlayerConfig" -> {
                (call.arguments as? HashMap<*, *>)?.let {
                    val config = ziggeo.playerConfig
                    (it["shouldShowSubtitles"] as? Boolean)?.let { value ->
                        config.shouldShowSubtitles = value
                    }
                    (it["isMuted"] as? Boolean)?.let { value ->
                        config.isMuted = value
                    }
                }
            }
            "sendReport" -> {
                var list: List<String>? = null
                call.argument<List<String>>("logs")?.let {
                    list = it
                }
                ziggeo.sendReport(list)
            }
            else -> result.notImplemented()
        }
    }

    private fun prepareCallbacks() {
        prepareQrCallback()
        prepareFsCallback()
        prepareUplCallback()
        preparePlCallback()
        prepareRecCallback()
    }

    private fun prepareQrCallback() {
        ziggeo.qrScannerConfig.callback = object : QrScannerCallback() {
            override fun loaded() {
                fireQrCallback("loaded")
            }

            override fun accessGranted() {
                fireQrCallback("accessGranted")
            }

            override fun accessForbidden(forbiddenPermissions: MutableList<String>) {
                fireQrCallback("accessForbidden", forbiddenPermissions)
            }

            override fun error(exception: Throwable) {
                fireQrCallback("error", exception.toString())
            }

            override fun onQrDecoded(value: String) {
                super.onQrDecoded(value)
                fireQrCallback("onQrDecoded", value)
            }

            override fun canceledByUser() {
                super.canceledByUser()
                fireQrCallback("canceledByUser")
            }

            override fun noCamera() {
                super.noCamera()
                fireQrCallback("noCamera")
            }

            override fun noMicrophone() {
                super.noMicrophone()
                fireQrCallback("noMicrophone")
            }

            override fun hasCamera() {
                super.hasCamera()
                fireQrCallback("hasCamera")
            }

            override fun hasMicrophone() {
                super.hasMicrophone()
                fireQrCallback("hasMicrophone")
            }
        }
    }

    private fun prepareFsCallback() {
        ziggeo.fileSelectorConfig.callback = object : FileSelectorCallback() {
            override fun loaded() {
                fireFsCallback("loaded")
            }

            override fun accessGranted() {
                fireFsCallback("accessGranted")
            }

            override fun accessForbidden(forbiddenPermissions: MutableList<String>) {
                fireFsCallback("accessForbidden", forbiddenPermissions)
            }

            override fun error(exception: Throwable) {
                fireFsCallback("error", exception.toString())
            }

            override fun canceledByUser() {
                fireFsCallback("canceledByUser")
            }

            override fun uploadSelected(paths: MutableList<String>) {
                fireFsCallback("uploadSelected", paths)
            }
        }
    }

    private fun prepareUplCallback() {
        ziggeo.uploadingConfig.callback = object : UploadingCallback() {
            override fun processing(token: String) {
                fireUplCallback("processing", token)
            }

            override fun uploadProgress(videoToken: String, path: String, uploadedBytes: Long, totalBytes: Long) {
                super.uploadProgress(videoToken, path, uploadedBytes, totalBytes)
                val args: MutableMap<String, Any> = HashMap()
                args["token"] = videoToken
                args["path"] = path
                args["current"] = uploadedBytes
                args["total"] = totalBytes
                fireUplCallback("uploadProgress", args)
            }

            override fun processed(token: String) {
                fireUplCallback("processed", token)
            }

            override fun verified(token: String) {
                fireUplCallback("verified", token)
            }

            override fun uploadingStarted(path: String) {
                fireUplCallback("uploadingStarted", path)
            }

            override fun uploaded(path: String, token: String) {
                val args: MutableMap<String, Any> = HashMap()
                args["token"] = token
                args["path"] = path
                fireUplCallback("uploaded", args)
            }

            override fun error(exception: Throwable) {
                fireUplCallback("error", exception.toString())
            }
        }
    }

    private fun preparePlCallback() {
        ziggeo.playerConfig.callback = object : PlayerCallback() {
            override fun loaded() {
                firePlCallback("loaded")
            }

            override fun accessGranted() {
                firePlCallback("accessGranted")
            }

            override fun accessForbidden(forbiddenPermissions: MutableList<String>) {
                firePlCallback("accessForbidden", forbiddenPermissions)
            }

            override fun error(exception: Throwable) {
                firePlCallback("error", exception.toString())
            }

            override fun canceledByUser() {
                firePlCallback("canceledByUser")
            }

            override fun playing() {
                firePlCallback("playing")
            }

            override fun paused() {
                firePlCallback("paused")
            }

            override fun ended() {
                firePlCallback("ended")
            }

            override fun seek(millis: Long) {
                firePlCallback("seek", millis)
            }

            override fun readyToPlay() {
                firePlCallback("readyToPlay")
            }
        }
    }

    private fun prepareRecCallback() {
        ziggeo.recorderConfig.callback = object : RecorderCallback() {
            override fun noMicrophone() {
                fireRecCallback("noMicrophone")
            }

            override fun hasMicrophone() {
                fireRecCallback("hasMicrophone")
            }

            override fun hasCamera() {
                fireRecCallback("hasCamera")
            }

            override fun microphoneHealth(level: MicSoundLevel) {
                fireRecCallback("microphoneHealth", level.name)
            }

            override fun loaded() {
                fireRecCallback("loaded")
            }

            override fun accessGranted() {
                fireRecCallback("accessGranted")
            }

            override fun accessForbidden(forbiddenPermissions: MutableList<String>) {
                fireRecCallback("accessForbidden", forbiddenPermissions)
            }

            override fun error(exception: Throwable) {
                fireRecCallback("error", exception.toString())
            }

            override fun canceledByUser() {
                fireRecCallback("canceledByUser")
            }

            override fun noCamera() {
                fireRecCallback("noCamera")
            }

            override fun streamingStarted() {
                fireRecCallback("streamingStarted")
            }

            override fun recordingStopped(path: String) {
                fireRecCallback("recordingStopped", path)
            }

            override fun readyToRecord() {
                fireRecCallback("readyToRecord")
            }

            override fun recordingStarted() {
                fireRecCallback("recordingStarted")
            }

            override fun recordingProgress(secondsPast: Long) {
                fireRecCallback("recordingProgress", secondsPast)
            }

            override fun streamingStopped() {
                fireRecCallback("streamingStopped")
            }

            override fun manuallySubmitted() {
                fireRecCallback("manuallySubmitted")
            }

            override fun countdown(secondsLeft: Int) {
                fireRecCallback("countdown", secondsLeft)
            }
        }
    }

    private fun fireRecCallback(methodName: String, args: Any? = null) {
        mainThread.post {
            recCallbackChannel.invokeMethod(methodName, args)
        }
    }

    private fun fireFsCallback(methodName: String, args: Any? = null) {
        mainThread.post {
            fsCallbackChannel.invokeMethod(methodName, args)
        }
    }

    private fun firePlCallback(methodName: String, args: Any? = null) {
        mainThread.post {
            plCallbackChannel.invokeMethod(methodName, args)
        }
    }

    private fun fireUplCallback(methodName: String, args: Any? = null) {
        mainThread.post {
            uplCallbackChannel.invokeMethod(methodName, args)
        }
    }

    private fun fireQrCallback(methodName: String, args: Any? = null) {
        mainThread.post {
            qrCallbackChannel.invokeMethod(methodName, args)
        }
    }

}
