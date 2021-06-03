package com.thunderhead.addfluttertoexistingappexample.ui.dashboard

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup

import com.thunderhead.addfluttertoexistingappexample.R
import io.flutter.embedding.android.FlutterFragment
import io.flutter.embedding.android.RenderMode
import io.flutter.embedding.android.TransparencyMode
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache


class DashboardFragment : FlutterFragment() {
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