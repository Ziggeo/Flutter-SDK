package com.ziggeo.flutterplugin.api

import com.ziggeo.androidsdk.Ziggeo
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
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
                ziggeo.apiRx().videosRaw()
                        .index(args)
                        .subscribeOn(Schedulers.io())
                        .observeOn(AndroidSchedulers.mainThread())
                        .subscribe { json, throwable ->
                            if (throwable != null) {
                                result.error(call.method, throwable.toString(), throwable.message)
                            } else json?.let {
                                result.success(json)
                            }
                        }
            }
            else -> result.notImplemented()
        }
    }

}
