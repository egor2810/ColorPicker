//
//  Models.swift
//  ColorPicker
//
//  Created by Егор Аблогин on 08.12.2023.
//

import UIKit

class EnglishTextField: UITextField {
    override var textInputMode: UITextInputMode? {
        return EnglishInputMode()
    }
}

class EnglishInputMode : UITextInputMode {
    override var primaryLanguage: String? {
        "en-US"
    }
}
