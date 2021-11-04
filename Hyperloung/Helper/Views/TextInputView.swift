//
//  ValidateInputView.swift
//  Earable
//
//  Created by Admim on 11/12/20.
//  Copyright © 2020 Earable. All rights reserved.
//

import UIKit

struct TextInputViewAppear {
    var descriptionText: String
    var validText: String?
    var isShowValidText: Bool = false
    var isShowInvalidText: Bool = false
    var invalidText:String?
    var invalidColor: UIColor = .red
    var validColor: UIColor = .blue
    var isSecured: Bool = false
}

typealias ValidateInput = (String)->Bool

class TextInputView: UIView {
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var inputTextfield: UITextField!
    @IBOutlet weak var underlineView: UIView!

    
    @IBOutlet weak var view: UIView!
    var validateInput: ValidateInput?
    var appearance: TextInputViewAppear?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        Bundle.main.loadNibNamed("TextInputView", owner: self, options: nil)
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.fullscreen()
    }

    func appearance(_ info: TextInputViewAppear) {
        descriptionLabel.isHidden = false
        descriptionLabel.text = ""
        underlineView.backgroundColor = info.validColor
        underlineView.round(1.5)
        
      
        inputTextfield.isSecureTextEntry = info.isSecured
        inputTextfield.delegate = self
        inputTextfield.attributedPlaceholder = NSAttributedString(string: info.descriptionText,
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])

        appearance = info
        
    }
    
    func validateInput(_ completion: @escaping ValidateInput) {
        validateInput = completion
    }

    var text: String {
        return inputTextfield.text ?? ""
    }

}

extension TextInputView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if (textField.text?.isEmpty ?? true) {
            descriptionLabel.text = " "
            inputTextfield.attributedPlaceholder = NSAttributedString(string: appearance!.descriptionText,
                                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }
        
    
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        descriptionLabel.text = appearance?.descriptionText
        textField.placeholder = ""
    }
}


