//
//  HyperBarChartView.swift
//  Hyperloung
//
//  Created by Thai Nguyen on 10/26/21.
//

import UIKit
import EasyTipView

struct HyperBarChartData {
    enum HighlightTextStyle {
        case none, tooltip, text
    }
    
    var focus: Bool
    var value: Double
    var tooltipText: String?
    var highlightTextStyle: HighlightTextStyle = .none
    
}
protocol HyperChartDataSource: AnyObject {
    func dataSet() -> [HyperBarChartData]
    func description(of data: HyperBarChartData) -> String
    var anchorPoint: HyperBarChartData {get}
    var appearance: HyperBarChartView.Appearance {get}
}

class HyperBarChartView: UIView {
    enum TooltipStyle {
        case hasBackground(color: UIColor), all(color: UIColor), none
    }
    
    struct Appearance {
        var highlightColor: UIColor = .red
        var highlightTextColor: UIColor = .black
        var normalTextColor: UIColor = #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1)
        var normalColor: UIColor = .gray
        var shouldSeparateHighlightRow: Bool = false
        var shouldShowDetailDescription: Bool = false
        var tooltipStyle: TooltipStyle = .none
        var spaceBetweenRow: CGFloat = 32
    }
    
    var datasource: HyperChartDataSource!
    
    private var appearance: Appearance {
        datasource.appearance
    }
    
    private var dataSet: [HyperBarChartData] {
        return datasource.dataSet()
    }
    
    private var offsetTop: CGFloat = 30.0
    private var offsetBottom: CGFloat = 30.0
    
    private var numberOfItem: Int {
        return dataSet.count
    }
    
