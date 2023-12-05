//
//  HttpManager.swift
//  Biblioteca
//
//  Created by eliomar rodriguez on 18/09/23.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import SwiftUI

import sharedModuleBiblioteca


class HttpManager: ObservableObject {
    @Published var libro: Libro?
    
    @Published var arrayCategorie = NSMutableArray()
    @Published var arrayGeneri = NSMutableArray()
    @Published var arrayPrestiti = NSMutableArray()
    
    @Published var nPagCatalogo = 0
    @Published var nPagRicerca = 0
    
    @Published var arrayLibri = NSMutableArray()
    @Published var arrayLibriRicerca = NSMutableArray()
    
    @Published var esito = ""
    
    @Published var datiLibro = DatiLibro(isbn: "", titolo: "", sottotitolo: nil, lingua: "", casaEditrice: nil, autore: "", annoPubblicazione: nil, idCategorie: "", idGenere: 0, descrizione: nil, np: 0, image: nil)
    
    @Published var utente = Utente(idUtente: 0, nome: "", cognome: "", numero: nil, mailAlternativa: "", grado: 0, mail: "", preferiti: nil)
    
    func getCopieLibroDatoIsbn(isbn: String){
        GestioneJson().getCopieLibroDaIsbn(isbn: isbn) { libro, error in
            DispatchQueue.main.async {
                if let libro = libro {
                    self.libro = libro
                    
                } else {
                    print(error?.localizedDescription ?? "Errore ad ottenre copie libro: " + error.debugDescription)
                }
            }
        }
        
    }
    
    func getCategorieDelLibro(listaIdCategoria: String){
        GestioneJson().getCategorieLibro(listaIdCategoria: listaIdCategoria) { arrayCategorie, error in
            DispatchQueue.main.async {
                if let arrayCategorie = arrayCategorie {
                    self.arrayCategorie = arrayCategorie
                    
                } else {
                    print(error?.localizedDescription ?? "Errore ad ottenere le categorie del libro: " + error.debugDescription)
                }
            }
        }
    }
    
    func getTutteCategorie(){
        GestioneJson().getCategorieTotali() { arrayCategorie, error in
            DispatchQueue.main.async {
                if let arrayCategorie = arrayCategorie {                    
                    self.arrayCategorie = arrayCategorie
                    
                } else {
                    print(error?.localizedDescription ?? "Errore ad ottenere le categorie del libro: " + error.debugDescription)
                }
            }
        }
    }
    
    func getTuttiGeneri(){
        GestioneJson().getGeneriTotali() { arrayGeneri, error in
            DispatchQueue.main.async {
                if let arrayGeneri = arrayGeneri {
                    self.arrayGeneri = arrayGeneri
                    
                } else {
                    print(error?.localizedDescription ?? "Errore ad ottenere le categorie del libro: " + error.debugDescription)
                }
            }
        }
    }
    
    func updateDataLibriCatalogo(){
        GestioneJson().getPezziDelCatalogo(indiceCatalogo: String(nPagCatalogo)) { connessione, error in
            DispatchQueue.main.async {
                if let connessione = connessione {
                    if self.nPagCatalogo == 0{
                        self.arrayLibri = connessione
                        
                    }else{
                        self.arrayLibri.addObjects(from: connessione as! [Any])
                    }
                    
                    self.nPagCatalogo += 1
                } else {
                    print(error?.localizedDescription ?? "Errore ad aggiornare la lista dei libri: " + error.debugDescription)
                }
            }
        }
    }
    
    func refreshLibriCatalogo(){
        GestioneJson().getPezziDelCatalogo(indiceCatalogo: String(nPagCatalogo)) { connessione, error in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5 ) {
                if let connessione = connessione {
                    if self.nPagCatalogo == 0{
                        
                        withAnimation {
                            self.arrayLibri = connessione
                        }
                        
                    }else{
                        withAnimation {
                            self.arrayLibri.addObjects(from: connessione as! [Any])
                        }
                    }
                    
                    self.nPagCatalogo += 1
                } else {
                    print(error?.localizedDescription ?? "Errore ad aggiornare la lista dei libri: " + error.debugDescription)
                }
            }
        }
    }
    
    func getLibroIsbn(isbn: String){
        GestioneJson().getLibroApi(isbn: isbn) { datiLibro, errore in
            DispatchQueue.main.async {
                if let datiLibro = datiLibro{
                    self.datiLibro = datiLibro
                                                                                
                }else{
                    print(errore?.localizedDescription ?? "Errore ad ottenere il libro dall'API: " + errore.debugDescription)
                }
            }
        }
    }
    
    func deleteCopia(idCopiaDelete: String){
        GestioneJson().deleteSingolaCopia(idCopia: idCopiaDelete) { esitoDelete, errore in
            DispatchQueue.main.async {
                if let esitoDelete = esitoDelete{
                    self.esito = esitoDelete
                    
                }else{
                    print(errore?.localizedDescription ?? "Errore a cancellare la copia: " + errore.debugDescription)
                }
            }
        }
    }
    
    func postCopiaLibro(copiaDelLibro: CopiaLibro){
        GestioneJson().postCopiaLibro(copiaDaCaricare: copiaDelLibro) { risultato, error in
            DispatchQueue.main.async {
                if let risultato = risultato {
                    self.esito = risultato
                    
                } else {
                    print(error?.localizedDescription ?? "Errore al caricare la copia del libro: " + error.debugDescription)
                }
            }
        }
    }
    
    func postLibro(datiLibrolibro: DatiLibro){
        GestioneJson().postDatiLibro(libroDaCaricare: datiLibrolibro) { risultato, error in
            DispatchQueue.main.async {
                if let risultato = risultato {
                    self.esito = risultato
                    
                } else {
                    print(error?.localizedDescription ?? "Errore al caricare la copia del libro: " + error.debugDescription)
                }
            }
        }
    }
    
    func getCopieDaIdCopia(idCopia: String){
        GestioneJson().getCopieDallId(idCopia: idCopia){ libro, errore in
            DispatchQueue.main.async() {
                if let libro = libro {
                    self.datiLibro = libro
                    
                }else {
                    print(errore?.localizedDescription ?? "Errore ad ottenere la copia dall'ID: " + errore.debugDescription)
                }
            }
            
        }
    }
    
    func getUtenteDaEmail(email: String){
        GestioneJson().getUtenteEmail(email: email) { risultato, error in
            DispatchQueue.main.async() {
                if let risultato = risultato {
                    self.utente = risultato
                             
                } else {
                    print(error?.localizedDescription ?? "Errore ad ottenere l'utente dalla email: " + error.debugDescription)
                }
            }
        }
    }
    
    func postUtente(utente: Utente){
        GestioneJson().postUtente(utenteDaCaricare: utente) { risultato, error in
            DispatchQueue.main.async() {
                if let risultato = risultato {
                    self.esito = risultato
                             
                } else {
                    print(error?.localizedDescription ?? "Errore al caricare l'utente: " + error.debugDescription)
                }
            }
        }
    }
    
    func getPrestitiUtente(utente: Utente){
        GestioneJson().getPrestitiDellUtente(utente: utente){ prestito, errore in
            DispatchQueue.main.async {
                if let prestito = prestito {
                    self.arrayPrestiti = prestito
                    
                }else {
                    print(errore?.localizedDescription ?? "Errore al prendere i prestiti dell'utente: " + errore.debugDescription)
                }
            }
            
        }
    }
    
    func searchData(searchText: String){
        GestioneJson().getLibroRicerca(ricercaTitoloLibro: searchText, ricercaCategorieLibro: NSMutableArray(object: "") ,indiceCatalogo: String(nPagRicerca)) { esitoLibri, errore in
            
            DispatchQueue.main.async {
                if let esitoLibri = esitoLibri {
                    
                    if self.nPagRicerca == 0{
                        self.arrayLibriRicerca = esitoLibri
                        
                    }else{
                        self.arrayLibriRicerca.addObjects(from: esitoLibri as! [Any])
                    }
                                        
                    self.nPagRicerca += 1
                } else {
                    print(errore?.localizedDescription ?? "Errore nel salvare le categorie: " + errore.debugDescription)
                }
            }
        }
    }
    
    func resetDataCatalogo() {
        nPagCatalogo = 0
        arrayLibri = NSMutableArray()
    }
}
