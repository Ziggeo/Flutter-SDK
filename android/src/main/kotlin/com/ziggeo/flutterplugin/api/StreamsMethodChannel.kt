package com.ziggeo.flutterplugin.api

import android.annotation.SuppressLint
import com.ziggeo.androidsdk.Ziggeo
import com.ziggeo.flutterplugin.ifLet
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.reactivex.Completable
import io.reactivex.Single
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import java.io.File

class StreamsMethodChannel(private val ziggeo: Ziggeo) : MethodChannel.MethodCallHandler {

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        print("onMethodCall")
        when (call.method) {
            "accept" -> ifLet(
                    call.argument<String>("videoToken"),
                    call.argument<String>("streamToken")) {
                processRequest(ziggeo.apiRx().streams().bind(it[0], it[1]), call, result)
            }
            "destroy" -> ifLet(
                    call.argument<String>("videoToken"),
                    call.argument<String>("streamToken")) {
                processRequest(ziggeo.apiRx().streams().destroy(it[0], it[1]), call, result)
            }
            "create" -> {
                var args: HashMap<String, String>? = null
                (call.arguments as? HashMap<String, String>)?.let {
                    args = it
                }
                ifLet(
                        call.argument<String>("videoToken"),
                        call.argument<File>("path")) {
                    processRequest(ziggeo.apiRx().streams().create(it[0].toString(), it[1] as File, args), call, result)
                }
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
