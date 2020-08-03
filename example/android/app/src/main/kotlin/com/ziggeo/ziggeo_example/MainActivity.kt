package com.ziggeo.ziggeo_example

import android.os.Bundle
import android.view.ViewGroup
import android.widget.Button
import android.widget.Toast
import com.google.firebase.crashlytics.FirebaseCrashlytics
import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
    }
}