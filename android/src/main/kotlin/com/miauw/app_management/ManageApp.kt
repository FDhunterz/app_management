package com.miauw.app_management

import android.app.ActivityManager
import android.content.Context
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager

import android.content.Intent
import android.net.NetworkCapabilities

import android.net.NetworkInfo

import android.net.ConnectivityManager
import android.os.Build
import androidx.annotation.RequiresApi


class ManageApp {

    fun getNetworkSpeed(context: Context) : Map<String,String> {
        val cm = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
//        val netInfo = cm.activeNetworkInfo
        val nc = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                cm.getNetworkCapabilities(cm.activeNetwork)
            } else {
                TODO("VERSION.SDK_INT < M")
            }
        } else {
            TODO("VERSION.SDK_INT < LOLLIPOP")
        }
        val downSpeed = nc!!.linkDownstreamBandwidthKbps
        val upSpeed = nc!!.linkUpstreamBandwidthKbps

        return mapOf(
            "down" to downSpeed.toString(),
            "up" to upSpeed.toString(),
        )
    }

     fun killAll(context : Context) : String{

        val pack : PackageManager =  context.getPackageManager()
        var count : Int = 0;
        val lis : List<ApplicationInfo> = pack.getInstalledApplications(PackageManager.GET_META_DATA)
        val mActivityManager : ActivityManager = context.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
        for( i in lis){
            if(i.packageName != "com.miauw.booster"){
                ++count
                // work
                mActivityManager.killBackgroundProcesses(i.packageName)
            }else{
//                Log.d("app : " , i.sourceDir)
            }
        }
        return count.toString() +" App Killed"
    }

    fun getApp(context: Context): Array<Map<String, String>> {
        val pack : PackageManager =  context.getPackageManager()
        val lis : List<ApplicationInfo> = pack.getInstalledApplications(PackageManager.GET_META_DATA)
        var allApp : Array<Map<String,String>>  = arrayOf()
        for( i in lis){
            if(i.sourceDir.contains("/data/app") && i.packageName != "com.miauw.booster" && i.name != null){
                // work
                allApp += mapOf("package" to i.packageName, "name" to i.loadLabel(pack).toString())
            }
        }

        return allApp
    }

    fun getMemory(context:Context): Map<String, String> {
        val mActivityManager : ActivityManager = context.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
        var mi : ActivityManager.MemoryInfo = ActivityManager.MemoryInfo()
        mActivityManager.getMemoryInfo(mi)
        val availableMegs: Long = mi.availMem / 0x100000L
        return mapOf(
            "available_mem" to availableMegs.toString(),
            "total_mem" to (mi.totalMem / 0x100000L).toString(),
            "percentage_mem" to (mi.availMem / mi.totalMem.toDouble() * 100.0).toString()
        )
    }

    fun run(context:Context, packageName : String) : String{
        var string : String = "No Apps"
        try{
            var intent: Intent = context.getPackageManager().getLaunchIntentForPackage(packageName) as Intent
            if (intent != null) {
                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                context.startActivity(intent)
                string = "Running"
            } else {
                string = "No Apps"
            }

        }catch(_ : Exception){
            string = "No Apps"
        }
        return string
    }
}