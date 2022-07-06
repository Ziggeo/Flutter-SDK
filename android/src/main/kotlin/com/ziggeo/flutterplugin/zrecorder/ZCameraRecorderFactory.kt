package com.ziggeo.flutterplugin.zrecorder

import android.content.Context
import com.ziggeo.androidsdk.widgets.cameraview.CameraView
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class ZCameraRecorderFactory(private val zVideoView: CameraView) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context?, id: Int, o: Any?): PlatformView {
        return ZCameraRecorderFlutter(zVideoView)
    }

}
