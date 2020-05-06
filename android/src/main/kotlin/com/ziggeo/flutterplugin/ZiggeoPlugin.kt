package com.ziggeo.flutterplugin

import android.content.Context
import android.net.Uri
import android.os.Handler
import android.os.Looper
import com.ziggeo.androidsdk.IZiggeo
import com.ziggeo.androidsdk.Ziggeo
import com.ziggeo.androidsdk.callbacks.IRecorderCallback
import com.ziggeo.androidsdk.recorder.MicSoundLevel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.PluginRegistry.Registrar
import timber.log.Timber
import java.io.File
import java.util.*

class ZiggeoPlugin(private val context: Context,
                   private val ziggeo: IZiggeo,
                   private val fromDartChannel: MethodChannel,
                   private val recorderCallbackChannel: MethodChannel,
                   private val mainThread: Handler
) : MethodCallHandler {

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val fromDartChannel = MethodChannel(registrar.messenger(), "ziggeo")
            val recorderCallbackChannel = MethodChannel(registrar.messenger(), "recorder")
            val context = registrar.activeContext()!!
            fromDartChannel.setMethodCallHandler(
                    ZiggeoPlugin(context,
                            Ziggeo(context),
                            fromDartChannel,
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
                prepareCallback()
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
                        call.argument<HashMap<String, String>>("args")?
                )
            }
            "startScreenRecorder" -> ziggeo.startScreenRecorder(null)
            else -> result.notImplemented()
        }
    }

    private fun prepareCallback() {
        ziggeo.recorderConfig.callback = object : IRecorderCallback {
            override fun streamingStarted() {
                fireCallback("streamingStarted")
            }

            override fun loaded() {
                fireCallback("loaded")
            }

            override fun accessGranted() {
                fireCallback("accessGranted")
            }

            override fun noMicrophone() {
                fireCallback("noMicrophone")
            }

            override fun accessForbidden(forbiddenPermissions: MutableList<String>) {
                fireCallback("accessForbidden", forbiddenPermissions)
            }

            override fun hasMicrophone() {
                fireCallback("hasMicrophone")
            }

            override fun recordingStopped(path: String) {
                fireCallback("recordingStopped", path)
            }

            override fun processing(token: String) {
                fireCallback("processing", token)
            }

            override fun readyToRecord() {
                fireCallback("readyToRecord")
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

            override fun uploadSelected(vararg paths: String?) {
                fireCallback("uploadSelected", paths)
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

            override fun hasCamera() {
                fireCallback("hasCamera")
            }

            override fun microphoneHealth(level: MicSoundLevel) {
                fireCallback("microphoneHealth", level.name)
            }

            override fun error(exception: Throwable) {
                fireCallback("error", exception)
            }

            override fun canceledByUser() {
                fireCallback("canceledByUser")
            }

            override fun streamingStopped() {
                fireCallback("streamingStopped")
            }

            override fun uploadingStarted(path: String) {
                fireCallback("uploadingStarted", path)
            }

            override fun manuallySubmitted() {
                fireCallback("manuallySubmitted")
            }

            override fun uploaded(path: String, token: String) {
                val args: MutableMap<String, Any> = HashMap()
                args["token"] = token
                args["path"] = path
                fireCallback("uploaded", args)
            }

            override fun noCamera() {
                fireCallback("noCamera")
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
