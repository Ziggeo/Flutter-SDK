package com.ziggeo.flutterplugin

import android.os.Handler
import android.os.Looper
import com.ziggeo.androidsdk.Ziggeo
import com.ziggeo.flutterplugin.api.VideosMethodChannel
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry.Registrar
import timber.log.Timber

class ZiggeoPlugin {

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val ziggeoMainChannel = MethodChannel(registrar.messenger(), "ziggeo")
            val videosApiChannel = MethodChannel(registrar.messenger(), "ziggeo_videos")
            val recCallbackChannel = MethodChannel(registrar.messenger(), "ziggeo_rec_callback")
            val fsCallbackChannel = MethodChannel(registrar.messenger(), "ziggeo_fs_callback")
            val uplCallbackChannel = MethodChannel(registrar.messenger(), "ziggeo_upl_callback")
            val plCallbackChannel = MethodChannel(registrar.messenger(), "ziggeo_pl_callback")
            val qrCallbackChannel = MethodChannel(registrar.messenger(), "ziggeo_qr_callback")
            val context = registrar.activeContext()!!
            val ziggeo = Ziggeo(context)
            ziggeoMainChannel.setMethodCallHandler(
                    ZiggeoMainMethodChannel(ziggeo,
                            recCallbackChannel,
                            fsCallbackChannel,
                            uplCallbackChannel,
                            plCallbackChannel,
                            qrCallbackChannel,
                            Handler(Looper.getMainLooper())
                    )
            )
            videosApiChannel.setMethodCallHandler(VideosMethodChannel(ziggeo))
            Timber.plant(Timber.DebugTree())
        }
    }

}
