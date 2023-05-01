package com.biblioteca.OggettiComuni

import kotlinx.serialization.Serializable

/**
 * @author Elio0
 * @author Ermanno Oliveri
 * @author C4V4H.exe
 *
 * @param idPrestito: Int
 * @param idCopia: Int
 * @param idUtente: Int
 * @param dataFine: String
 * @param dataInizio: String
 * @param condizioneFinale: String
 * @param condizioneIniziale: String
 */
@Serializable
data class Prestito(
    val idPrestito: Int,
    val idCopia: Int,
    val idUtente: Int,
    val dataFine: String?,
    val dataInizio: String?,
    val condizioneIniziale: String?,
    val condizioneFinale: String?)