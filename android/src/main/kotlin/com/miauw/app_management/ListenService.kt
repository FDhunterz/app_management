package com.miauw.app_management

import android.annotation.SuppressLint
import android.content.Intent
import androidx.core.app.NotificationCompat

import android.os.Build
import android.os.Bundle
import android.provider.Settings

import android.service.notification.StatusBarNotification

import android.service.notification.NotificationListenerService
import androidx.annotation.RequiresApi
import androidx.core.content.ContextCompat
import io.flutter.Log


@SuppressLint("OverrideAbstract")
@RequiresApi(Build.VERSION_CODES.KITKAT)

class ListenService : NotificationListenerService(){
    override fun onCreate() {
        super.onCreate()
        println("connected")
        startActivity(Intent(Settings.ACTION_NOTIFICATION_LISTENER_SETTINGS))
    }

        override fun onListenerConnected() {
            println( "Notification Listener connected")
        }

        override fun onNotificationPosted(sbn: StatusBarNotification) {
            if (sbn.packageName != WA_PACKAGE) return
            val notification = sbn.notification
            val bundle = notification.extras
            val from = bundle.getString(NotificationCompat.EXTRA_TITLE)
            val message = bundle.getString(NotificationCompat.EXTRA_TEXT)

            println("From: $from")
            println( "Message: $message")
        }

        companion object {
            private const val TAG = "NotificationListener"
            private const val WA_PACKAGE = "com.whatsapp"
        }
}