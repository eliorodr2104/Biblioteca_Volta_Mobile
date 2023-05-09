package com.biblioteca

import com.biblioteca.OggettiComuni.Utente
import io.ktor.client.*
import io.ktor.client.engine.darwin.Darwin
import io.ktor.client.plugins.HttpRequestRetry
import io.ktor.client.plugins.cache.HttpCache
import io.ktor.client.plugins.cookies.HttpCookies
import io.ktor.client.plugins.onUpload
import io.ktor.client.request.*
import io.ktor.client.statement.readBytes
import io.ktor.client.statement.request

private val client = HttpClient(Darwin) {
    //PROVA DELLA CACHE DI SISTEMA PER LE RICHIESTE HTTP
    install(HttpCache)

    //PROVA DELLE COOKIES
    //install(HttpCookies)

    //PROVA DI MODULA PER FARE VAR TENTATIVI
    /*
    install(HttpRequestRetry) {
        retryOnServerErrors(maxRetries = 5)
        exponentialDelay()
    }

     */

    engine {
        /*
        configureSession {
            setProtocolClasses(listOf("TLSv1.2", "TLSv1.3"))
        }

         */
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

actual suspend fun postLibroJsonServer(libro: String?): String? {
     val postLibro = client.post {

         url("http://192.168.20.228:8080/libri")
         setBody(libro)

         onUpload { bytesSentTotal, contentLength ->
             println("Sent $bytesSentTotal bytes from $contentLength")
         }
     }

     return postLibro.toString()
}

actual suspend fun getJsonLibro(): String? {
    return try {
        val libri = client.get("http://192.168.20.228:8080/libri")

        //Controllo per la risposta giusta del server
        if (libri.status.value in 200..299)
            libri.readBytes().decodeToString()

        else
            null

    }catch (s: Exception){
        "Server timeout connection"
    }
}

actual suspend fun getPrestitiLibri(utentePrestito: Utente): String?{
    return try {
        val prestitiLibri = client.get("http://192.168.20.228:8080/utenti/${utentePrestito.idUtente}/prestiti")

        //Controllo per la risposta giusta del server
        if (prestitiLibri.status.value in 200..299)
            prestitiLibri.readBytes().decodeToString()

        else
            null

    }catch (s: Exception){
        "Server timeout connection"
    }
}

actual suspend fun getCategorieLibri(listaIdCategoria: ArrayList<Int>): String?{
    val listaCategorieString = listaIdCategoria.joinToString(separator = ",")

    return try {
        val prestitiLibri = client.get("http://192.168.20.228:8080/categorie/$listaCategorieString")

        //Controllo per la risposta giusta del server
        if (prestitiLibri.status.value in 200..299)
            prestitiLibri.readBytes().decodeToString()

        else
            null

    }catch (s: Exception){
        "Server timeout connection"
    }
}
