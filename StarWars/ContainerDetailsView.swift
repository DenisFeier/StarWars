//
//  ContainerDetailsView.swift
//  StarWars
//
//  Created by Denis Feier on 30/07/2020.
//  Copyright © 2020 Denis Feier. All rights reserved.
//

import UIKit

@IBDesignable
class ContainerDetailsView: UIView {

    @IBInspectable var startColor: UIColor = Colors.brightOrange
    @IBInspectable var endColor: UIColor = Colors.orange

    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath(
                roundedRect: rect,
                byRoundingCorners: .allCorners,
                cornerRadii: CGSize(width: 8.0, height: 8.0)
              )
        path.addClip()
              
        
      // 2
      guard let context = UIGraphicsGetCurrentContext() else {
        return
      }
      let colors = [startColor.cgColor, endColor.cgColor]
      
      // 3
      let colorSpace = CGColorSpaceCreateDeviceRGB()
      
      // 4
      let colorLocations: [CGFloat] = [0.0, 1.0]
      
      // 5
      guard let gradient = CGGradient(
        colorsSpace: colorSpace,
        colors: colors as CFArray,
        locations: colorLocations
      ) else {
        return
      }
      
      // 6
      let startPoint = CGPoint.zero
      let endPoint = CGPoint(x: 0, y: bounds.height)
      context.drawLinearGradient(
        gradient,
        start: startPoint,
        end: endPoint,
        options: []
      )
        
    }


}
