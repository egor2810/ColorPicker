//
//  Extensions.swift
//  ColorPicker
//
//  Created by Егор Аблогин on 07.12.2023.
//

import UIKit

extension UIView {
    func addVerticalGradient(colors: [UIColor]) {
        let gradient = CAGradientLayer()
        
        gradient.frame = bounds
        gradient.colors = colors.map{$0.cgColor}
        gradient.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 0.0)
        layer.insertSublayer(gradient, at: 0)
    }
}

extension UIColor {
    var redValue: CGFloat{ CIColor(color: self).red }
    var greenValue: CGFloat{ CIColor(color: self).green }
    var blueValue: CGFloat{ CIColor(color: self).blue }
}


extension CGFloat {
    var floated: Float {
        Float(self)
    }
}

extension String? {
    func commaToDot() -> String? {
        self?.replacingOccurrences(of: ",", with: ".")
    }
}



extension UIViewController {
    func showAlert (
        withTitle title: String,
        andMessage message: String
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
}
 


