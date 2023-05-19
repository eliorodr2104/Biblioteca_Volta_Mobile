package com.biblioteca.OggettiComuni

import kotlinx.serialization.Serializable

/**
 * @author Elio0
 * data class persona
 *
 * @param idUtente: Int
 * @param nome: String
 * @param cognome: String
 * @param numero: String
 * @param mailAlternativa: String
 * @param grado: Int
 * @param mail: String = "$nome.$cognome@volta-alessandria.it"
 */
@Serializable
data class Utente(
    val idUtente: Int,
    val nome: String,
    val cognome: String,
    val numero: String?,
    val mailAlternativa: String,
    val grado: Int = 0,
    val mail: String = "$nome.$cognome@volta-alessandria.it",
    val preferiti: String?
)
