//
//  Line2ChartView.swift
//  Chart
//
//  Created by trinhhcse on 02/11/2021.
//

import UIKit

import UIKit
import Charts // You need this line to be able to use Charts Library
import class Charts.LineChartData
class aos_ma_line_04: UIView , ChartViewDelegate{
    
    @IBOutlet weak var chartContainer: UIView!
    var chartView: LineChartView!
    var chartViewDataSet: LineChartDataSet!
    var chartViewData : [Int] = [8,24,16,36]
    var chartViewLabels: [String] = ["1A","2B","3C","4D"]
    var hideSelectedValueTask: DispatchWorkItem?
    var circleColors: [NSUIColor]!
    var lineColors = ["#246FEE".color]
    var defaultLabelColor  = "#DDDDDD".color
    var selectedValueColor = "#222222".color
    var selectedRoundColor = "#DDDDDD".color.cgColor
    var defaultFont = UIFont.systemFont(ofSize: 11)
    var defaultValueBottomSpacing: CGFloat = 10
    var defaultValueLabel = "A"
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupLine1ChartView()
    }
    
    func setupLine1ChartView(){
    
        chartView = LineChartView()
        chartContainer.addSubview(chartView)
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.leftAnchor.constraint(equalTo: chartContainer.leftAnchor).isActive = true
        chartView.rightAnchor.constraint(equalTo: chartContainer.rightAnchor).isActive = true
        chartView.topAnchor.constraint(equalTo: chartContainer.topAnchor).isActive = true
        chartView.bottomAnchor.constraint(equalTo: chartContainer.bottomAnchor).isActive = true
        
        var lineChartEntry  = [ChartDataEntry]() //this is the Array that will eventually be displayed on the graph.
        let circles = [Double(chartViewData.count-1)]
        
        //here is the for loop
        for i in 0..<chartViewData.count {
            let value = ChartDataEntry(x: Double(i), y: Double(chartViewData[i]))
            lineChartEntry.append(value) // here we add it to the data set
        }
        
        circleColors =  chartViewData.map{_ in lineColors.first!}
        circleColors[0] = "#246FEE".color
        circleColors[circleColors.count-1] = "#246FEE".color
        
        chartViewDataSet = LineChartDataSet(entries: lineChartEntry, label: "")
        chartViewDataSet.circleHoleColor = lineColors.first!
        chartViewDataSet.circleColors = circleColors//["#000000".color] + chartViewData.dropFirst()
        chartViewDataSet.colors = lineColors //Sets the colour to blue
        chartViewDataSet.mode = .cubicBezier
        chartViewDataSet.valueFormatter = LineChart2DataSetValueFormatter(label: defaultValueLabel, values: chartViewData)
        chartViewDataSet.valueColors = chartViewData.map{_ in defaultLabelColor}
        chartViewDataSet.valueFont = defaultFont
        chartViewDataSet.circleRadius = 4
//        chartViewDataSet.circles = circles
        chartViewDataSet.circleHoleRadius = 2
        chartViewDataSet.lineWidth = 3
        chartViewDataSet.highlightLineWidth = 0
//        chartViewDataSet.valueBottomSpacing = defaultValueBottomSpacing
        let data = Charts.LineChartData()
        data.addDataSet(chartViewDataSet)
        
        chartView.data = data
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
        chartView.marker = Line2Marker(color: selectedRoundColor, font: defaultFont, bottomSpacing: defaultValueBottomSpacing, values:chartViewData, label: defaultValueLabel)
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

class LineChart2DataSetValueFormatter: IValueFormatter {
    let label: String
    let values: [Int]
    
    init(label: String, values: [Int]) {
        self.label = label
        self.values = values
    }
    
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        let index = Int(entry.x)
        return index == (values.count - 1) ? Formattor.getValueDescription(value,label) : ""
    }
}


class Line2Marker: IMarker {
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
        if(index == 0 || index == values.count - 1) {
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
}
