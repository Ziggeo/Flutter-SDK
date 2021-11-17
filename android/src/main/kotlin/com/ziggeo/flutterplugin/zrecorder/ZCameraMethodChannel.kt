package com.ziggeo.flutterplugin.zrecorder

import com.ziggeo.androidsdk.Ziggeo
import com.ziggeo.androidsdk.callbacks.RecorderCallback
import com.ziggeo.androidsdk.widgets.cameraview.CameraView
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.text.SimpleDateFormat
import java.util.*

class ZCameraMethodChannel(private val zCameraRecorder: CameraView, private val ziggeo: Ziggeo) : MethodChannel.MethodCallHandler {
    val config = ziggeo.recorderConfig
    var recordedFile: File? = null

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {

        print("onMethodCall")
        when (call.method) {
            "isRecording" -> {
                result.success(zCameraRecorder.isRecording)
            }
            "getCallback" -> {
                result.success(config.callback)
            }
            "getRecordedFile" ->
                result.success(recordedFile?.path)
            "switchCamera" -> {
                val isFacingBack = zCameraRecorder.facing == CameraView.FACING_BACK
                zCameraRecorder.facing = if (isFacingBack) CameraView.FACING_FRONT else CameraView.FACING_BACK
            }
            "start" -> {
                zCameraRecorder.start()
            }
            "stop" -> {
                zCameraRecorder.stop()
            }
            "loadConfigs" -> {
                if (config.callback != null) {
                    config.callback!!.loaded()
                }

                val analyticsManager = ziggeo.analyticsManager()
                analyticsManager.addEmbeddingRecorderLoadedEvent()

                zCameraRecorder.setResolution(config.resolution)
                zCameraRecorder.setVideoBitrate(config.videoBitrate)
                zCameraRecorder.setAudioBitrate(config.audioBitrate)
                zCameraRecorder.setAudioSampleRate(config.audioSampleRate)
                zCameraRecorder.quality = config.videoQuality
                zCameraRecorder.facing = config.facing

                zCameraRecorder.setCameraCallback(object : CameraView.CameraCallback() {
                    override fun cameraOpened() {
                        super.cameraOpened()
                        readyToRecord()
                    }
                })

                zCameraRecorder.setRecorderCallback(object : RecorderCallback() {
                    override fun recordingStarted() {
                        super.recordingStarted()
                        startedRecording()
                    }

                    override fun error(throwable: Throwable) {
                        super.error(throwable)
                        recordingError(throwable)
                    }

                    override fun recordingStopped(path: String) {
                        super.recordingStopped(path)
                        recordingStopped()
                    }

                })
            }
            "startRecording" -> {
                if (recordedFile != null) {
                    recordedFile!!.delete()
                    if (config.callback != null) {
                        config.callback!!.rerecord()
                    }
                }

                val defaultPath = config.cacheConfig.cacheRoot

                if (!defaultPath.exists()) {
                    defaultPath.mkdirs()
                }
                recordedFile = File(defaultPath, getVideoFileName())
                zCameraRecorder.startRecording(recordedFile!!.path, config.maxDuration.toInt())
            }
            "stopRecording" -> {
                if (config.callback != null) {
                    config.callback!!.recordingStopped(recordedFile!!.path)
                }
                zCameraRecorder.stopRecording()
            }
            else -> result.notImplemented()
        }
    }

    private fun readyToRecord() {
        if (config.callback != null) {
            config.callback!!.readyToRecord()
        }
    }

    private fun startedRecording() {
        if (config.callback != null) {
            config.callback!!.recordingStarted()
        }
    }

    private fun recordingError(throwable: Throwable) {
        if (config.callback != null) {
            config.callback!!.error(throwable)
        }
    }

    private fun recordingStopped() {
        val path: String = recordedFile?.path ?: ""

        if (config.callback != null) {
            config.callback!!.recordingStopped(path)
        }
    }

    private fun getVideoFileName(): String {
        return ("Rec_" + formatDate() + ".mp4")
    }

    private fun formatDate(): String? {
        return SimpleDateFormat("dd.MM.yyyy_HH.mm.ss").format(Date())
    }
}
