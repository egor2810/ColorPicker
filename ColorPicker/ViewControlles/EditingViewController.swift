//
//  ViewController.swift
//  ColorPicker
//
//  Created by Егор Аблогин on 17.11.2023.
//

import UIKit

final class EditingViewController: UIViewController {
    // MARK: - outlets
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet var colorValueLabel: [UILabel]!
    
    @IBOutlet var colorSliders: [UISlider]!
    
    @IBOutlet var colorValueTextFields: [UITextField]!
   
    private let colorsTags = [UIColor.red, UIColor.green, UIColor.blue]
    
    weak var delegate: EditingViewControllerDelegate?
    
    var mainBackgroundColor: UIColor!
    
    lazy var toolBar: UIToolbar = {
        let tool: UIToolbar = .init(
            frame: .init(
                x: 0,
                y: 0,
                width: UIScreen.main.bounds.width,
                height: 35
            )
        )
        
        tool.barStyle = .default
        tool.isTranslucent = false
        tool.tintColor = .blue
        tool.sizeToFit()
        
        let spaceArea: UIBarButtonItem = .init(systemItem: .flexibleSpace)
        let doneButton: UIBarButtonItem = .init(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(doneButtonPressed(sender:))
        )
        tool.setItems([spaceArea, doneButton], animated: false)
        tool.isUserInteractionEnabled = true
        
        return tool
    }()
    
    // MARK: - override
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 20
        
        colorValueTextFields.forEach {
            $0.delegate = self
            $0.inputAccessoryView = toolBar
        }
        
        colorSliders.forEach {
            setupSlider( $0, color: colorsTags[$0.tag])
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        view.endEditing(true)
    }
    
    // MARK: - actions
    @IBAction func sliderMoved(_ sender: UISlider) {
        updateUI(sender)
    }
    
    @IBAction func saveAction() {
        delegate?.setBackgroundColorToScreen(from: mainBackgroundColor)
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - private methods
    private func updateUI(_ sender: UISlider) {
        setNewColor()
        changeViewColor()
        changeLabel(for: sender)
    }
    
    private func setNewColor() {
        mainBackgroundColor = UIColor(
            red: CGFloat(colorSliders[0].value),
            green: CGFloat(colorSliders[1].value),
            blue: CGFloat(colorSliders[2].value),
            alpha: 1
        )
    }
    
    private func changeViewColor() {
        colorView.backgroundColor = mainBackgroundColor
    }
    
    private func changeLabel(for slider: UISlider) {
        let text = String(format: "%.2f", slider.value)
        
        colorValueLabel[slider.tag].text = text
        colorValueTextFields[slider.tag].text = text
    }
    
    private func setupSlider(_ slider: UISlider, color: UIColor) {
        let colors = [
            mainBackgroundColor.redValue.floated,
            mainBackgroundColor.greenValue.floated,
            mainBackgroundColor.blueValue.floated
        ]
        
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = colors[slider.tag]
        slider.minimumTrackTintColor = color
        
        changeViewColor()
        changeLabel(for: slider)
    }
    
    private func checkNumeric(_ string: String?) -> Bool {
       Double(string ?? "") != nil
    }
}

// MARK: - UITextFieldDelegate
extension EditingViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        let value = Float(textField.text.commaToDot() ?? "0") ?? 0
        let index = textField.tag
        
        print(value)
        
        if (0.0...1.0).contains(value) {
            colorSliders[index].setValue(value, animated: true)
        } 
        
        print(!(0.0...1.0).contains(value))
        print(!checkNumeric(textField.text))
        
        if !(0.0...1.0).contains(value) || !checkNumeric(textField.text.commaToDot()){
            showAlert(
                withTitle: "Incorrect value",
                andMessage: "Value should be in range [0...1]"
            )
            self.colorSliders[index].setValue(0, animated: true)
        }
        
        updateUI(colorSliders[index])
    }
    
}

// MARK: - Keyboard toolbar
extension EditingViewController {
    
    @objc private func doneButtonPressed(sender: UIBarButtonItem) {
        guard let currentTextField = colorValueTextFields
            .first(where: {$0.isFirstResponder}) else { return }
        currentTextField.resignFirstResponder()
    }
}



