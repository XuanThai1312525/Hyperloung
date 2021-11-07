//
//  HyperLineChartView.swift
//  Hyperloung
//
//  Created by trinhhcse on 04/11/2021.
//

import Foundation
import UIKit
import Charts

struct HyperLineData {
    var value: Double
    var label: String
    var appearance: HyperLineDataAppearance
}

struct HyperLineDataAppearance {
    var textColor: UIColor
    var circleColor: UIColor
    var lineColor: UIColor
    var isShowCircle: Bool
    var isShowValue: Bool! = false
    var isShowMark: Bool?
    var isHightLight: Bool = false
}

struct HyperLineDataSetAppearance {
    var selectedValueColor: UIColor
    var selectedValueRoundColor: UIColor
    var circleHoleColor: UIColor
    var circleRadius: CGFloat
    var circleHoleRadius: CGFloat
    var lineWidth: CGFloat
    var tooltipPadding: CGFloat
    var bottomValueToCircle: CGFloat
    var lineDashAppearance: HyperLineDataDashAppearance?
}

struct HyperLineChartDataSet {
    var data: [HyperLineData]
    var appearance: HyperLineDataSetAppearance
}

struct HyperLineDataDashAppearance {
    var lineDashLengths: [CGFloat]? = [2,3]
}

struct HyperLineChartConfig {
    var dataSets: [HyperLineChartDataSet]
    var xAxisData: [String]
    var descriptions: [CircleInfoData]
    var appearance: HyperLineAppearance
}

struct HyperLineLeftAxisConfig {
    var labelCount: Int
    var minValue: Double
    var maxValue: Double
    var xOffset: Double
    var valueFormatter: IAxisValueFormatter
    var labelColor: UIColor
    var entries: [Double]?
}
struct HyperLineAppearance {
    var font: UIFont
    var highLightValueFont: UIFont
    var xAxisValueColor: UIColor
   
    var lineMode: LineChartDataSet.Mode
    var getValueFormatter: ([HyperLineData]) -> IValueFormatter
    var xAxisFormatter: IAxisValueFormatter
    var leftAxisConfig: HyperLineLeftAxisConfig?
    var descriptionContainerHeight: Double?
}

class HyperLineChartView: UIView , ChartViewDelegate{
    @IBOutlet weak var chartContainer: UIView!
    @IBOutlet weak var descriptionContainerView: UIStackView!
    @IBOutlet weak var bottomContainerView: UIView!
    @IBOutlet weak var descriptionContainerHeightConstraint: NSLayoutConstraint!
    
    var config: HyperLineChartConfig!
    
