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
    var percent: Double
    var color: UIColor
    var description: String?
}
protocol HyperCircleDataSource: AnyObject {
    var dataSet: [HyperCircleData] {get}
    func description(of data: HyperCircleData) -> String
    var lineWidth: CGFloat {get}
    var centerText: (String, UIColor)? {get}
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
            entry.y = Double(data.percent)
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
 
        if let centerText = datasource.centerText {
            chart.centerText = centerText.0
        }
        chart.holeRadiusPercent = 0.65
        chart.transparentCircleColor = UIColor.clear
        addSubview(chart)
        chart.fullscreen()
    }
}
