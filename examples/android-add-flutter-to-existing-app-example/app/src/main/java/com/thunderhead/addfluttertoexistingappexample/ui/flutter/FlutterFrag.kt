package com.thunderhead.addfluttertoexistingappexample.ui.flutter

import android.content.Context
import android.os.Bundle
import io.flutter.embedding.android.FlutterFragment

class FlutterFrag : FlutterFragment() {

    // Fixes crash on FlutterFragment related to Navigation component.
    // https://github.com/flutter/flutter/issues/45793
    override fun onAttach(context: Context) {
        arguments = Bundle().apply {
            putString("", "")
        }
        super.onAttach(context)
    }
    override fun getCachedEngineId(): String? {
        return "my_engine_id"
    }
}