    var chartView: LineChartView!
    var selectedHighLight: Highlight?
//    var hideSelectedValueTask: DispatchWorkItem?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupUI(config: HyperLineChartConfig) {
        self.config = config
        self.setupChartView()
        self.setupDescriptionView()
    }
    
    private func setupDescriptionView() {
        if(config.descriptions.isEmpty){
            bottomContainerView.isHidden = true
        }
        config.descriptions.forEach { cirlceInfoData in
            let circleInfoView: CircleInfoView = .fromNib()
            circleInfoView.bindingUI(data: cirlceInfoData)
            self.descriptionContainerView.addArrangedSubview(circleInfoView)
        }
        self.descriptionContainerHeightConstraint.constant = CGFloat(config.appearance.descriptionContainerHeight ?? 50)
    }
    
    private func setupChartView(){
        let datas = config.dataSets
        let appearance = config.appearance
        let xAxisData = config.xAxisData
        
        let lineChartData = Charts.LineChartData()
        
        chartView = LineChartView()
        chartContainer.addSubview(chartView)
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.leftAnchor.constraint(equalTo: chartContainer.leftAnchor).isActive = true
        chartView.rightAnchor.constraint(equalTo: chartContainer.rightAnchor).isActive = true
        chartView.topAnchor.constraint(equalTo: chartContainer.topAnchor).isActive = true
        chartView.bottomAnchor.constraint(equalTo: chartContainer.bottomAnchor).isActive = true
        
        var hightLight: Highlight?
        for dataSetIndex in 0..<datas.count {
            let dataSet = datas[dataSetIndex]
            
            var lineChartEntry  = [ChartDataEntry]() //this is the Array that will eventually be displayed on the graph.
            
            var cirlces: [Double] = []
            let data = dataSet.data
            //here is the for loop
            for i in 0..<data.count {
                let item = data[i]
                let x = Double(i)
                let value = ChartDataEntry(x: x, y: Double(item.value))
                lineChartEntry.append(value) // here we add it to the data set
                
                if(item.appearance.isShowCircle) {
                    cirlces.append(x)
                }
                
                if(item.appearance.isHightLight) {
                    hightLight = Highlight(x: x, y: Double(item.value), dataSetIndex: dataSetIndex)
                }
            }
            
            let dataSetAppearance = dataSet.appearance
            let chartViewDataSet = LineChartDataSet(entries: lineChartEntry, label: "")
            chartViewDataSet.circleHoleColor = dataSetAppearance.circleHoleColor
            chartViewDataSet.circleColors = data.map{$0.appearance.circleColor}
            chartViewDataSet.colors = data.map{$0.appearance.lineColor} //Sets the colour to blue
            chartViewDataSet.mode = appearance.lineMode
            chartViewDataSet.valueFormatter = appearance.getValueFormatter(data)
            chartViewDataSet.valueColors = data.map{$0.appearance.textColor}
            chartViewDataSet.valueFont = appearance.font
            chartViewDataSet.highLightValueFont = appearance.highLightValueFont
            chartViewDataSet.circleRadius = dataSetAppearance.circleRadius
            chartViewDataSet.circles = cirlces
            chartViewDataSet.circleHoleRadius = dataSetAppearance.circleHoleRadius
            chartViewDataSet.lineWidth = dataSetAppearance.lineWidth
            chartViewDataSet.highlightLineWidth = 0
            chartViewDataSet.valueBottomSpacing = dataSetAppearance.bottomValueToCircle
            if let lineDashAppearance = dataSetAppearance.lineDashAppearance {
                chartViewDataSet.lineDashLengths = lineDashAppearance.lineDashLengths
            }
            
            lineChartData.addDataSet(chartViewDataSet)
        }
        
        
        chartView.data = lineChartData
        chartView.dragEnabled = false
        chartView.pinchZoomEnabled = false
        chartView.doubleTapToZoomEnabled = false
        chartView.legend.enabled = false
        chartView.clipDataToContentEnabled = false
        chartView.clipValuesToContentEnabled = false
        chartView.setExtraOffsets(left: 30, top: 45, right: 30, bottom: 0)

        
        chartView.xAxis.valueFormatter = appearance.xAxisFormatter
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.avoidFirstLastClippingEnabled = true
        chartView.xAxis.drawGridLinesBehindDataEnabled = false
        chartView.xAxis.gridAntialiasEnabled = false
        chartView.xAxis.drawAxisLineEnabled = false
        chartView.xAxis.labelTextColor = appearance.xAxisValueColor
        chartView.xAxis.setLabelCount(xAxisData.count, force: true)
        chartView.rightAxis.drawAxisLineEnabled = false
        chartView.rightAxis.drawLabelsEnabled = false
        chartView.rightAxis.enabled = false
        
        if let leftAxisConfig = appearance.leftAxisConfig  {
            chartView.leftAxis.drawAxisLineEnabled = false
            chartView.leftAxis.drawLabelsEnabled = true
            chartView.leftAxis.labelXOffset = CGFloat(-leftAxisConfig.xOffset)
            chartView.leftAxis.valueFormatter = leftAxisConfig.valueFormatter
            chartView.leftAxis.labelTextColor = leftAxisConfig.labelColor
            chartView.leftAxis.setLabelCount(leftAxisConfig.labelCount, force: true)
            chartView.leftAxis.axisMinimum = leftAxisConfig.minValue
            chartView.leftAxis.axisMaximum = leftAxisConfig.maxValue

            chartView.leftAxis.enabled = true
            if let entries = leftAxisConfig.entries {
                chartView.leftAxis.entries = entries
                chartView.leftAxis.isForceEntriesEnable = true
            }
            
        } else {
            chartView.leftAxis.enabled = false
        }
        
        
        chartView.rightAxis.valueFormatter = appearance.xAxisFormatter
        chartView.delegate = self
        chartView.noDataText = ""
        chartView.noDataTextColor = UIColor.clear
        
        
        chartView.drawMarkers = true
        chartView.marker = HyperLineMarker(config: config, chartView: chartView)
        
        chartView.highlightValue(hightLight,callDelegate: true)
    }
    
    internal func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        //Prevent duplicate
        if selectedHighLight == highlight {
            return
        }
        selectedHighLight = highlight
        
        chartView.drawMarkers = true
        let dataSets = chartView.data!.dataSets
        let index: Int = dataSets.firstIndex{$0.entryIndex(entry: entry) >= 0} ?? 0
        let chartViewSelectedDataSet = dataSets[index]
        let selectedDataSet = config.dataSets[index]
        let selectedData = selectedDataSet.data
        
        //Reset all chart color
        for i in 0..<dataSets.count {
            let dataSet = config.dataSets[i]
            let data = dataSet.data
            let chartViewDataSet = dataSets[i]
            chartViewDataSet.valueColors = data.map{$0.appearance.textColor}
        }

        let entryIndex = Int(entry.x);
        var colors = selectedData.map{$0.appearance.textColor}
        colors[entryIndex] = selectedDataSet.appearance.selectedValueColor
        chartViewSelectedDataSet.valueColors = colors
        
//        hideSelectedValueTask?.cancel()
//
//        hideSelectedValueTask = DispatchWorkItem(block: {
//            chartView.drawMarkers = false
//            chartViewSelectedDataSet.valueColors = selectedData.map{$0.appearance.textColor}
//            chartView.setNeedsDisplay()
//        })

