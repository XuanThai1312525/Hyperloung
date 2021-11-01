//
//  HyperRowView.swift
//  Hyperloung
//
//  Created by Thai Nguyen on 10/27/21.
//

import UIKit
struct HyperHorizontalData {
    let total: Double
    let current: Double
    let unit: String
}

class HyperRowView: UIView {
    struct Appearance {
        var lineHeight:CGFloat = 20
        var highlightColor: UIColor = .red
        var backgroundColor: UIColor = #colorLiteral(red: 0.9333333333, green: 0.1960784314, blue: 0.1411764706, alpha: 0.7204294773)
        var showHighlightText: Bool = false
        var trailingSpace: CGFloat = 8
        var descriptionWidth: CGFloat = 50
        var cornerRadius: CGFloat = 3
        var trailingDescription: String?
        var highlightCorners: UIRectCorner = [.topLeft, .bottomLeft]
        var leadingSpace: CGFloat = 0
        var leadingDescription: String?
        var leadingTextColor: UIColor = .black
        var trailingTextColor: UIColor = .black
        var highlightDescription: String?
    }
    
    private var highlightLayer = CAShapeLayer()
    private var backgroundLayer = CAShapeLayer()
    var data: HyperHorizontalData!
    var appearance: Appearance = Appearance()
    
    private var percent: CGFloat {
        return CGFloat(data.current / data.total)
    }
    
    let totalLabel = UILabel()
    let highlightLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(totalLabel)
        addSubview(highlightLabel)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubview(totalLabel)
        addSubview(highlightLabel)
    }
    
    func drawChart() {
        let availableWidth = frame.width - appearance.descriptionWidth - appearance.leadingSpace
        let backgroundFrame = CGRect(x: appearance.leadingSpace, y: frame.maxY / 2 - appearance.lineHeight / 2, width: availableWidth, height: appearance.lineHeight)
      
        let backgroundPath = UIBezierPath(roundedRect: backgroundFrame, cornerRadius: appearance.cornerRadius)
        backgroundLayer.path = backgroundPath.cgPath
        backgroundLayer.fillColor = appearance.backgroundColor.cgColor
        
        let highlightWidth = availableWidth * percent
        let highlightFrame = CGRect(x: appearance.leadingSpace, y: frame.maxY / 2 - appearance.lineHeight / 2, width: highlightWidth, height: appearance.lineHeight)
        let highlightPath =  UIBezierPath(roundedRect: highlightFrame, byRoundingCorners: appearance.highlightCorners, cornerRadii: CGSize(width: appearance.cornerRadius, height: appearance.cornerRadius))
        highlightLayer.path = highlightPath.cgPath
        highlightLayer.fillColor = appearance.highlightColor.cgColor
        
        if let highlightDescription = appearance.highlightDescription {
            let attributeString = NSAttributedString(string: highlightDescription, attributes: [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 12)])
            let textSize = attributeString.size()
            highlightLabel.frame = CGRect(x: appearance.leadingSpace + 4 , y: frame.height / 2 - textSize.height / 2, width: textSize.width, height: textSize.height)
            highlightLabel.attributedText = attributeString
        }
       
        if let textDescription = appearance.trailingDescription {
            let textAttributeString = NSAttributedString(string: textDescription, attributes: [.foregroundColor: appearance.trailingTextColor, .font: UIFont.systemFont(ofSize: 12)])
            let totalTextSize = textAttributeString.size()
            totalLabel.frame = CGRect(x: availableWidth + appearance.trailingSpace + appearance.leadingSpace , y: frame.height / 2 - totalTextSize.height / 2, width: totalTextSize.width, height: totalTextSize.height)
            totalLabel.attributedText = textAttributeString
        }
     
        layer.addSublayer(backgroundLayer)
        layer.addSublayer(highlightLayer)
        bringSubviewToFront(highlightLabel)
        if let leadingDescription = appearance.leadingDescription {
            let attributeString = NSAttributedString(string: leadingDescription, attributes: [.foregroundColor: appearance.leadingTextColor, .font: UIFont.systemFont(ofSize: 12)])
            let textSize = attributeString.size()
            
            let textLayer = CATextLayer()
            textLayer.string = attributeString
            textLayer.frame = CGRect(x: 0 , y: frame.maxY / 2 - textSize.height / 2, width: textSize.width, height: textSize.height)
            layer.insertSublayer(textLayer, above: highlightLayer)
        }
    }
}
