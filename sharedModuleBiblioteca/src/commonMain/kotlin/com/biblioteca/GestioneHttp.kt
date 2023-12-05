package com.biblioteca

import com.biblioteca.OggettiComuni.Utente

expect suspend fun getLibriCatalogo(indiceCatalogo: String): String?
expect suspend fun postLibroJsonServer(libro: String?): String?

expect suspend fun getPrestitiLibri(utentePrestito: Utente): String?

expect suspend fun getCopieLibri(isbn: String): String?

expect suspend fun getCategorieLibri(listaIdCategoria: String): String?

expect suspend fun getCategorie(): String?

expect suspend fun getGeneri(): String?

expect suspend fun getFiltroLibri(mappaRicerca: HashMap<String, String>, listaIdCategoria: String): String?

expect suspend fun deleteCopiaLibro(idCopia: String): String?

expect suspend fun getCopieLibroIdCopia(idCopia: String): String?

expect suspend fun getLibroIsbn(isbn: String): String?

expect suspend fun getLibroIsbnApi(isbn: String): String?

expect suspend fun getUtenteInstituzionale(email: String): String?

expect suspend fun postCopiaLibro(copiaLibro: String): String?

expect suspend fun postUtenti(utente: String): String?
