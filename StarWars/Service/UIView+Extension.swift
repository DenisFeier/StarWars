//
//  UIView.swift
//  StarWars
//
//  Created by Denis Feier on 23/07/2020.
//  Copyright © 2020 Denis Feier. All rights reserved.
//

import UIKit

extension UIView {
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
           let gradientLayer = CAGradientLayer()
           gradientLayer.frame = bounds
           gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
           gradientLayer.locations = [0.0, 1.0]
           gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
           gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
           layer.insertSublayer(gradientLayer, at: 0)
       }
}
