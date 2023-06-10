package com.biblioteca.GestioneServer

import com.biblioteca.OggettiComuni.CopiaLibro
import com.biblioteca.OggettiComuni.DatiLibro
import com.biblioteca.OggettiComuni.Libro
import com.biblioteca.OggettiComuni.Prestito
import com.biblioteca.OggettiComuni.Utente
import com.biblioteca.deleteCopiaLibro
import com.biblioteca.getCategorieLibri
import com.biblioteca.getCopieLibri
import com.biblioteca.getCopieLibroIdCopia
import com.biblioteca.getFiltroLibri
import com.biblioteca.postLibroJsonServer
import com.biblioteca.getLibriCatalogo
import com.biblioteca.getLibroIsbn
import com.biblioteca.getLibroIsbnApi
import com.biblioteca.getPrestitiLibri
import com.biblioteca.getUtenteInstituzionale
import com.biblioteca.postUtenti
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.json.Json

class GestioneJson {

    /*******************************/
    /******        GET        ******/
    /*******************************/

    //GET OGGETTO DatiLibro

    /**
     * Metodo getPezziDelCatalogo()
     * Viene utilizzato per richiedere una quantità di libri (10); Se restituisce null è che
     * la connessione è fallita o non ci sono più libri
     *
     * @param indiceCatalogo: String = Il quale ha l'indice del pezzo del catalogo
     *                        che si sta richiedendo.
     * @return L'ArrayList (Non Null-Safety), il quale ha i libri da visualizzare.
     */
    suspend fun getPezziDelCatalogo(indiceCatalogo: String): ArrayList<DatiLibro>? {
        return try {
            val stringHttpJson = getLibriCatalogo(indiceCatalogo)

            if (stringHttpJson != "Server timeout connection" && stringHttpJson != ""){

                Json.decodeFromString<ArrayList<DatiLibro>>( stringHttpJson.toString())
            }else
                null

        }catch (e: Exception){
            null
        }
    }

    /**
     * Metodo getCopieDallId()
     * Viene utilizzato per richiedere le copie associate all'id copia richiesto; Se restituisce
     * null è che la connessione è fallita o non ci sono le copie.
     *
     * @param idCopia: String = La quale ha l'id delle copie richieste.
     * @return Oggetto DatiLibro (Non Null-Safety), il quale ha i dati del libro più le copie.
     */
    suspend fun getCopieDallId(idCopia: String): DatiLibro?{
        val stringHttpJson = getCopieLibroIdCopia(idCopia)

        return try {
            if (stringHttpJson != "Server timeout connection" && stringHttpJson != ""){
                val json = Json.parseToJsonElement(stringHttpJson ?: "")

                getDatiLibroDaIsbn(Json.decodeFromString<CopiaLibro>(json.toString()).isbn)
            }else
                null
        }catch (e: Exception){
            null
        }
    }

    /**
     * Metodo getDatiLibroDaIsbn()
     * Viene utilizzato per richiedere i dati del libro associato all'ISBN richiesto; Se restituisce
     * null è che la connessione è fallita o non c'è il libro.
     *
     * @param isbn: String = La quale ha l'ISBN del libro richeisto.
     * @return Oggetto DatiLibro (Non Null-Safety), il quale ha i dati del libro.
     */
    suspend fun getDatiLibroDaIsbn(isbn: String): DatiLibro?{
        val stringHttpJson = getLibroIsbn(isbn = isbn)

        return try {
            if (stringHttpJson != "Server timeout connection" && stringHttpJson != ""){
                val json = Json.parseToJsonElement(stringHttpJson ?: "")

                Json.decodeFromString<DatiLibro>(json.toString())
            }else
                null
        }catch (e: Exception){
            null
        }
    }

    //GET OGGETTO Libro CON DENTRO LE COPIE

    /**
     * Metodo getCopieLibroDaIsbn()
     * Viene utilizzato per richiedere le copie associate all'ISBN richiesto; Se restituisce
     * null è che la connessione è fallita o non ci sono più libri.
     *
     * @param isbn: String = La quale ha l'ISBN del libro che si stanno richiedendo le copie.
     * @return Oggetto Libro (Non Null-Safety), il quale ha il libro più le copie.
     */
    suspend fun getCopieLibroDaIsbn(isbn: String): Libro?{
        val stringHttpJson = getCopieLibri(isbn)

        return if (stringHttpJson != "Server timeout connection" && stringHttpJson != "" && stringHttpJson != "Isbn empty"){

            Json.decodeFromString<Libro>(stringHttpJson.toString())
        }else
            null
    }

    //GET OGGETTO Prestito

    /**
     * Metodo getPrestitiDellUtente()
     * Viene utilizzato per richiedere i prestiti associati all'utente; Se restituisce null è che
     * la connessione è fallita o non ha trovato i prestiti.
     *
     * @param utente: Utente = Il quale ha l'utente che sta utilizzando l'app.
     * @return L'ArrayList (Non Null-Safety), il quale ha i oggetti Prestito da visualizzare.
     */
    suspend fun getPrestitiDellUtente(utente: Utente): ArrayList<Prestito>?{
        val stringHttpJson = getPrestitiLibri(utente)

        return if (stringHttpJson != "Server timeout connection" && stringHttpJson != "" && stringHttpJson != "[]"){
            val json = Json.parseToJsonElement(stringHttpJson ?: "")

            Json.decodeFromString<ArrayList<Prestito>>(json.toString())
        }else
            null
    }

