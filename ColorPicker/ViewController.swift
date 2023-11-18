//
//  ViewController.swift
//  ColorPicker
//
//  Created by Егор Аблогин on 17.11.2023.
//

import UIKit

final class ViewController: UIViewController {
    // MARK: - outlets
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redColorSlider: UISlider!
    @IBOutlet weak var greenColorSlider: UISlider!
    @IBOutlet weak var blueColorSlider: UISlider!
    
    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var blueValueLabel: UILabel!
    
    @IBOutlet weak var bottomStack: UIStackView!
    
    // MARK: - override
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 20
        bottomStack.layer.cornerRadius = 20
        
        setupSlider(redColorSlider, color: .red)
        setupSlider(greenColorSlider, color: .green)
        setupSlider(blueColorSlider, color: .blue)
    }
    
    // MARK: - actions
    @IBAction func sliderMoved(_ sender: UISlider) {
        changeViewColor()
        changeLabel(for: sender)
    }
    
    // MARK: - private methods
    private func changeViewColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redColorSlider.value),
            green: CGFloat(greenColorSlider.value),
            blue: CGFloat(blueColorSlider.value),
            alpha: 1
        )
    }
    
    private func setupSlider(_ slider: UISlider, color: UIColor) {
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 1
        slider.minimumTrackTintColor = color
        
        changeViewColor()
        changeLabel(for: slider)
    }
    
    private func changeLabel(for slider: UISlider) {
        let text = String(format: "%.2f", slider.value)
        
        switch slider.tag {
        case 0:
                redValueLabel.text = text
        case 1:
                greenValueLabel.text = text
        default:
                blueValueLabel.text = text
        }
    }
}

