package com.ziggeo.flutterplugin

import android.os.Handler
import android.os.Looper
import com.ziggeo.androidsdk.Ziggeo
import com.ziggeo.androidsdk.widgets.cameraview.CameraView
import com.ziggeo.androidsdk.widgets.videoview.ZVideoView
import com.ziggeo.flutterplugin.api.StreamsMethodChannel
import com.ziggeo.flutterplugin.api.AudiosMethodChannel
import com.ziggeo.flutterplugin.api.ImagesMethodChannel
import com.ziggeo.flutterplugin.api.VideosMethodChannel
import com.ziggeo.flutterplugin.zrecorder.ZCameraMethodChannel
import com.ziggeo.flutterplugin.zrecorder.ZCameraRecorderFactory
import com.ziggeo.flutterplugin.zvideo.ZVideoMethodChannel
import com.ziggeo.flutterplugin.zvideo.ZVideoViewFactory
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodChannel
import timber.log.Timber

class ZiggeoPlugin : FlutterPlugin {
    private lateinit var ziggeoMainChannel: MethodChannel
    private lateinit var videosApiChannel: MethodChannel
    private lateinit var streamsApiChannel: MethodChannel
    private lateinit var imagesApiChannel: MethodChannel
    private lateinit var audiosApiChannel: MethodChannel
    private lateinit var recCallbackChannel: MethodChannel
    private lateinit var fsCallbackChannel: MethodChannel
    private lateinit var uplCallbackChannel: MethodChannel
    private lateinit var plCallbackChannel: MethodChannel
    private lateinit var qrCallbackChannel: MethodChannel
    private lateinit var zvCallbackChannel: MethodChannel
    private lateinit var zcrCallbackChannel: MethodChannel

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        ziggeoMainChannel = MethodChannel(binding.binaryMessenger, "ziggeo")
        videosApiChannel = MethodChannel(binding.binaryMessenger, "ziggeo_videos")
        streamsApiChannel = MethodChannel(binding.binaryMessenger, "ziggeo_streams")
        imagesApiChannel = MethodChannel(binding.binaryMessenger, "ziggeo_images")
        audiosApiChannel = MethodChannel(binding.binaryMessenger, "ziggeo_audios")
        recCallbackChannel = MethodChannel(binding.binaryMessenger, "ziggeo_rec_callback")
        fsCallbackChannel = MethodChannel(binding.binaryMessenger, "ziggeo_fs_callback")
        uplCallbackChannel = MethodChannel(binding.binaryMessenger, "ziggeo_upl_callback")
        plCallbackChannel = MethodChannel(binding.binaryMessenger, "ziggeo_pl_callback")
        qrCallbackChannel = MethodChannel(binding.binaryMessenger, "ziggeo_qr_callback")
        zvCallbackChannel = MethodChannel(binding.binaryMessenger, "z_video_view")
        zcrCallbackChannel = MethodChannel(binding.binaryMessenger, "z_camera_recorder")

        val context = binding.applicationContext
        val ziggeo = Ziggeo.getInstance(context)
        context.setTheme(R.style.ZiggeoTheme)
        val zVideoView = ZVideoView(context)
        val zCameraView = CameraView(context)

        binding
                .platformViewRegistry
                .registerViewFactory("z_camera_view", ZCameraRecorderFactory(zCameraView))
        binding
                .platformViewRegistry
                .registerViewFactory("z_video_player", ZVideoViewFactory(zVideoView))

        ziggeoMainChannel.setMethodCallHandler(
                ZiggeoMainMethodChannel(ziggeo,
                        recCallbackChannel,
                        fsCallbackChannel,
                        uplCallbackChannel,
                        plCallbackChannel,
                        qrCallbackChannel,
                        zvCallbackChannel,
                        Handler(Looper.getMainLooper())
                )
        )
        videosApiChannel.setMethodCallHandler(VideosMethodChannel(ziggeo))
        streamsApiChannel.setMethodCallHandler(StreamsMethodChannel(ziggeo))
        imagesApiChannel.setMethodCallHandler(ImagesMethodChannel(ziggeo))
        audiosApiChannel.setMethodCallHandler(AudiosMethodChannel(ziggeo))
        zvCallbackChannel.setMethodCallHandler(ZVideoMethodChannel(zVideoView, ziggeo))
        zcrCallbackChannel.setMethodCallHandler(ZCameraMethodChannel(zCameraView, ziggeo))

        Timber.plant(Timber.DebugTree())
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        ziggeoMainChannel.setMethodCallHandler(null)
        videosApiChannel.setMethodCallHandler(null)
        streamsApiChannel.setMethodCallHandler(null)
        imagesApiChannel.setMethodCallHandler(null)
        audiosApiChannel.setMethodCallHandler(null)
        recCallbackChannel.setMethodCallHandler(null)
        fsCallbackChannel.setMethodCallHandler(null)
        uplCallbackChannel.setMethodCallHandler(null)
        plCallbackChannel.setMethodCallHandler(null)
        qrCallbackChannel.setMethodCallHandler(null)
        zvCallbackChannel.setMethodCallHandler(null)
    }
}
