package com.biblioteca

import com.biblioteca.OggettiComuni.Utente
import io.ktor.client.*
import io.ktor.client.engine.darwin.Darwin
import io.ktor.client.plugins.HttpTimeout
import io.ktor.client.plugins.onUpload
import io.ktor.client.request.*
import io.ktor.client.statement.readBytes
import io.ktor.client.statement.request

private val client = HttpClient(Darwin) {
    install(HttpTimeout) {
        connectTimeoutMillis = 5000
        socketTimeoutMillis = 5000
        connectTimeoutMillis = 5000
        requestTimeoutMillis = 10000
    }

    engine {
        /*
        configureSession {
            setProtocolClasses(listOf("TLSv1.2", "TLSv1.3"))
        }

         */
    }
}

actual suspend fun postLibroJsonServer(libro: String?): String? {
     val response = client.post {
         url("https://192.168.20.228:8443/libri")
         setBody(libro)

         onUpload { bytesSentTotal, contentLength ->
             println("Sent $bytesSentTotal bytes from $contentLength")
         }
     }

     return response.request.toString()
}

actual suspend fun getJsonLibro(): String? {
    return try {
        val getLibri = client.get("http://192.168.20.228:8080/libri")

        getLibri.readBytes().decodeToString()

    }catch (s: Exception){
        "Server timeout connection"
    }
}

actual suspend fun getPrestitiLibri(utentePrestito: Utente): String?{
    return try {
        val getLibri = client.get("http://192.168.20.228:8080/utenti/$utentePrestito/prestiti")

        getLibri.readBytes().decodeToString()

    }catch (s: Exception){
        "Server timeout connection"
    }
}

actual suspend fun getCopieLibri(isbn: String): String?{

    return try {
        if (isbn != ""){
            val getLibri = client.get("http://192.168.20.228:8080/libri/$isbn/copie")

            getLibri.readBytes().decodeToString()

        }else
            "Isbn empty"

    }catch (s: Exception){
        "Server timeout connection"
    }
}