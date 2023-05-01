package com.biblioteca.OggettiComuni

import kotlinx.serialization.Serializable

/**
 * @author Elio0
 *
 * @param isbn: String
 * @param idCopia: String
 * @param condizioni: String
 * @param prestito: Prestito
 * @param sezione: String
 * @param scaffale: Int
 * @param ripiano: Int
 * @param np: Int
 * @param idPrestito: Int
 */
@Serializable
data class CopiaLibro(
    var idCopia: String,
    var isbn: String,
    var condizioni: String,
    var inPrestito: Boolean,
    val sezione: String,
    val scaffale: Int,
    val ripiano: Int,
    val np: Int,
    val idPrestito: Int,
)