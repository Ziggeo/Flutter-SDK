package com.ziggeo.flutterplugin.api

import android.annotation.SuppressLint
import com.ziggeo.androidsdk.Ziggeo
import com.ziggeo.androidsdk.net.models.videos.VideoModel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.reactivex.Completable
import io.reactivex.Single
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers

class VideosMethodChannel(private val ziggeo: Ziggeo) : MethodCallHandler {

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        print("onMethodCall")
        when (call.method) {
            "index" -> {
                var args: HashMap<String, String>? = null
                (call.arguments as? HashMap<String, String>)?.let {
                    args = it
                }
                processRequest(ziggeo.apiRx().videosRaw()
                        .index(args), call, result)
            }
            "get" -> call.argument<String>("videoToken")?.let {
                processRequest(ziggeo.apiRx().videosRaw()[it], call, result)
            }
            "getVideoUrl" -> call.argument<String>("videoToken")?.let {
                processRequest(ziggeo.apiRx().videosRaw().getVideoUrl(it), call, result)
            }
            "getImageUrl" -> call.argument<String>("videoToken")?.let {
                processRequest(ziggeo.apiRx().videosRaw().getImageUrl(it), call, result)
            }
            "update" -> call.argument<String>("data")?.let {
                processRequest(ziggeo.apiRx().videosRaw().update(VideoModel.fromJson(it)), call, result)
            }
            "destroy" -> call.argument<String>("videoToken")?.let {
                processRequest(ziggeo.apiRx().videosRaw().destroy(it), call, result)
            }
            "create" -> {
                var args: HashMap<String, String>? = null
                (call.arguments as? HashMap<String, String>)?.let {
                    args = it
                }
                processRequest(ziggeo.apiRx().videosRaw()
                        .create(args), call, result)
            }
            "createWithFile" -> {
            }
            else -> result.notImplemented()
        }
    }

    @SuppressLint("CheckResult")
    private fun processRequest(request: Single<*>, call: MethodCall, result: MethodChannel.Result) {
        request.subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe { json, throwable ->
                    if (throwable != null) {
                        result.error(call.method, throwable.toString(), throwable.message)
                    } else json?.let {
                        result.success(json)
                    }
                }
    }

    @SuppressLint("CheckResult")
    private fun processRequest(request: Completable, call: MethodCall, result: MethodChannel.Result) {
        request.subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe({
                    result.success(null)
                }, { throwable: Throwable? -> result.error(call.method, throwable.toString(), throwable?.message) })
    }
}