    func internalDraw() {
        let width = frame.width
        let itemWidth: CGFloat = min(32.0, (width - CGFloat(numberOfItem - 1) * appearance.spaceBetweenRow) / CGFloat(numberOfItem))
        let availableHeight = frame.height - offsetTop - offsetBottom
        
        // calculate start draw position
        let toDrawWidth = itemWidth * CGFloat(numberOfItem) + CGFloat(numberOfItem - 1) * appearance.spaceBetweenRow
        let offsetWidth = width - toDrawWidth
        var startXPos: CGFloat = offsetWidth / 2
        
        let anchorValue = datasource.anchorPoint.value
        
        let hasNegativeValue = dataSet.contains(where: {$0.value < 0})
        var availableHeightForPositiveValue: CGFloat = availableHeight
        var totalValue:CGFloat = CGFloat(datasource.anchorPoint.value)
        var availableHeightForNagativeValue: CGFloat = 0
        var maxPositiveValue = anchorValue
        var minNegativeValue = 0.0
        if let maxDataSet = dataSet.max(by: {$0.value < $1.value}), let minDataSet = dataSet.min(by: {$0.value < $1.value}), hasNegativeValue {
            totalValue = CGFloat(abs(maxDataSet.value) + abs(minDataSet.value))
            availableHeightForPositiveValue = CGFloat(abs(maxDataSet.value)) / totalValue * availableHeight
            maxPositiveValue = maxDataSet.value
            availableHeightForNagativeValue = CGFloat(abs(minDataSet.value)) / totalValue * availableHeight
            minNegativeValue = abs(minDataSet.value)
        }
        dataSet.forEach { data in
            let subLayer = CAShapeLayer()
            if data.value >= 0 {
                let percent:CGFloat = CGFloat(data.value) / CGFloat(maxPositiveValue)
                let itemHeight: CGFloat = availableHeightForPositiveValue * percent
                let startYPos: CGFloat =  availableHeightForPositiveValue - itemHeight
                let path = UIBezierPath(roundedRect: CGRect(x: startXPos, y: startYPos, width: itemWidth, height: itemHeight), byRoundingCorners: UIRectCorner.allCorners, cornerRadii: CGSize(width: 8.0, height: 8.0))
                subLayer.path = path.cgPath
                
                if let tooltipText = data.tooltipText {
                    let attributeString = NSAttributedString(string: tooltipText, attributes: [.foregroundColor: UIColor.red, .font: UIFont.systemFont(ofSize: 12)])
                    let textSize = attributeString.size()
                    let tooltipWidth = textSize.width + 20
                    let tooltip = ToolTip(text: tooltipText, position: .top)
                    tooltip.drawToolTip(CGRect(x: (startXPos + itemWidth / 2) - tooltipWidth / 2, y: startYPos - 30 - 5, width: tooltipWidth, height: 30), in: layer)
                }
                
            } else {
                let percent:CGFloat = CGFloat(abs(data.value)) / CGFloat(minNegativeValue)
                let itemHeight: CGFloat = availableHeightForNagativeValue * percent
                let startYPos: CGFloat =  availableHeightForPositiveValue
                let path = UIBezierPath(roundedRect: CGRect(x: startXPos, y: startYPos, width: itemWidth, height: itemHeight), byRoundingCorners: UIRectCorner.allCorners, cornerRadii: CGSize(width: 8.0, height: 8.0))
                subLayer.path = path.cgPath
                
                if let tooltipText = data.tooltipText {
                    let attributeString = NSAttributedString(string: tooltipText, attributes: [.foregroundColor: UIColor.red, .font: UIFont.systemFont(ofSize: 12)])
                    let textSize = attributeString.size()
                    let tooltipWidth = textSize.width + 20
                    let tooltip = ToolTip(text: tooltipText, position: .bottom)
                    tooltip.drawToolTip(CGRect(x: (startXPos + itemWidth / 2) - tooltipWidth / 2, y: startYPos + itemHeight + 5 , width: tooltipWidth, height: 30), in: layer)
                }
            }
            
            var descriptionText: NSAttributedString!
//            if data.shouldSeparateHighlightRow {
                let color: UIColor = data.focus ? appearance.highlightColor : appearance.normalColor
                subLayer.fillColor = color.cgColor
                descriptionText = NSAttributedString(string: "\(datasource.description(of: data))", attributes: [.foregroundColor: color, .font: UIFont.systemFont(ofSize: 12)])
                
//            } else {
//                let color = appearance.normalColor.cgColor
//                subLayer.fillColor = color
//                descriptionText = NSAttributedString(string: "\(datasource.description(of: data))", attributes: [.foregroundColor: color, .font: UIFont.systemFont(ofSize: 12)])
//            }
            
            let numberSize = descriptionText.size()
            let textLayer = CATextLayer()
            textLayer.string = descriptionText
            textLayer.frame = CGRect(x: (startXPos + itemWidth / 2) - numberSize.width / 2, y: frame.height - offsetBottom, width: numberSize.width, height: numberSize.height)
            subLayer.addSublayer(textLayer)
            layer.addSublayer(subLayer)
            startXPos += (itemWidth + appearance.spaceBetweenRow)
        }
    }
    
    func drawHighlightText(for data: HyperBarChartData, originPoint: CGPoint, itemWidth: CGFloat) {
        guard let tooltipText = data.tooltipText else {return}
        let attributeString = NSAttributedString(string: tooltipText, attributes: [.foregroundColor: appearance.highlightTextColor, .font: UIFont.systemFont(ofSize: 12)])
        let textSize = attributeString.size()
        let tooltipWidth = textSize.width + 20
        
        let rect = CGRect(origin: originPoint, size: CGSize(width: tooltipWidth, height: 30))
        switch data.highlightTextStyle {
        case .tooltip:
            let tooltip = ToolTip(text: tooltipText, position: .top)
            tooltip.drawToolTip(rect, in: layer)
        case .text:
            let textLayer = CATextLayer()
            textLayer.string = attributeString
            textLayer.frame = rect
            layer.addSublayer(textLayer)
        default:
            break
        }
 
    }
}
