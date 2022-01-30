//
//  KittyPresenter.swift
//  VarCampTalk
//
//  Created by Kyaw Zay Ya Lin Tun on 30/01/2022.
//

import Foundation
import UIKit

class KittyViewModel {
    
    private let networkManager = NetworkManager.shared
    
    typealias Continuation = CheckedContinuation<UIImage, Error>
    
    private var activeContinuation: Continuation?
    var delegate: KittyDelegate?
    
    func downloadKittyPic() {
        networkManager.downloadKittyImage { result in
            switch result {
            case .success(let image):
                self.delegate?.kittyViewController(recieve: image)
            case .failure(let err):
                self.delegate?.kittyViewController(recieve: err)
            }
        }
    }
    
    func kittyPic() async throws -> UIImage {
        return try await withCheckedThrowingContinuation({ [weak self] (continuation: Continuation) in
            self?.networkManager.downloadKittyImage({ result in
                self?.activeContinuation = continuation
                self?.downloadKittyPic()
            })
        })
    }
}
