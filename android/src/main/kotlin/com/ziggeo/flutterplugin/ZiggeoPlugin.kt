package com.ziggeo.flutterplugin

import android.content.Context
import android.net.Uri
import com.ziggeo.androidsdk.IZiggeo
import com.ziggeo.androidsdk.Ziggeo
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.PluginRegistry.Registrar
import timber.log.Timber
import java.util.*

class ZiggeoPlugin(context: Context?) : MethodCallHandler {

    private val ziggeo: IZiggeo = Ziggeo(context!!)

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
            "startCameraRecorder" -> ziggeo.startCameraRecorder()
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
            "uploadFromFileSelector" -> call.argument<HashMap<String, String>>("args")?.let {
                ziggeo.uploadFromFileSelector(it)
            }
            "startScreenRecorder" -> ziggeo.startScreenRecorder(null)
            else -> result.notImplemented()
        }
    }

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "ziggeo")
            channel.setMethodCallHandler(ZiggeoPlugin(registrar.activeContext()))
            Timber.plant(Timber.DebugTree())
        }
    }

}
