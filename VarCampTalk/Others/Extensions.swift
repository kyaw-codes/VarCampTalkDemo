//
//  Extensions.swift
//  VarCampTalk
//
//  Created by Kyaw Zay Ya Lin Tun on 29/01/2022.
//

import Foundation

extension Task where Success == Never, Failure == Never {
    
    public static func sleep(seconds duration: Int) async throws {
        try await Task.sleep(nanoseconds: UInt64(duration * 1_000_000_000))
    }
}