//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: hideSelectedValueTask!)
    }
    
    internal func chartViewDidEndPanning(_ chartView: ChartViewBase) {
        print("chartViewDidEndPanning")
    }
    
    internal func chartValueNothingSelected(_ chartView: ChartViewBase) {
        print("chartValueNothingSelected")
        chartView.highlightValue(selectedHighLight)
    }
    
    internal func chartView(_ chartView: ChartViewBase, animatorDidStop animator: Animator) {
        print("chartView")
    }
    
    internal func chartTranslated(_ chartView: ChartViewBase, dX: CGFloat, dY: CGFloat) {
        print("chartTranslated")
    }
    
    internal func chartScaled(_ chartView: ChartViewBase, scaleX: CGFloat, scaleY: CGFloat) {
        print("chartScaled")
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

class HyperLineMarker: IMarker {
    var selectedEntry: ChartDataEntry?
    var config: HyperLineChartConfig
    var label: String?
    var isShowMark: Bool = false
    weak var chartView: ChartViewBase?
    
    init(config: HyperLineChartConfig, chartView: ChartViewBase ) {
        self.config = config
        self.chartView = chartView
    }
    
    
    var offset: CGPoint = .zero
    
    func offsetForDrawing(atPoint: CGPoint) -> CGPoint {
        return .zero
    }
    
    func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        selectedEntry = entry
        let dataSets = chartView?.data!.dataSets
        let index: Int = dataSets?.firstIndex{$0.entryIndex(entry: entry) >= 0} ?? 0
        let selectedDataSet = config.dataSets[index]
        if selectedDataSet.data.count > Int(entry.x), let hyperLineData = selectedDataSet.data[Int(entry.x)] as? HyperLineData{
            label = Formattor.getValueDescription(hyperLineData.value, hyperLineData.label)
            isShowMark = hyperLineData.appearance.isShowMark ?? hyperLineData.appearance.isShowValue ?? false
        }
        
    }
    
    func draw(context: CGContext, point: CGPoint) {
        //Need to be draw arrow later on and config base on Device dimension
        if let selectedEntry = selectedEntry, let label = label , isShowMark {
            let appearance = config.appearance;
            let dataSets = chartView?.data!.dataSets
            let index: Int = dataSets?.firstIndex{$0.entryIndex(entry: selectedEntry) >= 0} ?? 0
            let selectedDataSet = config.dataSets[index]
            let selectedDataSetAppearance = selectedDataSet.appearance
            
            let selectedStringWidth = label.widthOfString(usingFont: appearance.font)
            let spacing: CGFloat = 10
            let x: CGFloat  = point.x - selectedStringWidth/2 - spacing
            let y: CGFloat = point.y - appearance.font.lineHeight*1.5 - selectedDataSetAppearance.bottomValueToCircle - spacing/2 //5 is horizontal spacing
            let roundWidth: CGFloat = selectedStringWidth + spacing*2
            let roundHeight: CGFloat = appearance.font.lineHeight + spacing
            let rectFrame = CGRect(x: x, y: y, width: roundWidth, height: roundHeight)
            
            context.setShadow(offset: CGSize(width: 1, height: 0.5), blur: 1,color:#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor)
            let roundPath = UIBezierPath(roundedRect: rectFrame, cornerRadius: roundHeight/2).cgPath
            context.addPath(roundPath)
            context.setLineWidth(0.5)
            context.setStrokeColor(selectedDataSetAppearance.selectedValueRoundColor.cgColor)
            
            let rectangleRect = CGRect(x: x+roundWidth/3, y: y+roundHeight, width: roundWidth/3, height: roundHeight/4)
            let rectanglePath = createTipPath(roundRect: rectangleRect).cgPath
            context.addPath(rectanglePath)
            context.setLineWidth(0.5)
            context.setStrokeColor(selectedDataSetAppearance.selectedValueRoundColor.cgColor)
            context.strokePath()
            
            let path = UIBezierPath()
            path.move(to:  CGPoint(x: rectangleRect.maxX, y: rectangleRect.minY))
            path.addLine(to: CGPoint(x: rectangleRect.minX, y: rectangleRect.minY))
            context.addPath(path.cgPath)
            context.setLineWidth(1)
            context.setShadow(offset: CGSize(width: 1, height: 1), blur: 1,color: "#FFFFFF".color.cgColor)
            context.setStrokeColor(UIColor.white.cgColor)
            context.strokePath()
            
            context.closePath()
            
            
        }
        
        
    }
    
    func createTipPath(roundRect: CGRect) -> UIBezierPath{
        let trianglePath = UIBezierPath()
        trianglePath.move(to: CGPoint(x: roundRect.minX, y: roundRect.minY))
        trianglePath.addLine(to: CGPoint(x: roundRect.midX, y: roundRect.maxY))
        trianglePath.addLine(to: CGPoint(x: roundRect.maxX, y: roundRect.minY))
    
        trianglePath.close()
        return trianglePath
    }
}
