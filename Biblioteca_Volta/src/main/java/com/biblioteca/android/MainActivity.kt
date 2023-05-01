package com.biblioteca.android

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.animation.AnimatedVisibility
import androidx.compose.animation.core.FastOutSlowInEasing
import androidx.compose.animation.core.LinearOutSlowInEasing
import androidx.compose.animation.core.animateDpAsState
import androidx.compose.animation.core.animateFloatAsState
import androidx.compose.animation.core.tween
import androidx.compose.animation.fadeIn
import androidx.compose.animation.fadeOut
import androidx.compose.animation.slideIn
import androidx.compose.animation.slideOut
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.offset
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.Button
import androidx.compose.material.Divider
import androidx.compose.material.Icon
import androidx.compose.material.IconButton
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Surface
import androidx.compose.material.Text
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.ArrowBack
import androidx.compose.material.icons.filled.Close
import androidx.compose.material.icons.filled.Menu
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.rotate
import androidx.compose.ui.draw.scale
import androidx.compose.ui.draw.shadow
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.graphicsLayer
import androidx.compose.ui.platform.LocalConfiguration
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.IntOffset
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.biblioteca.GestioneServer.GestioneJson
import kotlinx.coroutines.launch

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            MyApplicationTheme {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colors.background
                ) {
                    MenuSplit(nomeUtente = "Prova", salutoUtente = "Utente")

                }
            }
        }
    }
}

@Composable
fun GreetingView(text: String) {
    Text(
        text = text,
        fontSize = 50.sp
    )
}

@Preview
@Composable
fun DefaultPreview() {
    MyApplicationTheme {
        GreetingView("Ciao, Android!")
    }
}

