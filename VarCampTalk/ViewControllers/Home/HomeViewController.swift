//
//  ViewController.swift
//  VarCampTalk
//
//  Created by Kyaw Zay Ya Lin Tun on 29/01/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    let networkManager = NetworkManager.shared
    let languageManager = LanguageManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Hello, welcome from VarCamp Talk!")
    }

}

