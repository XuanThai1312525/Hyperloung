//
//  Line1Chart.swift
//  Chart
//
//  Created by trinhhcse on 01/11/2021.
//

import Foundation
import UIKit
import Charts // You need this line to be able to use Charts Library
class aos_ma_line_03: UIView , ChartViewDelegate{
   var chartView: LineChartView!
    var chartViewDataSet: LineChartDataSet!
    var chartViewData : [Int] = [8,24,16,36]
    var chartViewLabels: [String] = ["1A","2B","3C","4D"]
    var hideSelectedValueTask: DispatchWorkItem?
    var circleColors = ["#246FEE".color]
    var lineColors = ["#246FEE".color]
    var defaultLabelColor  = "#DDDDDD".color
    var selectedValueColor = "#222222".color
    var selectedRoundColor = "#DDDDDD".color.cgColor
    var defaultFont = UIFont.systemFont(ofSize: 11)
    var defaultValueBottomSpacing: CGFloat = 0//10 temp to fix 0 , Open when using folk
    var defaultValueLabel = "A"
    
    
    func setupChartView(){
    
        chartView = LineChartView()
        self.addSubview(chartView)
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        chartView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        chartView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        chartView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        var lineChartEntry  = [ChartDataEntry]() //this is the Array that will eventually be displayed on the graph.
        
        
        //here is the for loop
        for i in 0..<chartViewData.count {
            
            let value = ChartDataEntry(x: Double(i), y: Double(chartViewData[i]))
            lineChartEntry.append(value) // here we add it to the data set
        }
        
        chartViewDataSet = LineChartDataSet(entries: lineChartEntry, label: "")
        chartViewDataSet.circleHoleColor = NSUIColor.white
        chartViewDataSet.circleColors = circleColors
        chartViewDataSet.colors = lineColors //Sets the colour to blue
        chartViewDataSet.mode = .linear
        chartViewDataSet.valueFormatter = LineChartDataSetValueFormatter(label: defaultValueLabel)
        chartViewDataSet.valueColors = chartViewData.map{_ in defaultLabelColor}.dropLast()
        chartViewDataSet.valueFont = defaultFont
        chartViewDataSet.circleRadius = 4
        chartViewDataSet.circleHoleRadius = 2
        chartViewDataSet.lineWidth = 3
        chartViewDataSet.highlightLineWidth = 0
//        chartViewDataSet.valueBottomSpacing = defaultValueBottomSpacing
        let data = Charts.LineChartData()
        data.addDataSet(chartViewDataSet)
        
        chartView.data = data
//        lineChartView.delegate = self
        chartView.dragEnabled = false
        chartView.pinchZoomEnabled = false
        chartView.doubleTapToZoomEnabled = false
        chartView.legend.enabled = false
        chartView.clipDataToContentEnabled = false
        chartView.clipValuesToContentEnabled = false
        chartView.setExtraOffsets(left: 30, top: 30, right: 30, bottom: 30)
        
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: chartViewData.map{"\($0)"})
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.avoidFirstLastClippingEnabled = true
        chartView.xAxis.drawGridLinesBehindDataEnabled = false
        chartView.xAxis.gridAntialiasEnabled = false
        chartView.xAxis.drawAxisLineEnabled = false
        chartView.xAxis.labelTextColor = defaultLabelColor
        chartView.xAxis.valueFormatter = LineChartXAxisValueFormatter(labels: chartViewLabels)
        chartView.xAxis.setLabelCount(chartViewData.count, force: true)
        
        chartView.rightAxis.drawAxisLineEnabled = false
        chartView.rightAxis.drawLabelsEnabled = false
        
        chartView.leftAxis.drawAxisLineEnabled = false
        chartView.leftAxis.drawLabelsEnabled = false
        chartView.leftAxis.enabled = false
        chartView.rightAxis.enabled = false
        chartView.delegate = self
        
        
        chartView.drawMarkers = true
        chartView.marker = Marker(color: selectedRoundColor, font: defaultFont, bottomSpacing: defaultValueBottomSpacing, values:chartViewData, label: defaultValueLabel)
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        chartView.drawMarkers = true
        let index = Int(entry.x)
        var colors = chartViewData.map{_ in defaultLabelColor}
        colors[index] = selectedValueColor
        chartViewDataSet.valueColors = colors
        hideSelectedValueTask?.cancel()
        
        hideSelectedValueTask = DispatchWorkItem(block: {
            self.chartView.drawMarkers = false
            self.chartViewDataSet.valueColors = self.chartViewData.map{_ in self.defaultLabelColor}
            self.chartView.setNeedsDisplay()
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: hideSelectedValueTask!)
    }
    
    func chartViewDidEndPanning(_ chartView: ChartViewBase) {
        print(chartView)
    }
    
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        print("test")
    }
    
    func chartView(_ chartView: ChartViewBase, animatorDidStop animator: Animator) {
        print("test")
    }
    
    func chartTranslated(_ chartView: ChartViewBase, dX: CGFloat, dY: CGFloat) {
        print("test")
    }
    
    func chartScaled(_ chartView: ChartViewBase, scaleX: CGFloat, scaleY: CGFloat) {
        print("test")
    }
    
}

class Formattor {
    static func getValueDescription(_ value: Double, _ label: String) -> String {
        return getValueDescription(Int(value), label)
    }
    
    static func getValueDescription(_ value: Int, _ label: String) -> String {
        return "\(value)\(label)"
    }
}

class LineChartDataSetValueFormatter: IValueFormatter {
    let label: String
    
    init(label: String) {
        self.label = label
    }
    
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        return Formattor.getValueDescription(value,label)
    }
}

class LineChartXAxisValueFormatter: IAxisValueFormatter {
    let labels: [String]
    
    init(labels: [String]) {
        self.labels = labels
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let index = Int(value)
        return labels[index]
    }
}


class Marker: IMarker {
    var selectedEntry: ChartDataEntry?
    let selectedRoundColor: CGColor
    let font: UIFont
    let bottomSpacing: CGFloat
    let values: [Int]
    let label: String
    
    init(color: CGColor, font: UIFont, bottomSpacing: CGFloat, values: [Int], label: String ) {
        self.selectedRoundColor = color
        self.font = font
        self.bottomSpacing = bottomSpacing
        self.values = values
        self.label = label
    }
    
    var offset: CGPoint = .zero
    
    func offsetForDrawing(atPoint: CGPoint) -> CGPoint {
        return .zero
    }
    
    func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        selectedEntry = entry
    }
    
    func draw(context: CGContext, point: CGPoint) {
        //Need to be draw arrow later on and config base on Device dimension
        let index = Int(selectedEntry?.x ?? 0);
        let selectedValue = values[index]
        let selectedStringValue = Formattor.getValueDescription(selectedValue,label)
        let selectedStringWidth = selectedStringValue.widthOfString(usingFont: font)
        let spacing: CGFloat = 4
        let x: CGFloat  = point.x - selectedStringWidth/2 - spacing
        let y: CGFloat = point.y - font.lineHeight*1.5 - bottomSpacing - spacing //5 is horizontal spacing
        let width: CGFloat = selectedStringWidth + spacing*2
        let height: CGFloat = font.lineHeight + spacing*2
        let rectFrame = CGRect(x: x, y: y, width: width, height: height)
        let clipPath = UIBezierPath(roundedRect: rectFrame, cornerRadius: 10).cgPath
        context.addPath(clipPath)
        context.setLineWidth(1)
        context.setStrokeColor(selectedRoundColor)
    
        context.closePath()
        context.strokePath()
    }
}
