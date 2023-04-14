package com.biblioteca

import io.ktor.client.*
import io.ktor.client.request.*


class GestioneJson {
    private val client = HttpClient()

    suspend fun provaConnessione(): String {
        val response = client.get("http://192.168.20.228/phpmyadmin")
        return response.status.toString()
    }
}