package com.jucodes.jfullinfo
import org.json.JSONObject
 fun convertListToS(fJSimInfo: ArrayList<JSimInfo> = ArrayList()): ArrayList<String> {
     val fdd: ArrayList<String> = ArrayList()
     if(fJSimInfo.isNotEmpty()){
         for(i in fJSimInfo){
             fdd.add(i.toString())
         }
     }
     return fdd
 }
data class JInfoModel(
    var fJAndroidInfo: JAndroidInfo ,
    var fJSimInfo: ArrayList<JSimInfo> = ArrayList(),
    var fJApplicationInfo: JApplicationInfo){

    private fun toMap(): Map<String, Any> {
        return mapOf(
            "01" to fJAndroidInfo.toString(),
            "02" to convertListToS(fJSimInfo),
            "03" to fJApplicationInfo.toString())
    }
    override fun toString(): String {
        return JSONObject(toMap()).toString()
    }

}
data class JAndroidInfo(
    var fAndroidId:String = "",
    var fAndroidSdk:String = "",
    var fAndroidSecurityPatch:String = "",
    var fAndroidCodeName:String = "",
    var fAndroidRelease:String = "",
    var fDeviceDevice: String ="",
    var fDeviceModel: String ="",
    var fDeviceBoard: String ="",
    var fDeviceBrand: String ="",
    var fDeviceDisplay: String ="",
    var fDeviceFingerPrint: String ="",
    var fDeviceBatteryLevel: String ="",
    var fDeviceId: String ="",
    var fDeviceHost: String ="",
    var fDeviceManufacturer: String ="",
    var fDeviceProduct: String ="",
    var fDeviceBootloader: String ="",
    var fDeviceApis: ArrayList<String> = ArrayList()
){
    private fun toMap(): Map<String, Any> {
        return mapOf(
            "01" to fAndroidId,
            "02" to fAndroidSdk,
            "03" to fAndroidSecurityPatch,
            "04" to fAndroidCodeName,
            "05" to fAndroidRelease,
            "06" to fDeviceDevice,
            "07" to fDeviceModel,
            "08" to fDeviceBoard,
            "09" to fDeviceBrand,
            "010" to fDeviceDisplay,
            "011" to fDeviceFingerPrint,
            "012" to fDeviceBatteryLevel,
            "013" to fDeviceId,
            "014" to fDeviceHost,
            "015" to fDeviceManufacturer,
            "016" to fDeviceProduct,
            "017" to fDeviceBootloader,
            "018" to fDeviceApis,
        )
    }
    override fun toString(): String {
        return JSONObject(toMap()).toString()
    }
}

data class JSimInfo(
    var fSimSlotIndex: String ="",
    var fSimIccId: String ="",
    var fSimCardId: String ="",
    var fSimCarrierId: String ="",
    var fSimCarrierName: String ="",
    var fSimCountryIso: String ="",
    var fSimDisplayName: String ="",
    var fSimSubscriptionId: String ="",
    var fSimMcc: String ="",
    var fSimMnc: String ="",


){
    private fun toMap(): Map<String, Any> {
        return mapOf(
            "01" to fSimSlotIndex,
            "02" to fSimIccId,
            "03" to fSimCardId,
            "04" to fSimCarrierId,
            "05" to fSimCarrierName,
            "06" to fSimCountryIso,
            "07" to fSimDisplayName,
            "08" to fSimSubscriptionId,
            "09" to fSimMcc,
            "010" to fSimMnc,
        )
    }
    override fun toString(): String {
        return JSONObject(toMap()).toString()
    }
}
data class JApplicationInfo(
    var fAppVersionCode:String ="",
    var fAppVersionName:String ="",
    var fAppName:String ="",
    var fAppPackageName:String ="",
    var fAppTargetSdk:String ="",
    var fAppFirstInstall:String ="",
    var fAppDataDir:String ="",
    var fAppUID:String ="",
    var fAppPermissions: ArrayList<String> = ArrayList()
){
    private fun toMap(): Map<String, Any> {
        return mapOf(
            "01" to fAppVersionCode,
            "02" to fAppVersionName,
            "03" to fAppName,
            "04" to fAppPackageName,
            "05" to fAppTargetSdk,
            "06" to fAppFirstInstall,
            "07" to fAppDataDir,
            "08" to fAppUID,
            "09" to fAppPermissions,
        )
    }
    override fun toString(): String {
        return JSONObject(toMap()).toString()
    }
}
