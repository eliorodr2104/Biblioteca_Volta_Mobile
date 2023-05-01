package com.biblioteca.GestioneServer

import com.biblioteca.OggettiComuni.DatiLibro
import com.biblioteca.OggettiComuni.Libro
import com.biblioteca.OggettiComuni.Prestito
import com.biblioteca.OggettiComuni.Utente
import com.biblioteca.getCopieLibri
import com.biblioteca.postLibroJsonServer
import com.biblioteca.getJsonLibro
import com.biblioteca.getPrestitiLibri
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.jsonObject


class GestioneJson {
    suspend fun postLibroServer(libroAdAggiungere: Libro): String {
        val json = Json { prettyPrint = true }

        val jsonString = json.encodeToString(Libro.serializer(), libroAdAggiungere)

        return postLibroJsonServer(jsonString).toString()
    }

    suspend fun getTuttiLibri(): ArrayList<DatiLibro>? {
        val stringHttpJson = getJsonLibro()

        return if (stringHttpJson != "Server timeout connection" && stringHttpJson != ""){

            val json = Json.parseToJsonElement(getJsonLibro() ?: "")

            Json.decodeFromString(json.toString())
        }else
            null
    }

    suspend fun getTuttiPrestito(utente: Utente): ArrayList<Prestito>?{
        val stringHttpJson = getPrestitiLibri(utente)

        return if (stringHttpJson != "Server timeout connection" && stringHttpJson != ""){

            val json = Json.parseToJsonElement(getJsonLibro() ?: "")

            Json.decodeFromString(json.toString())
        }else
            null
    }

    suspend fun getCopieLibro(isbn: String): Libro?{
        val stringHttpJson = getCopieLibri(isbn)
        
        return if (stringHttpJson != "Server timeout connection" && stringHttpJson != "" && stringHttpJson != "Isbn empty"){

            Json.decodeFromString<Libro>(stringHttpJson.toString())
        }else
            null
    }
}