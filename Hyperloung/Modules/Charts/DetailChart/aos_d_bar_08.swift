//
//  aos_d_bar_08.swift
//  Hyperloung
//
//  Created by Thai Nguyen on 11/6/21.
//

import UIKit
import Charts

class aos_d_bar_08: UIView, ChartViewDelegate {
    private var chart: HorizontalBarChartView!
    var values: [Double] = [543, 234, 168, 421, 302.0]
    var moods = ["영업1", "영업2", "영업3", "AI", "보안"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        chart = HorizontalBarChartView(frame: bounds)
        addSubview(chart)
        chart.fullscreen()
        updateCharts()
        configureCharts()
    }
    
    func updateCharts() {
        var chartDataEntry = [BarChartDataEntry]()

        for i in 0..<values.count {
            let value = BarChartDataEntry(x: Double(i), y: values[i])
            chartDataEntry.append(value)
        }

        let chartDataSet = BarChartDataSet(entries: chartDataEntry, label: nil)
        chartDataSet.drawValuesEnabled = true
        chartDataSet.colors = [NSUIColor.black]
        chartDataSet.valueFormatter = YAxisValueFormatter()
        let chartMain = BarChartData()
        chartMain.barWidth = 0.3

        chartMain.addDataSet(chartDataSet)
        chart.animate(yAxisDuration: 0.5)
        chart.data = chartMain
    }

    func configureCharts() {

        chart.xAxis.drawAxisLineEnabled = false
        chart.xAxis.labelPosition = .bottom
        chart.xAxis.valueFormatter = IndexAxisValueFormatter(values: moods)
        chart.xAxis.drawGridLinesEnabled = false
        chart.xAxis.granularity = 1.0
        chart.leftAxis.drawGridLinesEnabled = false
        chart.leftAxis.drawLabelsEnabled = false
//        chart.rightAxis.valueFormatter = YAxisValueFormatter()
        chart.rightAxis.granularity = 1.0
        chart.rightAxis.axisMinimum = 0.0
        chart.leftAxis.axisMinimum = 0.0    //here's the missing line
//        chart.extraBottomOffset = 50
//        chart.leftAxis.yOffset = 100
//        chart.leftAxis.xOffset = 100
        chart.rightAxis.axisMaximum = 0.0
        chart.rightAxis.enabled = true
//        chart.xAxis.yOffset = 100
//        chart.xAxis.xOffset = 100
        chart.rightAxis.enabled = false
        chart.legend.enabled = false
        chart.leftAxis.drawAxisLineEnabled = false
    }
    
}

class YAxisValueFormatter: NSObject, IValueFormatter {
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        return "\(value)억"
    }
}
