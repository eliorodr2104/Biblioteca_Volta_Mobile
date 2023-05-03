package com.biblioteca

import com.biblioteca.OggettiComuni.Utente

expect suspend fun getJsonLibro(): String?
expect suspend fun postLibroJsonServer(libro: String?): String?

expect suspend fun getPrestitiLibri(utentePrestito: Utente): String?

expect suspend fun getCopieLibri(isbn: String): String?

expect suspend fun getCategorieLibri(listaIdCategoria: ArrayList<Int>): String?
