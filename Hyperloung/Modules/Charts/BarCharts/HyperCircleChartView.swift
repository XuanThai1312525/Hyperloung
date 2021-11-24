//
//  HyperCircleChartView.swift
//  Hyperloung
//
//  Created by Thai Nguyen on 10/27/21.
//

import Foundation
import UIKit
import Charts

struct HyperCircleData {
    var value: Double
    var color: UIColor
    var percent: Double?
    var description: String?
}
protocol HyperCircleDataSource: AnyObject {
    var dataSet: [HyperCircleData] {get}
    func description(of data: HyperCircleData) -> String
    var lineWidth: CGFloat {get}
    var tooltip: NSAttributedString? {get}
    var centerTextAppearnce: HyperCircleCenterTextAppearance? {get}
    var isShowLegend: Bool {get}
    var borderColor: UIColor? {get}
    var shadowColor: UIColor? {get}
}

struct HyperCircleCenterTextAppearance {
    var textAttributedString: NSAttributedString!
    var prefix: String! //for custom
    var suffix: String!//for custom
    var prefixColor: UIColor! = UIColor.black//for custom
    var suffixColor: UIColor! = UIColor.gray//for custom
    var prefixFont: UIFont! = FontFamily.customFont.displayFontWithSize(24)//for custom
    var suffixFont: UIFont! = FontFamily.customFont.displayFontWithSize(16)//for custom
}

extension HyperCircleDataSource {
    var isShowLegend: Bool {
        return false
    }
}

class HyperCircleChartView: UIView {
    private var chartView: PieChartView!
    var datasource: HyperCircleDataSource!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func drawChart()  {
        let chart = PieChartView(frame: bounds)
        var colors: [UIColor] = []
        var entries = [PieChartDataEntry]()
        datasource.dataSet.forEach({ data in
            let entry = PieChartDataEntry()
            entry.y = Double(data.value)
            entries.append( entry)
            colors.append(data.color)
        })

        let set = PieChartDataSet( entries: entries, label: nil)
        set.drawValuesEnabled = false
        chart.drawEntryLabelsEnabled = false
       
        chart.legend.enabled = false
        set.colors = colors
        let data = PieChartData(dataSet: set)
        chart.data = data
 
        if let centerTextAppearance = datasource.centerTextAppearnce {
            if let textAttributedString = centerTextAppearance.textAttributedString {
                chart.centerAttributedText = textAttributedString
            } else {
                chart.centerAttributedText = NSMutableAttributedString()
                    .addAtributes(for: centerTextAppearance.prefix, attribute: [
                        NSAttributedString.Key.font : centerTextAppearance.prefixFont!,
                        NSAttributedString.Key.foregroundColor : centerTextAppearance.prefixColor!,
                    ]).addAtributes(for: centerTextAppearance.suffix, attribute: [
                        NSAttributedString.Key.font : centerTextAppearance.suffixFont!,
                        NSAttributedString.Key.foregroundColor : centerTextAppearance.suffixColor!,
                    ])
            }
        }
        
        chart.holeRadiusPercent = 0.65
        chart.transparentCircleColor = UIColor.clear
        addSubview(chart)
        chart.fullscreen()
        
        
        if let tooltip = datasource.tooltip {
            let x = chart.frame.origin.x
            let y = chart.frame.origin.y
            let height = chart.frame.height
            let width = chart.frame.width
            drawToolTip(point: CGPoint(x: x+width*0.75, y:  y + height/4-20),parentLayer: chart.layer, text: tooltip)
        }
    }
    
    func drawToolTip(point: CGPoint,parentLayer: CALayer, text: NSAttributedString) {
        let tooltipWidth = text.string.size().width + 20
        let tooltipHeight = text.string.size().height + 10
        
        let rect = CGRect(x: point.x, y: point.y,width: tooltipWidth,height:  tooltipHeight)
        
        let roundRectBez = UIBezierPath(roundedRect: rect, cornerRadius: rect.height/2)
        
        let textLayer = CATextLayer()
        textLayer.string = text
        textLayer.frame = CGRect(x: point.x , y: point.y + text.string.size().height/4, width: tooltipWidth, height: text.string.size().height)
        textLayer.alignmentMode = .center
        let shape = createShapeLayer(roundRectBez.cgPath)
        
        shape.shadowColor = datasource.borderColor?.cgColor ?? #colorLiteral(red: 0.1411764706, green: 0.4352941176, blue: 0.9333333333, alpha: 1).cgColor
        shape.shadowRadius = tooltipHeight/2
        shape.shadowOffset = CGSize(width: 0, height: 0.1)
        shape.shadowOpacity = 0.1
        parentLayer.addSublayer(shape)
        parentLayer.addSublayer(textLayer)
    }
    
    func createShapeLayer(_ path : CGPath) -> CAShapeLayer{
        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = UIColor.white.cgColor
        shape.strokeColor = datasource.borderColor?.cgColor ?? #colorLiteral(red: 0.1411764706, green: 0.4352941176, blue: 0.9333333333, alpha: 1).cgColor
        shape.lineWidth = 0.1
        return shape
    }
}
