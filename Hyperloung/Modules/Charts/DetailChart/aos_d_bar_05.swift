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
    var data = [BarChartItemData]()
    
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
        let barVisual: BarVisual = BarVisual(radius: 4, barNormalColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), barHighlightColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), valueNormalTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), valueHighlightTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), titleNormalTextColor: #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), titleHighlightTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))

        data = [
            BarChartItemData(title: "Text", valueTitle: "68%", value: 90, barVisual: barVisual),
            BarChartItemData(title: "Text", valueTitle: "70%", value: 90, barVisual: barVisual),
            BarChartItemData(title: "Text", valueTitle: "75%", value: 90, barVisual: barVisual),
            BarChartItemData(title: "Text", valueTitle: "95%", value: 95, barVisual: barVisual)
        ]
        
        for index in 0..<data.count {
            let entry = BarChartDataEntry(x: Double(index), y: data[index].value)
            entries.append(entry)
        }
     
        chartView.drawBarShadowEnabled = true
        chartView.isAlignValuesOnTop = true
        chartView.xAxis.valueFormatter = VerticalBarXAxisLabelFormatter(barItems: data)
        chartView.xAxis.setLabelCount(data.count, force: false)
        let chartDataSet = BarChartDataSet(entries: entries, label: "")
        chartDataSet.barCornerRadius = 10
        chartDataSet.colors = [#colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)]
        chartDataSet.barShadowColor = #colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 0.9568627451, alpha: 1)
        chartDataSet.valueFont = FontFamily.customFont.displayFontWithSize(10, attributeType: .bold)
        chartDataSet.drawValuesEnabled = true
        let chartData = BarChartData(dataSet: chartDataSet)
        chartData.barWidth = 0.17
        chartView.data = chartData
       
        chartView.legend.enabled = false
        chartView.xAxis.enabled = true
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.yOffset = 10
        
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.avoidFirstLastClippingEnabled = true
        chartView.xAxis.drawGridLinesBehindDataEnabled = false
        chartView.xAxis.gridAntialiasEnabled = false
        chartView.xAxis.drawAxisLineEnabled = false
        chartView.xAxis.labelTextColor = .black
        chartView.leftAxis.enabled = false
        chartView.leftAxis.drawLabelsEnabled = false
        chartView.rightAxis.enabled = false

    }
}
