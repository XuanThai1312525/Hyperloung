//
//  VerticalBarChart.swift
//  Hyperloung
//

import UIKit
import Charts

struct ChartVisual {
    var space: Int
    var width: Int
    
    static var defaultVisual: ChartVisual {
        return ChartVisual(space: 24, width: 32)
    }
}

struct BarVisual {
    var radius: Double
    var normalColor: UIColor
    var highlightColor: UIColor
    var normalTextColor: UIColor
    var highlightTextColor: UIColor
    
    var isHighlight: Bool = false
    
    static func defaultVisual() -> BarVisual {
        return BarVisual(radius: 4.0, normalColor: UIColor.gray, highlightColor: UIColor.cyan, normalTextColor: UIColor.red, highlightTextColor: UIColor.red)
    }
}

class VeritalBarChartView: UIView {
    // MARK: Properties
    var chartView: BarChartView!
    var visual: ChartVisual = ChartVisual.defaultVisual
    var numOfBar: Int = 4
    
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
        let width = CGFloat(visual.width * numOfBar + visual.space * (numOfBar - 1))
        chartView = BarChartView(frame: CGRect(x: 0, y: 0, width: width, height: 100))
        addSubview(chartView)
        chartView.setCenterX(0, relativeToView: self)
        chartView.setCenterY(0, relativeToView: self)
        chartView.setWidth(width)
        chartView.setHeight(200)
        
        setup(barLineChartView: chartView)
        
        setDataCount(numOfBar, range: 50, highlight: 2)
        
    }
    
    // MARK: Functions
    /*
     Because BarChartView will calculate the with of bar by percentage,
     It will calculate by with and number of item
     But our design persist  with and space so the with of BarChartView will change by number of view and visual
     **/
    func setNumOfBar(num: Int) {
        
    }
    
    func setup(barLineChartView chartView: BarLineChartViewBase) {
        chartView.chartDescription?.enabled = false
        
        chartView.dragEnabled = false
        chartView.setScaleEnabled(false)
        chartView.pinchZoomEnabled = false
        
        
        // ChartYAxis *leftAxis = chartView.leftAxis;
        chartView.leftAxis.enabled = false
        chartView.rightAxis.enabled = false
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.leftAxis.drawLabelsEnabled = false // Hide label
        chartView.legend.enabled = false

        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelTextColor = .purple
        
        var titles: [String] = []
        for i in 0..<numOfBar*2 {
            titles.append("날짜" )
        }
        

        chartView.xAxis.yOffset = 10 // spacing bottom  bar title - bar rect
        
        // set bottom item titles
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: titles)
        chartView.xAxis.setLabelCount(numOfBar, force: false)
        chartView.highlightValues([Highlight(x: 2, dataSetIndex: 1, stackIndex: 0)])
        
    }
    
    func setDataCount(_ count: Int, range: UInt32, highlight: Int) {
        let yVals = (0..<count).map { (i) -> BarChartDataEntry in
            let val = Double(46.0)
            var barVisual = BarVisual.defaultVisual()
            barVisual.isHighlight = i == 1
            return BarChartDataEntry(x: Double(i), y: val, data: barVisual)
        }
        
        var set1: HyperChartBaseDataSet = HyperChartBaseDataSet(entries: yVals, label: "label ")
        set1.colors = [.black, .white] // array always have more than 1 item so "color(atIndex index: Int)" to be called
        set1.drawValuesEnabled = true
        
        let data = BarChartData(dataSet: set1)
        data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 10)!)
        data.setValueTextColor( .black)
        data.barWidth = calculateBarWidth()
        
        chartView.data = data
        
    }
    
    func calculateBarWidth() -> Double {
        let width = CGFloat(visual.width * numOfBar + visual.space * (numOfBar - 1))
        return Double(visual.width * numOfBar) / Double(width)
    }
    
}

class CustomXAxis: XAxis {
    
    
    override func getFormattedLabel(_ index: Int) -> String {
        return "AA"
    }
    
    
}

//    func setBarChartData(xValues: [String], yValues: [Double], label: String) {
//
//        var dataEntries: [BarChartDataEntry] = []
//
//        for i in 0..<yValues.count {
//            let dataEntry = BarChartDataEntry(x: Double(i), y: yValues[i])
//            dataEntries.append(dataEntry)
//        }
//
//        let chartDataSet = BarChartDataSet(values: dataEntries, label: label)
//        let chartData = BarChartData(dataSet: chartDataSet)
//
//        let chartFormatter = BarChartFormatter(labels: xValues)
//        let xAxis = XAxis()
//        xAxis.valueFormatter = chartFormatter
//        self.xAxis.valueFormatter = xAxis.valueFormatter
//
//        self.data = chartData
//    }

class HyperChartBaseDataSet: BarChartDataSet {
    override init(entries: [ChartDataEntry]?, label: String?) {
        super.init(entries: entries, label: label)
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    override func color(atIndex index: Int) -> NSUIColor {
        let entry = entries[index]
        if let visual = entry.data as? BarVisual {
            return visual.isHighlight ? visual.highlightColor : visual.normalColor
        }
        return UIColor.red
    }
    
    override func valueTextColorAt(_ index: Int) -> NSUIColor {
        let entry = entries[index]
        if let visual = entry.data as? BarVisual {
            return visual.isHighlight ? visual.highlightTextColor : visual.normalTextColor
        }
        
        return UIColor.red
    }
}
