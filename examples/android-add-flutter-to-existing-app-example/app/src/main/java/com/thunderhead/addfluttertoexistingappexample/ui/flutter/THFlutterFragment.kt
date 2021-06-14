package com.thunderhead.addfluttertoexistingappexample.ui.flutter

import android.content.Context
import android.os.Bundle
import io.flutter.embedding.android.FlutterFragment

class THFlutterFragment : FlutterFragment() {

    // Fixes a crash related to FlutterFragment embedded in a Navigation component.
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