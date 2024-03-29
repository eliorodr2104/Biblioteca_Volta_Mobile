package com.biblioteca

import io.ktor.utils.io.errors.IOException
import kotlinx.cinterop.ObjCObjectVar
import kotlinx.cinterop.alloc
import kotlinx.cinterop.memScoped
import kotlinx.cinterop.ptr
import kotlinx.cinterop.value
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.JsonArray
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.JsonPrimitive
import platform.Foundation.NSBundle
import platform.Foundation.NSError
import platform.Foundation.NSFileManager
import platform.Foundation.NSSearchPathForDirectoriesInDomains
import platform.Foundation.NSString
import platform.Foundation.NSUTF8StringEncoding
import platform.Foundation.create
import platform.Foundation.dataUsingEncoding
import platform.Foundation.stringWithContentsOfFile
import platform.Foundation.writeToFile
import platform.darwin.NSObject
import platform.darwin.NSObjectMeta

actual fun conversioneLinguaLibro(linguaDelLibro: String): String{
    val bundle: NSBundle = NSBundle.bundleForClass(BundleMarker)

    val name = "lingua.json"

    val (filename, type) =
        when (val lastPeriodIndex = name.lastIndexOf('.')) {
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

actual fun leggereCondizioniLibro(): ArrayList<String>{

    val bundle: NSBundle = NSBundle.bundleForClass(BundleMarker)

    val name = "condizione_libro.json"

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

    val arrayList = ArrayList<String>()

    val innerJsonArray = jsonObject["condizione"] as? JsonArray
    innerJsonArray?.forEach { jsonElement ->
        val value = (jsonElement as? JsonPrimitive)?.content
        value?.let {
            arrayList.add(value)
        }
    }

    return arrayList
}

private class BundleMarker : NSObject() {
    companion object : NSObjectMeta()
}