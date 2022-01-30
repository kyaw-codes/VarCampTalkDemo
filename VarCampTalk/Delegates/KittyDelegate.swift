//
//  KittyDelegate.swift
//  VarCampTalk
//
//  Created by Kyaw Zay Ya Lin Tun on 30/01/2022.
//

import UIKit

protocol KittyDelegate {
    
    func kittyViewController(recieve image: UIImage)
    func kittyViewController(recieve error: Error)
}
