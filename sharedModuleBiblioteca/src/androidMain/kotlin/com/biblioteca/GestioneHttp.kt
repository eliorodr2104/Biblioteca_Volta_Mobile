package com.biblioteca

import com.biblioteca.OggettiComuni.Utente
import io.ktor.client.*
import io.ktor.client.engine.okhttp.OkHttp
import io.ktor.client.plugins.onUpload
import io.ktor.client.request.get
import io.ktor.client.request.post
import io.ktor.client.request.setBody
import io.ktor.client.statement.readBytes
import io.ktor.http.ContentType
import io.ktor.http.contentType
import java.security.SecureRandom
import javax.net.ssl.SSLContext

private val client = HttpClient(OkHttp) {
    engine {
        config {
            val trustAllCerts = SslTest()
            val sslContext = SSLContext.getInstance("SSL")
            sslContext.init(null, arrayOf(trustAllCerts), SecureRandom())
            val sslSocketFactory = sslContext.socketFactory

            sslSocketFactory(sslSocketFactory, trustAllCerts)

            hostnameVerifier { _, _ -> true }
        }
    }
}

actual suspend fun postLibroJsonServer(libro: String?): String? {
    val response = client.post("https://192.168.20.228:8443/libri") {
        contentType(ContentType.Application.Json)
        setBody(libro)

        onUpload { bytesSentTotal, contentLength ->
            println("Sent $bytesSentTotal bytes from $contentLength")
        }
    }

    return response.call.toString()
}

actual suspend fun getLibriCatalogo(indiceCatalogo: String): String? {
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
            val copieLibri = client.get("http://192.168.20.228:8080/libri/$isbn/copie")

            if (copieLibri.status.value in 200..299)
                copieLibri.readBytes().decodeToString()

            else
                null


        }else
            "Isbn empty"

    }catch (s: Exception){
        "Server timeout connection"
    }
}

actual suspend fun getCategorieLibri(listaIdCategoria: String): String?{
    return try {
        val prestitiLibri = client.get("http://192.168.20.228:8080/utenti/")

        //Controllo per la risposta giusta del server
        if (prestitiLibri.status.value in 200..299)
            prestitiLibri.readBytes().decodeToString()

        else
            null

    }catch (s: Exception){
        "Server timeout connection"
    }
}

actual suspend fun deleteCopiaLibro(idCopia: String): String?{
    return null
}

actual suspend fun getCopieLibroIdCopia(idCopia: String): String?{
    return null
}

actual suspend fun getLibroIsbn(isbn: String): String?{
    return try {
        val prestitiLibri = client.get("http://192.168.20.228:8080/libri/$isbn")

        //Controllo per la risposta giusta del server
        if (prestitiLibri.status.value in 200..299)
            prestitiLibri.readBytes().decodeToString()

        else
            null

    }catch (s: Exception){
        "Server timeout connection"
    }
}

actual suspend fun postCopiaLibro(copiaLibro: String): String?{
    return null
}

actual suspend fun getLibroIsbnApi(isbn: String): String?{
    return null
}

actual suspend fun getUtenteInstituzionale(email: String): String?{
    return null
}

actual suspend fun postUtenti(utente: String): String?{
    return null
}

actual suspend fun getFiltroLibri(mappaRicerca: HashMap<String, String>, listaIdCategoria: String): String? {
    return null
}