@Composable
fun MenuSplit(
    nomeUtente: String,
    salutoUtente: String
){
    val CONST_INDEX_LIBRI = 5

    var index by remember { mutableStateOf(0) }
    var show by remember { mutableStateOf(false) }
    var showAnimationSecondary by remember { mutableStateOf(false) }

    val scale: Float by animateFloatAsState(if (show) 0.9f else 1f)

    val xTranslation: Dp by animateDpAsState(
        if (show) (LocalConfiguration.current.screenWidthDp / 2).dp else 0.dp
    )

    val rotation: Float by animateFloatAsState(if (show) -5f else 0f)

    val elevation: Dp by animateDpAsState(if (show) 5.dp else 0.dp)

    var datiLibro by remember { mutableStateOf<MenuLibro?>(null) }

    val scope = rememberCoroutineScope()
    var text by remember { mutableStateOf("Loading") }

    /*
    LaunchedEffect(true) {
        scope.launch {
            text = try {
                GestioneJson().provaConnessione()
            } catch (e: Exception) {
                e.localizedMessage ?: "error"
            }
        }
    }

     */

    Box(
        contentAlignment = Alignment.CenterStart,
        modifier = Modifier.fillMaxSize()
    ){
        // Menù per la scelta dell'utente dentro l'app, il quale viene visualizzato con un'animazione;
        // questa viene controllata dalla variabile di stato "showAnimationSecondary", la quale quando viene modificata aggiorna la grafica
        // del programma inizialize, così mostrando i pulsanti di scelta.
        Row(){
            Column(
                verticalArrangement = Arrangement.Top,
                modifier = Modifier.padding(top = 10.dp, start = 10.dp)
            ){
                // Immagine Profilo da mettere quando avrò l'icona del profilo
                // Image(systemName: "xmark")

                Text(
                    text = salutoUtente,
                    fontWeight = FontWeight.Bold,
                    fontSize = 24.sp,
                    color = Color.Black
                )

                Text(
                    text = nomeUtente,
                    fontWeight = FontWeight.Bold,
                    fontSize = 24.sp,
                    color = Color.Black
                )

                // Pulsante per la visualizzazione del catalogo
                Button(
                    onClick = {
                        // Indice di riconoscimento azione
                        index = 0

                        // Fa lo switch della variabile di stato "show"
                        show = !show

                        scope.launch {
                            text = try {
                                ""
                                //GestioneJson().provaConnessione()
                            } catch (e: Exception) {
                                e.localizedMessage ?: "error"
                            }
                        }

                    },
                    modifier = Modifier
                        .padding(top = 10.dp)
                        .size(width = 150.dp, height = 50.dp)
                        .background(if (index == 0) Color.Gray.copy(alpha = 0.6f) else Color.Transparent)
                        .clip(RoundedCornerShape(10.dp))
                ) {
                    Row(
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        /*
                        Image(
                            painter = painterResource(0),
                            contentDescription = "Catalogo",
                            colorFilter = ColorFilter.tint(if (index == 0) Color.Blue else Color.Black)
                        )

                         */

                        Text(
                            text = "Catalogo",
                            fontSize = 17.sp,
                            color = if (index == 0) Color.Blue else Color.Black,
                        )
                    }
                }
                
                Text(text = text)

                // Pulsante per la visualizzazione dei libri che sono in prestito
                Button(
                    onClick = {
                        // Indice di riconoscimento azione
                        index = 1

                        // Fa lo switch della variabile di stato "show"
                        show = !show
                    },
                    modifier = Modifier
                        .padding(top = 10.dp)
                        .size(width = 150.dp, height = 50.dp)
                        .background(if (index == 1) Color.Gray.copy(alpha = 0.6f) else Color.Transparent)
                        .clip(RoundedCornerShape(10.dp))
                ) {
                    Row(
                        verticalAlignment = Alignment.CenterVertically

                    ) {
                        /*
                        Image(
                            painter = painterResource(0),
                            contentDescription = "Libri Prestito",
                        )
                         */

                        Text(
                            text = "Libro prestito",
                            fontSize = 17.sp,
                            color = if (index == 1) Color.Blue else Color.Black
                        )
                    }
                }

                //Pulsante per la visualizzazione delle informazioni dell'utente
                Button(
                    onClick = {
                        // Indice di riconoscimento azione
                        index = 2

                        // Fa lo switch della variabile di stato "show"
                        show = !show
                    },
                    modifier = Modifier
                        .padding(top = 10.dp)
                        .size(width = 150.dp, height = 50.dp)
                        .background(if (index == 3) Color.Gray.copy(alpha = 0.6f) else Color.Transparent)
                        .clip(RoundedCornerShape(10.dp))
                ) {
                    Row(
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        /*
                        Image(
                            painter = painterResource(0),
                            contentDescription = "Informazioni dell'utente",
                        )

                         */

                        Text(
                            text = "Informazioni dell'utente",
                            fontSize = 18.sp,
                            color = if (index == 2) Color.Blue else Color.Black,
                        )
                    }
                }

                //Pulsante per la visualizzazione delle notifiche nell'app
                Button(
                    onClick = {
                        // Indice di riconoscimento azione
                        index = 3

                        // Fa lo switch della variabile di stato "show"
                        show = !show
                    },
                    modifier = Modifier
                        .padding(top = 10.dp)
                        .size(width = 150.dp, height = 50.dp)
                        .background(if (index == 3) Color.Gray.copy(alpha = 0.6f) else Color.Transparent)
                        .clip(RoundedCornerShape(10.dp))
                ) {
                    Row(
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        /*
                        Image(
                            painter = painterResource(0),
                            contentDescription = "notifiche app",
                        )

                         */

                        Text(
                            text = "Notifiche app",
                            fontSize = 18.sp,
                            color = if (index == 3) Color.Blue else Color.Black,
                        )
                    }
                }

                Divider(
                    color = Color.White,
                    thickness = 1.dp,
                    modifier = Modifier
                        .width(150.dp)
                        .height(1.dp)
                        .background(Color.White)
                        .padding(vertical = 30.dp)
                )

                Button(
                    onClick = {
                        //Indice di riconoscimento azione
                        index = 4

                        //Fa lo switch della variabile di stato "show"
                        show = !show
                    },
                    modifier = Modifier
                        .padding(vertical = 10.dp, horizontal = 16.dp)
                        .background(if (index == 4) Color(0xFF007AFF).copy(alpha = 0.2f) else Color.Transparent)
                        .clip(RoundedCornerShape(10.dp))

                ) {
                    Row(verticalAlignment = Alignment.CenterVertically) {
                        /*
                        Image(
                            painter = painterResource(id = R.drawable.impostazioni),
                            contentDescription = "Impostazioni",
                            modifier = Modifier
                                .size(24.dp)
                                .padding(end = 25.dp)
                        )

                         */
                        Text(
                            text = "Impostazioni",
                            style = MaterialTheme.typography.body1.copy(color = MaterialTheme.colors.onBackground)
                        )
                    }
                }
            }
            Spacer(modifier = Modifier.height(0.dp))
        }

        Column(
            modifier = Modifier
                .fillMaxSize()
                //.padding(top = LocalDensity.current.density.dp)
                .background(if (!show) Color.White else Color.Transparent)

                .clip(RoundedCornerShape(if (show) 30.dp else 0.dp))
                .scale(scale)
                .offset(x = xTranslation, y = if (show) 15.dp else 0.dp)
                .rotate(rotation)
                .shadow(
                    elevation = elevation,
                    shape = RoundedCornerShape(if (show) 30.dp else 0.dp)
                )

            /*
            // Restringimento e spostamento della vista a destra quando si fa clic sul pulsante del menu
            .scale(if (show) 0.9f else 1f)
            .offset(
                x = if (show) (LocalConfiguration.current.screenWidthDp.dp / 2) else 0.dp,
                y = if (show) 15.dp else 0.dp
            )
            // Rotazione
            .rotate(if (show) -5f else 0f)
            .shadow(
                elevation = if (show) 5.dp else 0.dp,
                shape = RoundedCornerShape(if (show) 30.dp else 0.dp),
            )

             */
        ) {
            Row(
                modifier = Modifier
                    .padding(horizontal = 16.dp, vertical = 8.dp)
                    .fillMaxWidth()
            ) {
                IconButton(onClick = {
                    if (!showAnimationSecondary) {
                        show = !show
                    } else {
                        index = 0
                        showAnimationSecondary = false
                    }
                }) {
                    Icon(
                        imageVector = if (!showAnimationSecondary) {
                            if (show) Icons.Default.Close else Icons.Default.Menu
                        } else {
                            if (showAnimationSecondary) Icons.Default.ArrowBack else Icons.Default.Menu
                        },
                        contentDescription = null,
                        tint = Color.Gray.copy(alpha = 0.4f),
                        modifier = Modifier.size(if (showAnimationSecondary) 18.dp else 22.dp)
                    )
                }

                Text(
                    text = when (index) {
                        0 -> "Catalogo"
                        1 -> "Libri Prestito"
                        2 -> "Informazioni"
                        3 -> "Notifiche App"
                        4 -> "Impostazioni"
                        else -> "Dati Libro"
                    },
                    fontSize = 20.sp,
                    color = Color.Gray.copy(alpha = 0.6f),
                    modifier = Modifier
                        .weight(1f)
                        .padding(10.dp)
                )
            }

            Box(
                modifier = Modifier
                    .weight(1f)
                    .padding(horizontal = 16.dp)
            ) {
                /*
                when (index) {
                    0 -> ListaVisualizzazione(tempArrayItemVisualizzazione, enabled = !show)
                    1 -> MenuPrestiti(inizializzareArrayPrestiti())
                    4 -> {
                        MenuLibro(
                            viewModel = MenuLibroViewModel(),
                            titolo = datiLibro?.titolo,
                            descrizione = datiLibro?.descrizione,
                            lingua = datiLibro?.lingua ?: "",
                            disponibilitaLibro = datiLibro?.disponibilitaLibro ?: ""
                        )
                            .background(Color.White)
                            .offset(
                                x = if (showAnimationSecondary) 0.dp else LocalConfiguration.current.screenWidthDp.dp,
                                y = 0.dp
                            )
                            .animateContentSize(
                                animationSpec = tween(
                                    durationMillis = 500,
                                    dampingRatio = 0.7f,
                                    delayMillis = 0
                                )
                            )
                    }
                    else -> Unit
                }

                 */
            }

            Spacer(modifier = Modifier.height(16.dp))
        }
    }
}

