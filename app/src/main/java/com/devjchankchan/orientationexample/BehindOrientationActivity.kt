package com.devjchankchan.orientationexample

import android.content.Intent
import android.content.pm.ActivityInfo
import android.content.res.Configuration
import android.os.Bundle
import android.support.design.widget.FloatingActionButton
import android.support.design.widget.Snackbar
import android.support.v7.app.AppCompatActivity
import android.support.v7.widget.Toolbar

class BehindOrientationActivity : AppCompatActivity() {

    var stackOrientation = ActivityInfo.SCREEN_ORIENTATION_UNSPECIFIED

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_behind_orientation)
        val toolbar = findViewById(R.id.toolbar) as Toolbar
        setSupportActionBar(toolbar)

        stackOrientation = intent.getIntExtra("screenOrientation", ActivityInfo.SCREEN_ORIENTATION_UNSPECIFIED)
        rememberOrientation()

        val fab = findViewById(R.id.fab) as FloatingActionButton
        fab.setOnClickListener { view ->
            Snackbar.make(view, "Show next activity", Snackbar.LENGTH_LONG)
                    .setAction("Action", null).show()
            val intent = Intent(this, NotRotationActivity::class.java)
            startActivity(intent)
        }
    }

    override fun onConfigurationChanged(newConfig: Configuration?) {
        super.onConfigurationChanged(newConfig)
        rememberOrientation()
    }

    private fun rememberOrientation() {
        if (ActivityInfo.SCREEN_ORIENTATION_UNSPECIFIED != stackOrientation) {
            requestedOrientation = stackOrientation
        }
    }
}
