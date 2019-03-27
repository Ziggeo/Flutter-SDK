package com.ziggeo.flutterplugin;

public enum Errors {
    EMPTY_TOKEN("0", "Application token can't be empty.", null);

    public final String code;
    public final String msg;
    public final Object details;

    Errors(String code, String msg, Object details) {
        this.code = code;
        this.msg = msg;
        this.details = details;
    }
}
