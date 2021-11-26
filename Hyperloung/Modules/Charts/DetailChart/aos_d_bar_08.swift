//
//  aos_d_bar_08.swift
//  Hyperloung
//
//  Created by Thai Nguyen on 11/6/21.
//

import UIKit
import Charts
struct ChartBar08 {
    var title: String
    var value: Double
    var description: String
    
    static var `default`: [ChartBar08] {
        return [
            ChartBar08(title: "최대 6자", value: 543, description: "543억"),
            ChartBar08(title: "최대 6자", value: 234, description: "543억"),
            ChartBar08(title: "최대 6자", value: 168, description: "12%"),
            ChartBar08(title: "6자 초과시", value: 421, description: "34%"),
            ChartBar08(title: "최대 6자", value: 302, description: "22%")
        ]
    }
}

class aos_d_bar_08: UIView, ChartViewDelegate {
    private var chart: HorizontalBarChartView!
 
    
    let values: [ChartBar08] = ChartBar08.default.reversed()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        chart = HorizontalBarChartView(frame: bounds)
        addSubview(chart)
        chart.fullscreen()
        updateCharts()
        configureCharts()

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
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
            let value = BarChartDataEntry(x: Double(i), y: values[i].value)
            chartDataEntry.append(value)
        }

        let chartDataSet = BarChartDataSet(entries: chartDataEntry, label: nil)
        chartDataSet.drawValuesEnabled = true
        chartDataSet.colors = [NSUIColor.black]
        chartDataSet.valueFont = FontFamily.customFont.displayFontWithSize(9, attributeType: .regular)
        chartDataSet.valueFormatter = YAxisValueFormatter(values: values)
        let chartMain = BarChartData()
        chartMain.barWidth = 0.3

        chartMain.addDataSet(chartDataSet)
//        chart.animate(yAxisDuration: 0.5)

        chart.data = chartMain
    }

    func configureCharts() {
        chart.xAxis.drawAxisLineEnabled = false
        chart.xAxis.labelPosition = .bottom
        chart.xAxis.valueFormatter = IndexAxisValueFormatter(values: values.map({$0.title}))
        chart.xAxis.labelFont = FontFamily.customFont.displayFontWithSize(12, attributeType: .regular)
//        chart.xAxis.labelPosition
        chart.xAxis.drawGridLinesEnabled = false
        chart.xAxis.granularity = 1.0
        chart.leftAxis.drawGridLinesEnabled = false
        chart.leftAxis.drawLabelsEnabled = false
//        chart.rightAxis.valueFormatter = YAxisValueFormatter()
        chart.rightAxis.granularity = 1.0
        chart.rightAxis.axisMinimum = 0.0
        chart.leftAxis.axisMinimum = 0.0    //here's the missing line
//        chart.extraBottomOffset = 50
//        chart.leftAxis.xOffset = 100
        chart.rightAxis.axisMaximum = 0.0
        chart.rightAxis.enabled = true
//        chart.xAxis.yOffset = 100
//        chart.leftAxis.offse = 4
        chart.rightAxis.enabled = false
        chart.legend.enabled = false
        chart.leftAxis.drawAxisLineEnabled = false
    }
    
}

class YAxisValueFormatter: NSObject, IValueFormatter {
    var values: [ChartBar08]
    
    init(values: [ChartBar08]) {
        self.values = values
    }
    
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        if let v = values.first(where: {$0.value == value}) {
            return v.description
        }
        return ""
    }
}
