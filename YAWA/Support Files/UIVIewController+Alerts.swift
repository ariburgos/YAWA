//
//  UIVIewController+Alerts.swift
//  YAWA
//
//  Created by Viajeros Lado B on 25/06/2019.
//  Copyright © 2019 DragonShine. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showMessageWithClose(title: String, message: String) {
        let closeAction = UIAlertAction(title: "Close", style: .cancel)
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(closeAction)
        present(alert, animated: true)
    }
    
    func showLoading() {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    func stopLoading(completion: (() -> Void)? = nil) {
        dismiss(animated: false, completion: completion)
    }
}
