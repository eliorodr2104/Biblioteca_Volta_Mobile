package com.biblioteca.ImplementazioneGrafica

import com.biblioteca.Platform
import com.biblioteca.getPlatform

class Greeting {
    private val platform: Platform = getPlatform()

    fun greet(): String {

        return "Hello, ${platform.name}!"
    }
}