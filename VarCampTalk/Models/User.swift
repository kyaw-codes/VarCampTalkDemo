//
//  User.swift
//  VarCampTalk
//
//  Created by Kyaw Zay Ya Lin Tun on 29/01/2022.
//

import Foundation

struct User: Codable {
    let id: Int
    let name: String
    let email: String
    let phone: String
    let website: String
    let address: Address
    let company: Company
    
    struct Address: Codable {
        let street: String
        let suite: String
        let city: String
        let zipcode: String
    }
    
    struct Company: Codable {
        let name: String
        let catchPhrase: String
        let bs: String
    }
}
