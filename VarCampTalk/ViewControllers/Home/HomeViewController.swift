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
        Task {
            let ids = (1 ... 7).map { $0 }
            var languages: [Int: String] = [:]
            
            try await withThrowingTaskGroup(of: (Int, String).self) { group in
                for id in ids {
                    group.addTask {
                        return (id, try await self.languageManager.fetchLanguage(of: id))
                    }
                }
                
                for try await (id, language) in group {
                    languages[id] = language
                }
                
                dump(languages)
            }
        }
    }

    

}

