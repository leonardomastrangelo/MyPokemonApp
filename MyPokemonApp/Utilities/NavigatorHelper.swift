//
//  NavigatorHelper.swift
//  MyPokemonApp

import UIKit

extension UIViewController  {
    func updateBackButtonTitle() {
        let backButtonTitle = "Back".translated()
        let backItem = UIBarButtonItem(title: backButtonTitle, style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backItem
    }
}

// done
// interceptors - event Monitor
// refactory grapichs with more details + custom Pixel Font
// lightmode - darkmode
// table view section 3
// section 0 - 1 row
// section 1 - 1 row
// section 2 - row 5
// togliere uiView contenitore dalle image view nella datailPage
// normalizzare formati tableView details
// _ nelle localizable string

// todo
// scheda allenatore
// splashScreen con pokeball + mia pagina caricamento di dati
// aggiornare in modalità landscape

// priority
// logic changing languages

