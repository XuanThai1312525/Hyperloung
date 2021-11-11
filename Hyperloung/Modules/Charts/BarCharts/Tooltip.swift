//
//  Tooltip.swift
//  Hyperloung
//
//  Created by Thai Nguyen on 11/2/21.
//

import Foundation
import UIKit

class ToolTip {
    enum Position {
        case top, bottom
    }
    
    struct Appearance {
        var position: Position = .bottom
        var height: CGFloat = 6
        var width: CGFloat = 10
        var textColor: UIColor = .black
        var cornerRadius: CGFloat = 8.0
        var borderWidth: CGFloat = 0.5
        var borderColor: UIColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        var fillColor: UIColor = UIColor.white
    }
    
    var appearance: Appearance
    var text: String
    
    init(text: String, appearance: Appearance = Appearance()) {
        self.appearance = appearance
        self.text = text
    }
    
    convenience init (text: String, position: Position) {
        var appearance = Appearance()
        appearance.position = position
        self.init(text: text, appearance: appearance)
    }
    
    
    func drawToolTip(_ rect : CGRect, in parentLayer: CALayer){
        let tipHeight = rect.height - appearance.height
        var roundRect = CGRect(x: rect.minX, y: rect.minY, width: rect.width, height: tipHeight)
        var tipRect = CGRect(x: rect.midX - appearance.width / 2, y: roundRect.maxY, width: appearance.width, height: appearance.height)
        switch appearance.position {
        case .bottom:
            roundRect = CGRect(x: rect.minX, y: rect.minY + appearance.height, width: rect.width, height: tipHeight)
            tipRect = CGRect(x: rect.midX - appearance.width / 2, y: rect.minY, width: appearance.width, height: appearance.height)
        default:
            break
        }
        
        let roundRectBez = UIBezierPath(roundedRect: roundRect, cornerRadius: appearance.cornerRadius)
        let attributeString = NSAttributedString(string: text, attributes: [.foregroundColor: appearance.textColor, .font: UIFont.normal(size: 12)])
        let textSize = attributeString.size()
        let textLayer = CATextLayer()
        textLayer.string = attributeString
        textLayer.frame = CGRect(x: rect.midX - textSize.width / 2 , y: rect.midY - textSize.width / 2, width: rect.width, height: tipHeight)
        
        let trianglePath = createTipPath(roundRect: tipRect)
        roundRectBez.append(trianglePath)
        let shape = createShapeLayer(roundRectBez.cgPath)
        shape.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        shape.shadowRadius = appearance.cornerRadius
        shape.shadowOffset = CGSize(width: 0, height: 3)
        shape.shadowOpacity = 1.0
        parentLayer.addSublayer(shape)
        parentLayer.addSublayer(textLayer)
    }
    
    
    func createTipPath(roundRect: CGRect) -> UIBezierPath{
        let trianglePath = UIBezierPath()
        switch appearance.position {
        case .top:
            trianglePath.move(to: CGPoint(x: roundRect.minX, y: roundRect.minY))
            trianglePath.addLine(to: CGPoint(x: roundRect.midX, y: roundRect.maxY))
            trianglePath.addLine(to: CGPoint(x: roundRect.maxX, y: roundRect.minY))
        default:
            trianglePath.move(to: CGPoint(x: roundRect.maxX, y: roundRect.maxY))
            trianglePath.addLine(to: CGPoint(x: roundRect.midX, y: roundRect.minY))
            trianglePath.addLine(to: CGPoint(x: roundRect.minX, y: roundRect.maxY))
        }
    
        trianglePath.close()
        return trianglePath
    }
    
    func createShapeLayer(_ path : CGPath) -> CAShapeLayer{
        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = appearance.fillColor.cgColor
        shape.strokeColor = appearance.borderColor.cgColor
        shape.borderColor = appearance.borderColor.cgColor
        return shape
    }
}
