//
//  CustomTextView.swift
//  StarWars
//
//  Created by Denis Feier on 23/07/2020.
//  Copyright © 2020 Denis Feier. All rights reserved.
//

import Foundation
import UIKit

class CustomTextView: UITextView {

    var bottomBorder = UIView()

    init(frame: CGRect) {
        super.init(frame: frame, textContainer: nil)
        self.setupTextField()
    }

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.setupTextField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupTextField()
    }

    func setupTextField() {
        tintColor = .blue
        textColor = .darkGray
        font = UIFont(name: "Times New Roman", size: 18)
        backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        autocorrectionType = .no
        layer.cornerRadius = 20.0
        clipsToBounds = true
    }

}
