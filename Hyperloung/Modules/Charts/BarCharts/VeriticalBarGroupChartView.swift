//
//  VeriticalBarGroupChartView.swift
//  ChartsDemo-iOS-Swift
//

import UIKit
import Charts

struct GroupChartItem {
    struct Part {
        var value: Double
        var color: UIColor
    }
    var title: String
    var parts: [Part]
}

class VeriticalBarGroupChartView: UIView {
    var chartView: BarChartView!
    var visual: StackBarChartVisual = StackBarChartVisual.defaultVisual
    private var numOfBar: Int = 4
    var chartItems: [StackBarChartItemData] = []
    var leftAxisUnit: String = ""

    // MARK: LifeCycle
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    private func customInit() {
        let width = CGFloat(visual.width * numOfBar + visual.space * (numOfBar - 1)) + 50
        chartView = BarChartView(frame: CGRect(x: 0, y: 0, width: width, height: 200))
        addSubview(chartView)
        chartView.centralize()
        chartView.setBottom(0, relativeToView: self)
        chartView.setWidth(width)
        setup(barLineChartView: chartView)
    }
    
    func updateChartViewSize() {
        let groupSpace = 0.5
        let barSpace = 0.05
        let barWidth = 0.1
        // (0.3 + 0.05) * 2 + 0.3 = 1.00 -> interval per "group"
        var width = (barSpace + barWidth)
        width = width * Double(chartView.data?.dataSets.count ?? 0)
        width = width + groupSpace
        
        var frame = chartView.frame
        frame.size.width = CGFloat(width)
        chartView.frame = frame
    }

    func setup(barLineChartView chartView: BarChartView) {
        chartView.isUserInteractionEnabled = false
        
        chartView.drawBarShadowEnabled = false
        chartView.drawValueAboveBarEnabled = true
        chartView.extraBottomOffset = 16

        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.axisLineColor = .clear
        xAxis.granularityEnabled = true
        xAxis.drawGridLinesEnabled = false
        xAxis.centerAxisLabelsEnabled = true

        let rightAxis = chartView.rightAxis
        rightAxis.enabled = false
        
        let l = chartView.legend
        l.horizontalAlignment = .center
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.drawInside = false
        l.form = .circle
        l.formSize = 9
        l.font = UIFont.normal(size: 10)
        l.xEntrySpace = 4
    }

    func setData(titles: [String], colors: [UIColor], labels: [String], items: [[Double]], valueTitleList: [[String]]) {
        
        chartView.xAxis.valueFormatter = GroupBarXAxisLabelFormatter(labels: titles)

        var listDataEntries: [[BarChartDataEntry]] = []

        for i in 0..<items.count {
            let values = items[i]
            var dataEntries: [BarChartDataEntry] = []
            let valueTitles = valueTitleList[i]
            for j in 0..<values.count {
                dataEntries.append(BarChartDataEntry(x: Double(j), y: values[j], data: valueTitles.count == values.count ? valueTitles[j] : nil))
            }
            listDataEntries.append(dataEntries)

        }
        var dataSets: [BarChartDataSet] = []
        for i in 0..<listDataEntries.count {
            let chartDataSet = BarChartDataSet(entries: listDataEntries[i], label: labels[i])
            chartDataSet.barCornerRadius = 4
            chartDataSet.colors = [colors[i]]
            chartDataSet.valueFont = UIFont.bold(size: 12)
            let valueTitles = valueTitleList[i]
            if valueTitles.isEmpty {
                chartDataSet.drawValuesEnabled = false
            } else {
                chartDataSet.drawValuesEnabled = true
                chartDataSet.valueFormatter = GroupBarValueFormatter()
            }
            
            dataSets.append(chartDataSet)
        }

        let chartData = BarChartData(dataSets: dataSets)


        let groupSpace = 0.7
        let barSpace = 0.05
        let barWidth = 0.1
        
//        let barSize = 8.0
//        let spaceSize = 4.0
//        let spaceGroup = 20.0
        
//        (0.1 + 0.05) * 3 + 0.45
        
        // (0.3 + 0.05) * 2 + 0.3 = 1.00 -> interval per "group"
//        let groupSpace = 24.0
//        let barSpace = 2.0
//        let barWidth = 8.0
//        // (0.3 + 0.05) * 2 + 0.3 = 1.00 -> interval per "group"

//        let width = (barSpace + barWidth) * Double(items.count) + groupSpace
//        var frame = chartView.frame
//        frame.size.width = CGFloat(((barSize + barSpace) * Double(titles.count) + spaceGroup) * Double(listDataEntries.count)) * 2
        
        chartView.frame = bounds
        
        let groupCount = titles.count
        let startYear = 0

//        chartData.barWidth = Double(barWidth);
//        chartView.xAxis.axisMinimum = Double(0)
//        let gg = chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
//        chartView.xAxis.axisMaximum = Double(startYear) + gg * Double(groupCount)
//
//        chartData.groupBars(fromX: Double(startYear), groupSpace: groupSpace, barSpace: barSpace)
        //chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)

        
        chartData.barWidth = barWidth
        // restrict the x-axis range
        chartView.xAxis.axisMinimum = Double(startYear)
        // groupWidthWithGroupSpace(...) is a helper that calculates the width each group needs based on the provided parameters
        chartView.xAxis.axisMaximum = Double(startYear) + chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace) * Double(groupCount)
        chartData.groupBars(fromX: Double(startYear), groupSpace: groupSpace, barSpace: barSpace)
        
        chartView.data = chartData
    }
}


class GroupBarXAxisLabelFormatter: NSObject, IAxisValueFormatter {
    var labels: [String]
    
    init(labels: [String]) {
        self.labels = labels
    }
 
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let index = Int(value)
        if index >= 0,  index < labels.count {
            return labels[index]
        }
        return ""
    }
}

class GroupBarValueFormatter: NSObject, IValueFormatter {
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        if let title = entry.data as? String {
            return title
        }
        
        return ""
    }
}

