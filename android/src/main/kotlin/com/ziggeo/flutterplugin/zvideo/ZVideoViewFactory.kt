package com.ziggeo.flutterplugin.zvideo

import android.content.Context
import com.ziggeo.androidsdk.Ziggeo
import com.ziggeo.androidsdk.widgets.videoview.ZVideoView
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class ZVideoViewFactory(private val zVideoView: ZVideoView) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, id: Int, o: Any?): PlatformView {
        return ZVideoViewFlutter(context, zVideoView, Ziggeo(context))
    }
}