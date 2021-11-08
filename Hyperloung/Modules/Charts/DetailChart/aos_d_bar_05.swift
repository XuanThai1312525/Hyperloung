//
//  aos_d_bar_05.swift
//  Hyperloung
//
//  Created by Thai Nguyen on 11/7/21.
//

import Foundation
import UIKit
import Charts

class aos_d_bar_05: UIView, ChartViewDelegate {
    var chartView: BarChartView!
    var entries: [BarChartDataEntry] = []
    var data: [Double] = [6.0, 5.0, 7.5]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        chartView = BarChartView(frame: bounds)
        addSubview(chartView)
        chartView.fullscreen()
        draw()
    }
    
    func draw() {
        
        for index in 0..<data.count {
//            let dataEntry = BarChartDataEntry(x: Double(index), y: data[index])
            let entry = BarChartDataEntry(x: Double(index), y: data[index])
            entries.append(entry)
        }
     
        chartView.drawBarShadowEnabled = true
        let chartDataSet = BarChartDataSet(entries: entries, label: "")
        chartDataSet.colors = [#colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)]
        chartDataSet.barShadowColor = #colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 0.9568627451, alpha: 1)
        chartDataSet.stackLabels = ["Inactive inventory", "Active inventory"]
        chartDataSet.drawValuesEnabled = true
        chartView.drawValueAboveBarEnabled = true
        let chartData = BarChartData(dataSet: chartDataSet)
        chartData.barWidth = 0.1
        chartView.data = chartData
       
        chartView.legend.enabled = false
        chartView.xAxis.enabled = false
        chartView.leftAxis.enabled = false
        chartView.leftAxis.drawLabelsEnabled = false
        chartView.rightAxis.enabled = false

    }
}
