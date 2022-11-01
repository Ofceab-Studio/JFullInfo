package com.jucodes.jfullinfo
import android.annotation.SuppressLint
import android.app.Activity
import android.content.Context.*
import android.content.Intent
import android.content.IntentFilter
import android.content.pm.PackageManager
import android.os.BatteryManager
import android.os.Build
import android.provider.Settings
import android.telecom.TelecomManager
import android.telephony.SubscriptionManager
import androidx.core.app.ActivityCompat
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry
private const val READ_REQ = 1
private const val READ_REQ2 = 2
class JInfoProvider(private val activity: Activity): PluginRegistry.RequestPermissionsResultListener {
    private var jResult: Result? = null
     fun getDeviceInfo(result: Result){
         this.jResult = result
            val fHInfo = getHardwareInfo()
         jResult!!.success(fHInfo.toString())
    }
    private fun getHardwareInfo(): JDeviceInfo {
        val aInf = Build.DEVICE
        val bInf = Build.MODEL
        val cInf = Build.BOARD
        val dInf = Build.BRAND
        val eInf = Build.DISPLAY
        val fInf = Build.FINGERPRINT
        val gInf = getBatteryPercentage()
        val hInf = Build.ID
        val iInf = Build.HOST
        @Suppress("DEPRECATION") val jInf = Build.CPU_ABI
        @Suppress("DEPRECATION") val kInf = Build.CPU_ABI2
        val lInf = Build.MANUFACTURER
        val mInf = Build.PRODUCT
        val nnInf: ArrayList<String> = ArrayList()
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            for (i in Build.SUPPORTED_ABIS) {
                nnInf.add(i)
            }
        } else {
            nnInf.add(jInf)
            nnInf.add(kInf)
        }
        val pInf = Build.BOOTLOADER
        return JDeviceInfo(
            getIDD().toString(),
            aInf,
            bInf,
            cInf, dInf, eInf, fInf, gInf.toString(), hInf, iInf, lInf, mInf, pInf, nnInf
        )
    }
    private fun getBatteryPercentage(): Int {
        return if (Build.VERSION.SDK_INT >= 21) {
            val bm = activity.getSystemService(BATTERY_SERVICE) as BatteryManager
            bm.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val iFilter = IntentFilter(Intent.ACTION_BATTERY_CHANGED)
            val batteryStatus: Intent? = activity.registerReceiver(null, iFilter)
            val level = batteryStatus?.getIntExtra(BatteryManager.EXTRA_LEVEL, -1)
            val scale = batteryStatus?.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
            val batteryPct = level?.div(scale?.toDouble() ?: 1.0)
            (batteryPct?.times(100))?.toInt()?:1
        }
    }
     fun getAndroidInfo(result: Result){
         this.jResult = result
        val fSyInfo = getSystemInfo()
         jResult!!.success(fSyInfo.toString())
    }
    private fun getSystemInfo(): JAndroidInfo {
        val fSDk = Build.VERSION.SDK_INT
        val fVRelease = Build.VERSION.RELEASE
        val fSecurityP = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            Build.VERSION.SECURITY_PATCH
        } else {
            ""
        }

        val fCodeName = Build.VERSION.CODENAME
        return JAndroidInfo(
            getIDD().toString(),
            fSDk.toString(),
            fSecurityP,
            fCodeName,
            fVRelease

        )
    }
     fun getSimInfo(result: Result){
         this.jResult = result
         if(!hasPermissionS()){
             requestP(READ_REQ)
         }else{
             val simsList: ArrayList<JSimInfo> = getSimCardInfo()
             jResult!!.success(convertListToS(simsList))
         }
    }
    @SuppressLint("MissingPermission")
    private fun getSimCardInfo(): ArrayList<JSimInfo> {
        val simsList: ArrayList<JSimInfo> = ArrayList()
        try{
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                val subscriptionManager = activity.getSystemService(TELEPHONY_SUBSCRIPTION_SERVICE) as SubscriptionManager
                val telecomManager: TelecomManager = activity.getSystemService(TELECOM_SERVICE) as TelecomManager
                val subscriptionList = subscriptionManager.activeSubscriptionInfoList
                val accountsList = telecomManager.callCapablePhoneAccounts
                if(subscriptionList.size == accountsList.size && subscriptionList.isNotEmpty()){
                    for (io in 0 until subscriptionList.size)
                    {
                        val i = subscriptionList[io]
                        val cId = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                            i.cardId.toString()
                        } else {
                            ""
                        }
                        val carId = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                            i.carrierId.toString()
                        } else {
                            ""
                        }
                        val mcc = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                            i.mccString.toString()
                        } else {
                            ""
                        }
                        val mnc = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                            i.mncString.toString()
                        } else {
                            ""
                        }

                        val fICCiD = i.iccId.ifEmpty {
                            accountsList[io].id
                        }

                        val simI =  JSimInfo(i.simSlotIndex.toString(),
                            fICCiD,cId,carId,
                            i.carrierName.toString(), i.countryIso,
                            i.displayName.toString(),
                            i.subscriptionId.toString(),
                            mcc,
                            mnc)
                        simsList.add(simI)
                    }
                }

            }
            return simsList
        }catch (e:Exception){
            return simsList
        }
    }
     fun getApplicationInfo(result: Result){
         this.jResult = result
        val fTA= getThisAppInfo()

         jResult!!.success(fTA.toString())
    }
    private fun getThisAppInfo(): JApplicationInfo {
        @Suppress("DEPRECATION") val packageI =
            activity.packageManager.getPackageInfo(activity.packageName,
                PackageManager.GET_PERMISSIONS)
        val aInf = packageI.applicationInfo
        val pf: ArrayList<String> = ArrayList()

        if (packageI.requestedPermissions != null) {
            if (packageI.requestedPermissions.isNotEmpty()) {
                for (i in packageI.requestedPermissions) {
                    pf.add(i)
                }
            }
        }

        @Suppress("DEPRECATION") val fVC = packageI.versionCode.toString()
        return JApplicationInfo(
           fVC,
           packageI.versionName,
           aInf.nonLocalizedLabel.toString(),
           aInf.packageName,
           aInf.targetSdkVersion.toString(),
           packageI.firstInstallTime.toString(),
           aInf.dataDir,
            aInf.uid.toString(),
           pf
       )
    }
     fun getAllInfo(result: Result){
         this.jResult = result
         if(!hasPermissionS()){
             requestP(READ_REQ2)
         }else{
             val fAIN = getInfoModel()
             jResult!!.success(fAIN.toString())
         }
    }
    private fun  getInfoModel(): JInfoModel {
        val fDI = getHardwareInfo()
        val fANI = getSystemInfo()
        val fAI = getThisAppInfo()
        var fSI: ArrayList<JSimInfo> = ArrayList()
        if(hasPermissionS()){
            fSI = getSimCardInfo()
        }
        return JInfoModel(fANI, fDI, fSI, fAI)
    }
    @SuppressLint("HardwareIds")
    private fun getIDD(): String? {
        return Settings.Secure.getString(activity.contentResolver, Settings.Secure.ANDROID_ID)
    }
    private fun requestP(reqC: Int) {
             ActivityCompat.requestPermissions(activity, arrayOf("android.permission.READ_PHONE_STATE"),reqC )
    }
    private fun hasPermissionS(): Boolean {
         return   ActivityCompat.checkSelfPermission(activity, "android.permission.READ_PHONE_STATE") == PackageManager.PERMISSION_GRANTED
    }
    /**
     * @param requestCode The request code passed in `ActivityCompat.requestPermissions(android.app.Activity, String[], int)`.
     * @param permissions The requested permissions.
     * @param grantResults The grant results for the corresponding permissions which is either
     * `PackageManager.PERMISSION_GRANTED` or `PackageManager.PERMISSION_DENIED`.
     * @return true if the result has been handled.
     */
    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray,
    ): Boolean {
        return if(requestCode != READ_REQ && requestCode != READ_REQ2){
            false
        }else{
            if(hasPermissionS()){
                if(requestCode == READ_REQ){
                    val simsList: ArrayList<JSimInfo> = getSimCardInfo()
                    jResult!!.success(convertListToS(simsList))
                }
                if(requestCode == READ_REQ2){
                    val fAIN = getInfoModel()
                    jResult!!.success(fAIN.toString())
                }
                true
            }else{
                if(requestCode == READ_REQ2){
                    val fAIN = getInfoModel()
                    jResult!!.success(fAIN.toString())
                }
                false
            }
        }
    }
}