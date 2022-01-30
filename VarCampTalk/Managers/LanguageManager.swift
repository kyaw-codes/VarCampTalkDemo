//
//  LanguageManager.swift
//  VarCampTalk
//
//  Created by Kyaw Zay Ya Lin Tun on 29/01/2022.
//

import Foundation

struct LanguageManager {
    
    static let shared = LanguageManager()
    
    enum LanguageManagerError: Error {
        case idNotFound
    }
    
    private let languages: [Int: String] = [
        1 : "Swift",
        2 : "Java",
        3 : "Kotlin",
        4 : "Objective C",
        5 : "JavaScript",
        6 : "Python",
        7 : "Go"
    ]
    
    func fetchLanguage(of id: Int) async throws -> String {
        let duration = Int.random(in: 1 ... 3)
        
        try await Task.sleep(seconds: duration)
        
        guard let language = languages[id] else {
            throw LanguageManagerError.idNotFound
        }
        
        return language
    }
    
    
    
}
