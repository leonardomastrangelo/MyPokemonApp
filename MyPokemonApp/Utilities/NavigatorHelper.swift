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

// tableView o scroll view nella pagina di dettaglio -> buoysel image
// pagina di dettaglio in verticale con più dati
// immagine nel dettaglio page

// mode -> automatico light dark - lingua -> lingue suppportate


// scheda allenatore
// splashScreen con pokeball
