//
//  HyperBarChartView.swift
//  Hyperloung
//
//  Created by Thai Nguyen on 10/26/21.
//

import UIKit
import EasyTipView

struct HyperBarChartData {
    var focus: Bool
    var value: Double
}
protocol HyperChartDataSource: AnyObject {
    func dataSet() -> [HyperBarChartData]
    var spaceBetweenRow: CGFloat {get}
    func description(of data: HyperBarChartData) -> String
    var hightlightColor: UIColor {get}
    var anchorPoint: HyperBarChartData {get}
}

class HyperBarChartView: UIView {
    weak var datasource: HyperChartDataSource!
    
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
        let itemWidth: CGFloat = min(32.0, (width - CGFloat(numberOfItem - 1) * datasource.spaceBetweenRow) / CGFloat(numberOfItem))
        let availableHeight = frame.height - offsetTop - offsetBottom
        var startXPos: CGFloat = 0.0
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
            } else {
                let percent:CGFloat = CGFloat(abs(data.value)) / CGFloat(minNegativeValue)
                let itemHeight: CGFloat = availableHeightForNagativeValue * percent
                let startYPos: CGFloat =  availableHeightForPositiveValue
                
                let path = UIBezierPath(roundedRect: CGRect(x: startXPos, y: startYPos, width: itemWidth, height: itemHeight), byRoundingCorners: UIRectCorner.allCorners, cornerRadii: CGSize(width: 8.0, height: 8.0))
                subLayer.path = path.cgPath
            }
            let color: UIColor = data.focus ? .red : #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1)
            subLayer.fillColor = color.cgColor
    
            let descriptionText = NSAttributedString(string: "\(datasource.description(of: data))", attributes: [.foregroundColor: color, .font: UIFont.systemFont(ofSize: 12)])
            let numberSize = descriptionText.size()
            
            let textLayer = CATextLayer()
            textLayer.string = descriptionText
            textLayer.frame = CGRect(x: (startXPos + itemWidth / 2) - numberSize.width / 2, y: frame.height - offsetBottom, width: numberSize.width, height: numberSize.height)
            subLayer.addSublayer(textLayer)
            layer.addSublayer(subLayer)
            startXPos += (itemWidth + datasource.spaceBetweenRow)
        }
    }
}
