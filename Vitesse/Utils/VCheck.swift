//
//  VitesseCheck.swift
//  Vitesse
//
//  Created by Yannick LEPLARD on 10/06/2024.
//

import Foundation

struct VCheck {
    // pour vérifier une adresse email
    // format : A@B.C avec A = [A-Z0-9a-z._+-] de longueur max. 64, B = [A-Za-z0-9.-], C = [A-Za-z]
    // !!! le format n'est pas exhaustif, d'autres caractère sont possibles pour A
    // aucun test n'est effectué sur la longueur de A, B et C
    // On pourrait utiliser la regex côté serveur (dans Email.swift), mais elle est trop stricte et doit être modifiée.
    static func validEmail(_ email: String) -> Bool {
        let regEx = "[A-Z0-9a-z._+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]+"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regEx)
        return predicate.evaluate(with: email)
    }
    
    // pour vérifier une numéro de téléphone français
    // format : 0AXXXXXXXX ou +33AXXXXXXXX,  avec A = 6 ou 7
    static func validFrenchPhoneNumber(_ phoneNumber: String) -> Bool {
        // longueur 10 [0-9], commence par 0, suivi de 6 ou 7
        let regExFr = "0[6-7][0-9]{8}"
        let predicateFr = NSPredicate(format:"SELF MATCHES %@", regExFr)
        // longueur 12, commence par +33, suivi de 6 ou 7, suivi de [0-9]
        let regExInter = "[+]33[6-7][0-9]{8}"
        let predicateInter = NSPredicate(format:"SELF MATCHES %@", regExInter)
        
        return (predicateFr.evaluate(with: phoneNumber) || predicateInter.evaluate(with: phoneNumber))
    }
    
    // pour vérifier une adresse linkedIn
    // format : commence par https://www.linkedin.com/in/
    static func validLinkedinURL(_ url: String) -> Bool {
        let regex = "^https://www\\.linkedin\\.com/in/[^\\s/]+/?$"
        //let regex = "^https:\\/\\/www\\.linkedin\\.com\\/in\\/[^\\s\\/]+\\/?$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: url)
    }
    
    // pour vérifier un nom
    // format : uniquement des lettres (et ^ assure que le champ commence par une lettre, $ qu'il finit par une lettre)
    static func validName(_ name: String) -> Bool {
        let regEx = "^[A-Za-z]+(-[A-Za-z]+)*$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regEx)
        return predicate.evaluate(with: name)
    }
}
