//
//  CustomTextField.swift
//  StarWars
//
//  Created by Denis Feier on 09/07/2020.
//  Copyright © 2020 Denis Feier. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

   override init(frame: CGRect) {
        super.init(frame: frame)
        setUpField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpField()
    }
    
    
    private func setUpField() {
        tintColor = .blue
        textColor = .darkGray
        font = UIFont(name: "Times New Roman", size: 18)
        backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        autocorrectionType = .no
        layer.cornerRadius = 20.0
        clipsToBounds = true
        
        let placeholder = self.placeholder != nil ? self.placeholder! : ""
        let placeholderFont = UIFont(name: "Times New Roman", size: 18)!
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes:
            [NSAttributedString.Key.foregroundColor: UIColor.lightGray,
             NSAttributedString.Key.font: placeholderFont])
        
        let indentView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        leftView = indentView
        leftViewMode = .always
    }

}
