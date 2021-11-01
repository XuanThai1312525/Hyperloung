//
//  LinkedChartView.swift
//  Hyperloung
//
//  Created by Thai Nguyen on 10/28/21.
//

import Foundation
import UIKit
struct LinkedChartData {
    var value: Double
}

protocol LinkedDataSource: AnyObject {
    func numberOfChart(_ chart: LinkedChartView) -> Int
    func dataForChart(_ chart: LinkedChartView, section: Int) -> [LinkedChartData]
    var anchorPoint: LinkedChartData {get}
    func appearance(_ for: LinkedChartView) -> LinkedChartView.Appearance
}

class LinkedChartView: UIView {
    struct Appearance {
        var lineWidth: CGFloat = 2
        var radius: CGFloat = 5
        var lineColor: UIColor = .red
        var verticalOffset: (top: CGFloat, bottom:CGFloat) = (10, 10)
    }
    
    var datasource: LinkedDataSource!
    private var rulerLayer = CAShapeLayer()
    private var backgroundLayer = CAShapeLayer()
    private var tooltipHeight: CGFloat = 15.0
    
    private var appearance: Appearance {
        return datasource?.appearance(self) ?? Appearance()
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {return}
        context.saveGState()
        // draw line
        let numberOfChart = datasource.numberOfChart(self)
        for i in 0..<numberOfChart {
            let chartDatas = datasource.dataForChart(self, section: i)
            var startXPos: CGFloat = 0.0
            let widthUnit: CGFloat = frame.width / CGFloat(chartDatas.count)
//            for i in 0..<chartDatas.count {
//                startXPos = widthUnit * CGFloat(i)
//                let point = CGPoint(x: startXPos, y: distanceToAnchorPoint(data: chartDatas[i]))
//                context.addLine(to: point)
//                context.move(to: point)
//                //                  paths.append(UIBezierPath(arcCenter: point, radius: appearance.radius, startAngle: 0, endAngle: 2 * .pi - 0.0001, clockwise: true))
//            }
//            appearance.lineColor.setStroke()
//            context.setLineJoin(.round)
//            context.setLineWidth(appearance.lineWidth)
//            context.strokePath()
            
//            context.restoreGState()
//            context.saveGState()
//            for i in 0..<chartDatas.count {
                startXPos = widthUnit * CGFloat(i)
                let point = CGPoint(x: startXPos, y: distanceToAnchorPoint(data: chartDatas[3]))
//                context.addLine(to: point)
                context.addArc(center: point, radius: appearance.radius, startAngle: 0, endAngle: 2 * .pi - 0.0001, clockwise: true)
//                context.move(to: point)
//            }
            appearance.lineColor.setStroke()
            context.setLineJoin(.round)
            context.setLineWidth(appearance.lineWidth)
            context.strokePath()
        }
        
    }
    
    func drawChart() {
        setNeedsDisplay()
    }
    
//    func drawChart() {
//        let numberOfChart = datasource.numberOfChart(self)
//        for i in 0..<numberOfChart {
//            let chartLayer = CAShapeLayer()
//            chartLayer.frame = CGRect(x: 0, y: 0, width:200, height: 200)
//            let chartDatas = datasource.dataForChart(self, section: i)
//            var startXPos: CGFloat = 0.0
//            let widthUnit: CGFloat = frame.width / CGFloat(chartDatas.count)
//            let paths = UIBezierPath()
//            paths.lineWidth = appearance.lineWidth
//            chartLayer.lineCap = .round
//            chartLayer.fillColor = UIColor.clear.cgColor
//            for i in 0..<chartDatas.count {
//                startXPos = widthUnit * CGFloat(i)
//                let point = CGPoint(x: startXPos, y: distanceToAnchorPoint(data: chartDatas[i]))
//                paths.addLine(to: point)
//                paths.move(to: point)
//                paths.append(UIBezierPath(arcCenter: point, radius: appearance.radius, startAngle: 0, endAngle: 2 * .pi - 0.0001, clockwise: true))
//            }
//            chartLayer.strokeColor = appearance.lineColor.cgColor
//            chartLayer.lineWidth = appearance.lineWidth
//            chartLayer.path = paths.cgPath
//            layer.addSublayer(chartLayer)
//        }
//    }
//
    var availableHeight: CGFloat {
        frame.height - appearance.verticalOffset.top - appearance.verticalOffset.bottom
    }
    
    var unitPoint: CGFloat {
        
        return CGFloat(datasource!.anchorPoint.value) / availableHeight
    }
        
    func distanceToAnchorPoint(data: LinkedChartData) -> CGFloat {
        let anchorPointValue = datasource!.anchorPoint.value == 0 ? 1 : datasource!.anchorPoint.value
        return CGFloat(data.value / anchorPointValue) * (unitPoint == 0.0 ? 1 : unitPoint)
    }
}
