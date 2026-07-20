package com.example.clinic_app

import android.animation.Animator
import android.animation.AnimatorListenerAdapter
import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.widget.ImageView
import com.airbnb.lottie.LottieCompositionFactory
import com.airbnb.lottie.LottieDrawable

class SplashActivity : Activity() {
    private var hasOpenedFlutter = false

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_splash)

        val animationView = findViewById<ImageView>(R.id.splash_animation)
        LottieCompositionFactory.fromRawRes(this, R.raw.logo_animation)
            .addListener { composition ->
                val drawable = LottieDrawable().apply {
                    setComposition(composition)
                    repeatCount = 0
                    addAnimatorListener(object : AnimatorListenerAdapter() {
                        override fun onAnimationEnd(animation: Animator) {
                            openFlutter()
                        }
                    })
                }
                animationView.setImageDrawable(drawable)
                drawable.playAnimation()
            }
            .addFailureListener { openFlutter() }
    }

    private fun openFlutter() {
        if (hasOpenedFlutter || isFinishing) return
        hasOpenedFlutter = true
        startActivity(Intent(this, MainActivity::class.java))
        finish()
        overridePendingTransition(0, 0)
    }
}
