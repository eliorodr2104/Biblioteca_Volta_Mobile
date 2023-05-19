package com.biblioteca

import com.biblioteca.OggettiComuni.Utente
import io.ktor.client.*
import io.ktor.client.engine.darwin.Darwin
import io.ktor.client.plugins.cache.HttpCache
import io.ktor.client.plugins.onUpload
import io.ktor.client.request.*
import io.ktor.client.statement.readBytes

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

/*******************************/
/******        GET        ******/
/*******************************/

//GET OGGETTO DatiLibro

actual suspend fun getLibriCatalogo(indiceCatalogo: String): String? {
    return try {
        val libri = client.get("http://192.168.20.228:8080/catalogo/$indiceCatalogo")

        //Controllo per la risposta giusta del server
        if (libri.status.value in 200..299)
            libri.readBytes().decodeToString()

        else
            null

    }catch (s: Exception){
        "Server timeout connection"
    }
}

actual suspend fun getCopieLibroIdCopia(idCopia: String): String?{
    return try {
        val prestitiLibri = client.get("http://192.168.20.228:8080/copie/$idCopia")

        //Controllo per la risposta giusta del server
        if (prestitiLibri.status.value in 200..299)
            prestitiLibri.readBytes().decodeToString()

        else
            null

    }catch (s: Exception){
        "Server timeout connection"
    }
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

//GET OGGETTO Libro CON DENTRO LE COPIE

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

//GET OGGETTO Prestito

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

//GET OGGETTO String CON LE ETICCHETTE

actual suspend fun getCategorieLibri(listaIdCategoria: String): String?{
    return try {
        val prestitiLibri = client.get("http://192.168.20.228:8080/categorie/$listaIdCategoria")

        //Controllo per la risposta giusta del server
        if (prestitiLibri.status.value in 200..299)
            prestitiLibri.readBytes().decodeToString()

        else
            null

    }catch (s: Exception){
        "Server timeout connection"
    }
}

actual suspend fun getLibroIsbnApi(isbn: String): String?{
    return try {
        val prestitiLibri = client.get("http://192.168.20.228:8080/API/$isbn")

        //Controllo per la risposta giusta del server
        if (prestitiLibri.status.value in 200..299)
            prestitiLibri.readBytes().decodeToString()

        else
            null

    }catch (s: Exception){
        "Server timeout connection"
    }
}

/*******************************/
/******       POST        ******/
/*******************************/

//POST PER CARICARE I OGGETTI DatiLibro

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

//POST PER CARICARE I OGGETTI CopiaLibro

actual suspend fun postCopiaLibro(copiaLibro: String): String?{
    val postLibro = client.post {

        url("http://192.168.20.228:8080/copie")
        setBody(copiaLibro)

    }

    return postLibro.readBytes().decodeToString()
}


/*******************************/
/******      DELETE       ******/
/*******************************/

//DELETE PER CANCELLARE UNA SINGOLA COPIA

/**
 * PROVAAA, CHIEDERE A CAVA SE è UNA GET o una delete
 */
actual suspend fun deleteCopiaLibro(idCopia: String): String?{
    //cancella/{tabella}/{nomePK}/{valorePK}

    return try {
        val prestitiLibri = client.delete("http://192.168.20.228:8080/cancellaCopia/$idCopia")

        //Controllo per la risposta giusta del server
        if (prestitiLibri.status.value in 200..299)
            prestitiLibri.readBytes().decodeToString()

        else
            null

    }catch (s: Exception){
        "Server timeout connection"
    }
}