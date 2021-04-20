package com.ziggeo.flutterplugin.zvideo

import android.content.Context
import android.view.View
import com.ziggeo.androidsdk.Ziggeo
import com.ziggeo.androidsdk.widgets.videoview.ZVideoView
import io.flutter.plugin.platform.PlatformView

class ZVideoViewFlutter(context: Context,private val zVideoView: ZVideoView, private val ziggeo: Ziggeo) : PlatformView {

    override fun getView(): View {
        return zVideoView
    }

    override fun dispose() {
    }

}
