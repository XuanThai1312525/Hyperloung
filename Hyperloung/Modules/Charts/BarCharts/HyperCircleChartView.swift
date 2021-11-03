//
//  HyperCircleChartView.swift
//  Hyperloung
//
//  Created by Thai Nguyen on 10/27/21.
//

import Foundation
import UIKit

struct HyperCircleData {
    var percent: Double
    var color: UIColor
    var description: String?
}
protocol HyperCircleDataSource: AnyObject {
    var dataSet: [HyperCircleData] {get}
    func description(of data: HyperCircleData) -> String
    var lineWidth: CGFloat {get}
    var internalDescription: (String, UIColor)? {get}
}

class HyperCircleChartView: UIView {
    var datasource: HyperCircleDataSource!
    private var backgroundLayer = CAShapeLayer()
    
    func drawChart() {
        let radius = min(frame.height, frame.width) / 2
        backgroundLayer.sublayers?.removeAll()
        backgroundLayer.removeFromSuperlayer()
        backgroundLayer.lineWidth = datasource.lineWidth
        backgroundLayer.strokeColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1).cgColor
        backgroundLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(backgroundLayer)
        let bgPath = UIBezierPath()
        let centerPoint = CGPoint(x: frame.width / 2, y: frame.height / 2)
        let from: CGFloat = -.pi / 2
        bgPath.addArc(withCenter: centerPoint, radius: radius, startAngle: from + 0.00000001, endAngle: from, clockwise: true)
        backgroundLayer.path = bgPath.cgPath
        drawChart(in: frame, centerPoint: centerPoint, radius: radius, to: backgroundLayer)
        drawTexts(center: centerPoint, to: backgroundLayer)
    }
    
    private func drawTexts(center: CGPoint, to parentLayer: CALayer) {
        guard let internalDescription = datasource.internalDescription else {return}
        let descriptionText = NSAttributedString(string: internalDescription.0, attributes: [.foregroundColor: internalDescription.1, .font: UIFont.systemFont(ofSize: 26)])
        let numberSize = descriptionText.size()
        
        let textLayer = CATextLayer()
        textLayer.string = descriptionText
        textLayer.frame = CGRect(x: center.x - numberSize.width / 2, y: center.y - numberSize.height / 2, width: numberSize.width, height: numberSize.height)
        parentLayer.addSublayer(textLayer)
    }
    private func drawChart(in rect: CGRect, centerPoint: CGPoint, radius: CGFloat, to parentLayer: CALayer) {
        var startPoint: CGFloat = -.pi
        var width = datasource.lineWidth

//        datasource.dataSet.forEach { (data) in
        let data = datasource.dataSet.first!
            let sharpLayer = CAShapeLayer()
            sharpLayer.lineWidth = width
            sharpLayer.strokeColor = data.color.cgColor
            let endPoint: CGFloat =  .pi
            let path = UIBezierPath()
            path.addArc(withCenter: centerPoint, radius: radius, startAngle: startPoint, endAngle: endPoint, clockwise: true)
            sharpLayer.lineCap = .square
            sharpLayer.fillColor = UIColor.clear.cgColor
            sharpLayer.path = path.cgPath
            parentLayer.addSublayer(sharpLayer)
            width -= 3
        
            let cy = centerPoint.y + (radius) * sin(startPoint + endPoint)
            let cx = centerPoint.x + (radius) * cos(startPoint + endPoint)
          //  drawDescriptionText(of: data, at: CGPoint(x: cx , y: cy), to: sharpLayer)
            startPoint += endPoint
//        }
    }
    
    func drawDescriptionText(of data: HyperCircleData, at center: CGPoint, to parentLayer: CALayer) {
        let containerLayer = CAShapeLayer()
        let textDescription = datasource.description(of: data)
        let attributeString = NSAttributedString(string: textDescription, attributes: [.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 12)])
        let textSize = attributeString.size()
        
        let textLayer = CATextLayer()
        textLayer.string = attributeString
        textLayer.frame = CGRect(origin: CGPoint(x: center.x + 10, y: center.y + 5), size: CGSize(width: textSize.width + 20, height: textSize.height + 10))
        let path = UIBezierPath(roundedRect: CGRect(origin: center, size: CGSize(width: textSize.width + 20, height: textSize.height + 10)), byRoundingCorners: UIRectCorner.allCorners, cornerRadii: CGSize(width: 8.0, height: 8.0))
        containerLayer.path = path.cgPath
        containerLayer.fillColor = UIColor.white.cgColor
        containerLayer.strokeColor = UIColor.red.cgColor
        containerLayer.addSublayer(textLayer)
        parentLayer.addSublayer(containerLayer)
    }
}
