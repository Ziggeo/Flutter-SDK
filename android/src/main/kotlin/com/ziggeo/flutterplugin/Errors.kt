package com.ziggeo.flutterplugin

enum class Errors(val code: String, val msg: String, val details: Any?) {
    EMPTY_TOKEN("0", "Application token can't be empty.", null);
}