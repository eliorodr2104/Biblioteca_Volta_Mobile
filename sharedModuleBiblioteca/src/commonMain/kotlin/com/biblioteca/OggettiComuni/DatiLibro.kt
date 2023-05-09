package com.biblioteca.OggettiComuni
import kotlinx.serialization.Serializable

/**
 * @author C4V4.exe
 * @author Elio0
 *
 * Data class DatiLibro
 * @param isbn: String
 * @param titolo: String
 * @param sottotitolo: String
 * @param lingua: String
 * @param casaEditrice: String
 * @param idAutore: String
 * @param annoPubblicazione: String
 * @param idCategoria: String
 * @param idGenere: String
 * @param descrizione: String
 */
@Serializable
data class DatiLibro(
    val isbn: String,
    val titolo: String,
    val sottotitolo: String?,
    val lingua: String,
    val casaEditrice: String?,
    val autore: String,
    val annoPubblicazione: String?,
    val idCategorie:  ArrayList<Int>,
    val idGenere: Int,
    val descrizione: String?,
    val np: Int,
    val image: String?
)