package com.ziggeo.flutterplugin.api

import android.annotation.SuppressLint
import android.media.Image
import com.ziggeo.androidsdk.Ziggeo
import com.ziggeo.androidsdk.net.models.images.Image
import com.ziggeo.androidsdk.net.models.images.ImageDetails
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.reactivex.Completable
import io.reactivex.Single
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import java.io.File

class ImagesMethodChannel(private val ziggeo: Ziggeo) : MethodCallHandler {

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "index" -> {
                var args: HashMap<String, String>? = null
                (call.arguments as? HashMap<String, String>)?.let {
                    args = it
                }
                processRequest(ziggeo.apiRx().imagesRaw()
                        .index(args), call, result)
            }
            "get" -> call.argument<String>("tokenOrKey")?.let {
                processRequest(ziggeo.apiRx().imagesRaw()[it], call, result)
            }
            "update" -> call.argument<String>("data")?.let {
                val model = ImageDetails()
                model.image = Image.fromJson(it)
                processRequest(ziggeo.apiRx().imagesRaw().update(model), call, result)
            }
            "destroy" -> call.argument<String>("tokenOrKey")?.let {
                processRequest(ziggeo.apiRx().imagesRaw().destroy(it), call, result)
            }
            "create" -> {
                var args: HashMap<String, String>? = null
                (call.arguments as? HashMap<String, String>)?.let {
                    args = it
                }
                (call.arguments as? File)?.let {
                    processRequest(ziggeo.apiRx().imagesRaw()
                            .create(it, args), call, result)
                }

            }
            "getImageUrl" -> call.argument<String>("tokenOrKey")?.let {
                processRequest(ziggeo.apiRx().imagesRaw().getImageUrl(it), call, result)
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
