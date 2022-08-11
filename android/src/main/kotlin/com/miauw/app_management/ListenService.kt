package com.miauw.app_management

import android.annotation.SuppressLint
import android.content.Context
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
import io.flutter.plugin.common.MethodChannel
import android.app.ActivityManager
import android.content.ComponentName
import android.text.TextUtils


@SuppressLint("OverrideAbstract")
@RequiresApi(Build.VERSION_CODES.KITKAT)

class ListenService : NotificationListenerService(){

    companion object {
        private const val TAG = "NotificationListener"
        private const val WA_PACKAGE = "com.whatsapp"
        private const val DISCORD_PACKAGE = "com.discord"
        private const val TELEGRAM_PACKAGE = "com.telegram"
        private lateinit var mContext: Context
        lateinit var  result: MethodChannel
        var VALUES = ""
    }

     fun isNotificationServiceEnabled(context : Context) : Boolean {
            val cn = ComponentName(context, ListenService::class.java)
            val flat =
                Settings.Secure.getString(context.contentResolver, "enabled_notification_listeners")
            val enabled = flat != null && flat.contains(cn.flattenToString())
               return enabled
     }

    fun start(context: Context,results: MethodChannel){
        try{
            if(!isNotificationServiceEnabled(context)){
                context.startActivity(Intent(Settings.ACTION_NOTIFICATION_LISTENER_SETTINGS).addFlags(Intent.FLAG_ACTIVITY_NEW_TASK))
            }

            mContext = context
            result = results;
        }catch( e:Exception){
            println(e.toString())
        }
    }

    fun getLastMessage() : String{
        return VALUES
    }


    override fun onListenerConnected() {
    }
    override fun onNotificationPosted(sbn: StatusBarNotification) {
            try{
                if (sbn.packageName == WA_PACKAGE || sbn.packageName == DISCORD_PACKAGE || sbn.packageName == TELEGRAM_PACKAGE) {
                    var notification = sbn.getNotification()
                    var bundle : Bundle = notification.extras
    
                    val evt = Listen(mContext, sbn)
                    try{
                        result.invokeMethod("whatsapp_message", evt.data)
                    }catch(e : Exception){
                    }
    
                }
            }catch(j:Exception){
    
            }

    }
}