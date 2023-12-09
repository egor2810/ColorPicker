//
//  MainScreenViewController.swift
//  ColorPicker
//
//  Created by Егор Аблогин on 07.12.2023.
//

import UIKit

protocol EditingViewControllerDelegate: AnyObject {
    func setBackgroundColorToScreen(from color: UIColor)
}

class MainScreenViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let editingVC = segue.destination as? EditingViewController
        
        editingVC?.delegate = self
        editingVC?.mainBackgroundColor = view.backgroundColor
    }

}

extension MainScreenViewController: EditingViewControllerDelegate {
    func setBackgroundColorToScreen(from color: UIColor) {
        view.backgroundColor = color
    }
}
