package com.biblioteca

import kotlinx.serialization.Serializable

@Serializable
data class Persona (val nome: String,
    val cognome: String,
    val mail: String = "$nome.$cognome@volta-alessandria.it",
    val mailAlternativa: String,
    val numero: String?
)
