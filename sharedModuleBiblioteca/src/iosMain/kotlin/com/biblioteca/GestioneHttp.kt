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

private val CONST_ADDRES_SERVER = "3.81.234.3:8080"

/*******************************/
/******        GET        ******/
/*******************************/

//GET OGGETTO DatiLibro

actual suspend fun getLibriCatalogo(indiceCatalogo: String): String? {
    return try {
        val libri = client.get("http://${CONST_ADDRES_SERVER}/catalogo/$indiceCatalogo")

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
        val prestitiLibri = client.get("http://${CONST_ADDRES_SERVER}/copie/$idCopia")

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
        val prestitiLibri = client.get("http://${CONST_ADDRES_SERVER}/libri/$isbn")

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
            val copieLibri = client.get("http://${CONST_ADDRES_SERVER}/libri/$isbn/copie")

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

//GET OGGETTO Libro CON DENTRO LE COPIE

actual suspend fun getFiltroLibri(mappaRicerca: HashMap<String, String>, listaIdCategoria: String): String? {
    return try {

        val libri = client.get("http://${CONST_ADDRES_SERVER}/filtra/$mappaRicerca/$listaIdCategoria")

        //Controllo per la risposta giusta del server
        if (libri.status.value in 200..299)
            libri.readBytes().decodeToString()

        else
            null

    }catch (s: Exception){
        "Server timeout connection"
    }
}

//GET OGGETTO Prestito

actual suspend fun getPrestitiLibri(utentePrestito: Utente): String?{
    return try {
        val prestitiLibri = client.get("http://${CONST_ADDRES_SERVER}/utenti/${utentePrestito.idUtente}/prestiti")

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
        val prestitiLibri = client.get("http://${CONST_ADDRES_SERVER}/categorie/$listaIdCategoria")

        //Controllo per la risposta giusta del server
        if (prestitiLibri.status.value in 200..299)
            prestitiLibri.readBytes().decodeToString()

        else
            null

    }catch (s: Exception){
        "Server timeout connection"
    }
}

actual suspend fun getCategorie(): String?{
    return try {
        val prestitiLibri = client.get("http://${CONST_ADDRES_SERVER}/categorie")

        //Controllo per la risposta giusta del server
        if (prestitiLibri.status.value in 200..299)
            prestitiLibri.readBytes().decodeToString()

        else
            null

    }catch (s: Exception){
        "Server timeout connection"
    }
}

actual suspend fun getGeneri(): String?{
    return try {
        val prestitiLibri = client.get("http://${CONST_ADDRES_SERVER}/generi")

        //Controllo per la risposta giusta del server
        if (prestitiLibri.status.value in 200..299)
            prestitiLibri.readBytes().decodeToString()

        else
            null

    }catch (s: Exception){
        "Server timeout connection"
    }
}

//GET LIBRO DA UN ISBN

actual suspend fun getLibroIsbnApi(isbn: String): String?{
    return try {
        val prestitiLibri = client.get("http://${CONST_ADDRES_SERVER}/API/$isbn")

        //Controllo per la risposta giusta del server
        if (prestitiLibri.status.value in 200..299)
            prestitiLibri.readBytes().decodeToString()

        else
            null

    }catch (s: Exception){
        "Server timeout connection"
    }
}

//GET UTENTE DA MAIL INSTITUZIONALE
actual suspend fun getUtenteInstituzionale(email: String): String?{
    return try {
        val prestitiLibri = client.get("http://${CONST_ADDRES_SERVER}/utenti/$email")

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

         url("http://${CONST_ADDRES_SERVER}/libri")
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

        url("http://${CONST_ADDRES_SERVER}/copie")
        setBody(copiaLibro)

    }

    return postLibro.readBytes().decodeToString()
}

//POST PER CARICARE I OGGETTI Utente
actual suspend fun postUtenti(utente: String): String?{
    val postLibro = client.post {

        url("http://${CONST_ADDRES_SERVER}/utenti")
        setBody(utente)
    }

    println(postLibro.readBytes().decodeToString())

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
        val prestitiLibri = client.delete("http://${CONST_ADDRES_SERVER}/cancellaCopia/$idCopia")
        
        //Controllo per la risposta giusta del server
        if (prestitiLibri.status.value in 200..299)
            prestitiLibri.readBytes().decodeToString()

        else
            null

    }catch (s: Exception){
        "Server timeout connection"
    }
}