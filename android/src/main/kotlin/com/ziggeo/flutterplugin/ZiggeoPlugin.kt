package com.ziggeo.flutterplugin

import android.os.Handler
import android.os.Looper
import com.ziggeo.androidsdk.Ziggeo
import com.ziggeo.flutterplugin.api.VideosMethodChannel
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodChannel
import timber.log.Timber

class ZiggeoPlugin : FlutterPlugin {
    private lateinit var ziggeoMainChannel: MethodChannel
    private lateinit var videosApiChannel: MethodChannel
    private lateinit var recCallbackChannel: MethodChannel
    private lateinit var fsCallbackChannel: MethodChannel
    private lateinit var uplCallbackChannel: MethodChannel
    private lateinit var plCallbackChannel: MethodChannel
    private lateinit var qrCallbackChannel: MethodChannel

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        ziggeoMainChannel = MethodChannel(binding.binaryMessenger, "ziggeo")
        videosApiChannel = MethodChannel(binding.binaryMessenger, "ziggeo_videos")
        recCallbackChannel = MethodChannel(binding.binaryMessenger, "ziggeo_rec_callback")
        fsCallbackChannel = MethodChannel(binding.binaryMessenger, "ziggeo_fs_callback")
        uplCallbackChannel = MethodChannel(binding.binaryMessenger, "ziggeo_upl_callback")
        plCallbackChannel = MethodChannel(binding.binaryMessenger, "ziggeo_pl_callback")
        qrCallbackChannel = MethodChannel(binding.binaryMessenger, "ziggeo_qr_callback")

        val context = binding.applicationContext
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

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        ziggeoMainChannel.setMethodCallHandler(null)
        videosApiChannel.setMethodCallHandler(null)
        recCallbackChannel.setMethodCallHandler(null)
        fsCallbackChannel.setMethodCallHandler(null)
        uplCallbackChannel.setMethodCallHandler(null)
        plCallbackChannel.setMethodCallHandler(null)
        qrCallbackChannel.setMethodCallHandler(null)
    }
}
