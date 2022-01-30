//
//  KittyViewController.swift
//  VarCampTalk
//
//  Created by Kyaw Zay Ya Lin Tun on 30/01/2022.
//

import UIKit

class KittyViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var viewModel = KittyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showSpinner()
        viewModel.delegate = self
    }
    
    @IBAction func handleDownloadTapped(_ sender: UIBarButtonItem) {
        showSpinner()
        viewModel.downloadKittyPic()
    }
    
    private func showSpinner() {
        spinner.startAnimating()
        spinner.isHidden = false
    }
    
    private func hideSpinner() {
        spinner.stopAnimating()
        spinner.isHidden = true
    }
}

extension KittyViewController : KittyDelegate {
    
    func kittyViewController(recieve image: UIImage) {
        hideSpinner()
        imageView.image = image
    }
    
    func kittyViewController(recieve error: Error) {
        hideSpinner()
        showAlert()
    }
    
    private func showAlert() {
        let ac = UIAlertController(title: "Download Failed", message: "Failed to load kitty pic. Please try again", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        ac.addAction(okAction)
        present(ac, animated: true)
    }
    
}
