package com.biblioteca

import kotlinx.cinterop.ObjCObjectVar
import kotlinx.cinterop.alloc
import kotlinx.cinterop.memScoped
import kotlinx.cinterop.ptr
import kotlinx.cinterop.value
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.json.Json
import platform.Foundation.NSBundle
import platform.Foundation.NSError
import platform.Foundation.NSString
import platform.Foundation.NSUTF8StringEncoding
import platform.Foundation.stringWithContentsOfFile
import platform.darwin.NSObject
import platform.darwin.NSObjectMeta

actual fun conversioneLinguaLibro(linguaDelLibro: String): String{
    val bundle: NSBundle = NSBundle.bundleForClass(BundleMarker)

    val name = "lingua.json"

    val (filename, type) = when (val lastPeriodIndex = name.lastIndexOf('.')) {
        0 -> {
            null to name.drop(1)
        }
        in 1..Int.MAX_VALUE -> {
            name.take(lastPeriodIndex) to name.drop(lastPeriodIndex + 1)
        }
        else -> {
            name to null
        }
    }
    val path = bundle.pathForResource(filename, type) ?: error(
        "Couldn't get path of $name (parsed as: ${listOfNotNull(filename,type).joinToString(".")})"
    )

    val jsonObject = Json.decodeFromString<HashMap<String, String>>(memScoped {
        val errorPtr = alloc<ObjCObjectVar<NSError?>>()

        NSString.stringWithContentsOfFile(
            path,
            encoding = NSUTF8StringEncoding,
            error = errorPtr.ptr
        ) ?: run {
            error("Couldn't load resource: $name. Error: ${errorPtr.value?.localizedDescription} - ${errorPtr.value}")
        }
    })

    return jsonObject[linguaDelLibro].toString()

}

private class BundleMarker : NSObject() {
    companion object : NSObjectMeta()
}