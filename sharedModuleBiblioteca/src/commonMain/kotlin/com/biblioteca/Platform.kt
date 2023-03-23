package com.biblioteca

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform