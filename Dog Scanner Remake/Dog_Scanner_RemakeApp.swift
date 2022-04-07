//
//  Dog_Scanner_RemakeApp.swift
//  Dog Scanner Remake
//
//  Created by Antonio Scognamiglio on 14/12/21.
//

import SwiftUI

@main
struct Dog_Scanner_RemakeApp: App {
    @StateObject var dogStore = DogStore()
    @State private var image: UIImage?
    /* questa dichiarazione è sempre un po' ambigua da fare per me, per il semplice fatto che avere troppe cose con lo stesso nome
     mi manda al manicomio, alla fine ho crato un oggetto chiamato dogStore perché verrà popolato con DogStore, che sarebbe la classe che abbiamo nel nostro model, dove ci sta un array che contiene oggetti di tipo cane, già inizializzato tra l'altro quindi, ci siamo pure risparmiati l'init, qui abbiamo creato un oggetto di quella classe e l'abbiamo inizializzata con gli stessi valori che ci sono al suo interno, adesso questo oggetto lo porteremo in tutte le view, grazie a @Environment Object  */
    var body: some Scene {
        WindowGroup {
            TabBarView().environmentObject(dogStore) //qui stiamo dicendo vedi cge l'oggetto che ho creato è environment, nelle prossime view lo richiamo tieniti pronto a darmelo
//            ContentView().environmentObject(dogStore)
        }
    }
}