/**
@Composable
fun MenuSplit(
    nomeUtente: String,
    salutoUtente: String
) {
    val CONST_INDEX_LIBRI = 5

    var index by remember { mutableStateOf(0) }
    var show by remember { mutableStateOf(false) }
    var showAnimationSecondary by remember { mutableStateOf(false) }
    var datiLibro by remember { mutableStateOf<MenuLibro?>(null) }

    Box(
        contentAlignment = Alignment.CenterStart,
        modifier = Modifier.fillMaxSize()
    ) {
        // Menù per la scelta dell'utente dentro l'app, il quale viene visualizzato con un'animazione;
        // questa viene controllata dalla variabile di stato "showAnimationSecondary", la quale quando viene modificata aggiorna la grafica
        // del programma inizialize, così mostrando i pulsanti di scelta.
        Row(verticalAlignment = Alignment.CenterVertically) {
            Column(
                verticalArrangement = Arrangement.Top,
                modifier = Modifier.padding(top = 10.dp, start = 10.dp)
            ) {
                // Immagine Profilo da mettere quando avrò l'icona del profilo
                // Image(systemName: "xmark")

                Text(
                    text = salutoUtente,
                    fontWeight = FontWeight.Bold,
                    fontSize = 24.sp,
                    color = Color.Black
                )

                Text(
                    text = nomeUtente,
                    fontWeight = FontWeight.Bold,
                    fontSize = 24.sp,
                    color = Color.Black
                )

                // Pulsante per la visualizzazione del catalogo
                Button(
                    onClick = {
                        // Indice di riconoscimento azione
                        index = 0

                        // Fa lo switch della variabile di stato "show"
                        showAnimationSecondary = !showAnimationSecondary
                    },
                    modifier = Modifier.padding(top = 25.dp)
                ) {
                    Row(
                        verticalAlignment = Alignment.CenterVertically,
                        modifier = Modifier.padding(vertical = 10.dp, horizontal = 10.dp)
                            .background(if (index == 0) Color.Gray.copy(alpha = 0.2f) else Color.Transparent)
                            .clip(RoundedCornerShape(10.dp))
                    ) {
                        Image(
                            painter = painterResource(null),
                            contentDescription = "Catalogo",
                            colorFilter = ColorFilter.tint(if (index == 0) Color.Blue else Color.Black)
                        )

                        Text(
                            text = "Catalogo",
                            fontSize = 18.sp,
                            color = if (index == 0) Color.Blue else Color.Black,
                            modifier = Modifier.padding(start = 25.dp)
                        )
                    }
                }

                // Pulsante per la visualizzazione dei libri che sono in prestito
                Button(
                    onClick = {
                        // Indice di riconoscimento azione
                        index = 1

                        // Fa lo switch della variabile di stato "show"
                        showAnimationSecondary = !showAnimationSecondary
                    },
                    modifier = Modifier.padding(top = 10.dp)
                ) {
                    Row(
                        verticalAlignment = Alignment.CenterVertically,
                        modifier = Modifier.padding(vertical = 10.dp, horizontal = 10.dp)
                            .background(if (index == 1) Color.Gray.copy(alpha = 0.2f) else Color.Transparent)
                            .clip(RoundedCornerShape(10.dp))
                    ) {
                        Image(
                            painter = painterResource("libri prestito"),
                            contentDescription = "Libri Prestito",
                    }
                }
            }

        }
    }
}
 */
