package com.ziggeo.flutterplugin.zrecorder

import android.view.View
import com.ziggeo.androidsdk.widgets.cameraview.CameraView
import io.flutter.plugin.platform.PlatformView

class ZCameraRecorderFlutter(private val cameraView: CameraView) : PlatformView {

    override fun getView(): View {
        return cameraView
    }

    override fun dispose() {
    }
}