    //GET OGGETTO String CON LE ETICCHETTE

    /**
     * Metodo getCategorieLibro()
     * Viene utilizzato per richiedere le categorie associate all'id categoria richiesto; Se restituisce
     * null è che la connessione è fallita o non ci sono le categorie.
     *
     * @param listaIdCategoria: String = La quale ha l'id delle categorie richieste
     * @return L'ArrayList (Non Null-Safety), il quale ha le categorie da visualizzare.
     */
    suspend fun getCategorieLibro(listaIdCategoria: String): ArrayList<String>?{
        val stringHttpJson = getCategorieLibri(listaIdCategoria)

        return try {
            if (stringHttpJson != "Server timeout connection" && stringHttpJson != "" && stringHttpJson != "[]"){
                val json = Json.parseToJsonElement(stringHttpJson ?: "")

                Json.decodeFromString<ArrayList<String>>(json.toString())
            }else
                null
        }catch (e: Exception){
            null
        }
    }

    suspend fun getLibroApi(isbn: String): DatiLibro?{
        val stringHttpJson = getLibroIsbnApi(isbn)

        return try {
            if (stringHttpJson != "Server timeout connection" && stringHttpJson != "" && stringHttpJson != "[]"){
                val json = Json.parseToJsonElement(stringHttpJson ?: "")

                Json.decodeFromString<DatiLibro>(json.toString())
            }else
                null
        }catch (e: Exception){
            null
        }
    }

    suspend fun getLibroRicerca(ricercaTitoloLibro: String, ricercaCategorieLibro: ArrayList<String>, indiceCatalogo: String): ArrayList<DatiLibro>?{
        val hashMapRicerca = HashMap<String, String>()

        hashMapRicerca["titolo"] = ricercaTitoloLibro

        if (ricercaCategorieLibro.toString() != "[]") {
            hashMapRicerca["IDCategorie"] = ricercaCategorieLibro.toString()
        }

        return try {
            val stringHttpJson = getFiltroLibri(hashMapRicerca, indiceCatalogo)
            
            if (stringHttpJson != "Server timeout connection" && stringHttpJson != ""){

                Json.decodeFromString<ArrayList<DatiLibro>>( stringHttpJson.toString())
            }else
                null

        }catch (e: Exception){
            null
        }
    }

    suspend fun getUtenteEmail(email: String): Utente?{
        val stringHttpJson = getUtenteInstituzionale(email)

        return try {
            if (stringHttpJson != "Illegal operation on empty result set." && stringHttpJson != ""){
                val json = Json.parseToJsonElement(stringHttpJson ?: "")
                
                Json.decodeFromString<Utente>(json.toString())
            }else
                null

        }catch (e: Exception){
            null
        }
    }

    /*******************************/
    /******       POST        ******/
    /*******************************/

    //POST PER CARICARE I OGGETTI DatiLibro

    /**
     * Metodo postLibroServer()
     * Viene utilizzato per caricare un oggetto DatiLibro nel DB con una richiesta "Post" al server.
     */
    suspend fun postDatiLibro(libroDaCaricare: DatiLibro): String {
        //val prova = DatiLibro("1234", "prova", null, "prova", null, "prova", null, "1, 2", 1, null, 10, null)

        return try {
            val json = Json { prettyPrint = true }

            val jsonString = json.encodeToString(DatiLibro.serializer(), libroDaCaricare)

            postLibroJsonServer(jsonString).toString()
        }catch (e: Exception){
            "Failed Load" //Da prevenire nella grafica come messaggio di errore
        }
    }

    suspend fun postCopiaLibro(copiaDaCaricare: CopiaLibro): String {
        //val prova = DatiLibro("1234", "prova", null, "prova", null, "prova", null, "1, 2", 1, null, 10, null)

        return try {
            val json = Json { prettyPrint = true }

            val jsonString = json.encodeToString(CopiaLibro.serializer(), copiaDaCaricare)

            com.biblioteca.postCopiaLibro(jsonString).toString()
        }catch (e: Exception){
            "Failed Load" //Da prevenire nella grafica come messaggio di errore
        }
    }

    //POST PER CARICARE I OGGETTI Utente

    suspend fun postUtente(utenteDaCaricare: Utente): String {
        //val prova = DatiLibro("1234", "prova", null, "prova", null, "prova", null, "1, 2", 1, null, 10, null)

        return try {
            val json = Json { prettyPrint = true }

            val jsonString = json.encodeToString(Utente.serializer(), utenteDaCaricare)

            postUtenti(jsonString).toString()
        }catch (e: Exception){
            "Failed Load" //Da prevenire nella grafica come messaggio di errore
        }
    }

    /*******************************/
    /******      DELETE       ******/
    /*******************************/

    //DELETE PER CANCELLARE UNA SINGOLA COPIA

    /**
     * Metodo deleteSingolaCopia()
     * Viene utilizzato per eliminare la copia richiesta dall'utente.
     *
     * @param idCopia: String = La quale ha l'id della copia da cancellare.
     * @return String (Non Null-Safety), La quale ha l'esito dell'operazione
     */
    suspend fun deleteSingolaCopia(idCopia: String): String?{
        val stringHttpJson = deleteCopiaLibro(idCopia)

        return try {
            if (stringHttpJson != "Server timeout connection" && stringHttpJson != ""){
                val json = Json.parseToJsonElement(stringHttpJson ?: "")

                Json.decodeFromString(json.toString())
            }else
                null
        }catch (e: Exception){
            null
        }
    }
}