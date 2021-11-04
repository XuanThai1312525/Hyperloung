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
}

struct HyperLineChartConfig {
    var data: [[HyperLineData]]
    var xAxisData: [String]
    var descriptions: [CircleInfoData]
    var appearance: HyperLineAppearance
}

struct HyperLineAppearance {
    var font: UIFont
    var selectedValueColor: UIColor
    var xAxisValueColor: UIColor
    var circleHoleColor: UIColor
    var circleRadius: CGFloat
    var circleHoleRadius: CGFloat
    var lineWidth: CGFloat
    var tooltipPadding: CGFloat
    var bottomValueToCircle: CGFloat
    var lineMode: LineChartDataSet.Mode
    var getValueFormatter: ([HyperLineData]) -> IValueFormatter
    var xAxisFormatter: IAxisValueFormatter
}

class HyperLineChartView: UIView , ChartViewDelegate{
    @IBOutlet weak var chartContainer: UIView!
    @IBOutlet weak var descriptionContainerView: UIStackView!
    @IBOutlet weak var bottomContainerView: UIView!
    
    var config: HyperLineChartConfig!
    
    var chartView: LineChartView!
    var hideSelectedValueTask: DispatchWorkItem?
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
    }
    
    private func setupChartView(){
        let datas = config.data
        let appearance = config.appearance
        let xAxisData = config.xAxisData
        
        let lineChartData = Charts.LineChartData()
        
        for i in 0..<datas.count {
            let data = datas[i]
            chartView = LineChartView()
            chartContainer.addSubview(chartView)
            chartView.translatesAutoresizingMaskIntoConstraints = false
            chartView.leftAnchor.constraint(equalTo: chartContainer.leftAnchor).isActive = true
            chartView.rightAnchor.constraint(equalTo: chartContainer.rightAnchor).isActive = true
            chartView.topAnchor.constraint(equalTo: chartContainer.topAnchor).isActive = true
            chartView.bottomAnchor.constraint(equalTo: chartContainer.bottomAnchor).isActive = true
            
            var lineChartEntry  = [ChartDataEntry]() //this is the Array that will eventually be displayed on the graph.
            
            var cirlces: [Double] = []
            //here is the for loop
            for i in 0..<data.count {
                let item = data[i]
                let x = Double(i)
                let value = ChartDataEntry(x: x, y: Double(item.value))
                lineChartEntry.append(value) // here we add it to the data set
                
                if(item.appearance.isShowCircle) {
                    cirlces.append(x)
                }
            }
            let chartViewDataSet = LineChartDataSet(entries: lineChartEntry, label: "")
            chartViewDataSet.circleHoleColor = appearance.circleHoleColor
            chartViewDataSet.circleColors = data.map{$0.appearance.circleColor}
            chartViewDataSet.colors = data.map{$0.appearance.lineColor} //Sets the colour to blue
            chartViewDataSet.mode = appearance.lineMode
            chartViewDataSet.valueFormatter = appearance.getValueFormatter(data)
            chartViewDataSet.valueColors = data.map{$0.appearance.textColor}
            chartViewDataSet.valueFont = appearance.font
            chartViewDataSet.circleRadius = appearance.circleRadius
            chartViewDataSet.circles = cirlces
            chartViewDataSet.circleHoleRadius = appearance.circleHoleRadius
            chartViewDataSet.lineWidth = appearance.lineWidth
            chartViewDataSet.highlightLineWidth = 0
            chartViewDataSet.valueBottomSpacing = appearance.bottomValueToCircle
            
            lineChartData.addDataSet(chartViewDataSet)
        }
        
        
        chartView.data = lineChartData
        chartView.dragEnabled = false
        chartView.pinchZoomEnabled = false
        chartView.doubleTapToZoomEnabled = false
        chartView.legend.enabled = false
        chartView.clipDataToContentEnabled = false
        chartView.clipValuesToContentEnabled = false
        chartView.setExtraOffsets(left: 30, top: 30, right: 30, bottom: 30)
        
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
        
        chartView.leftAxis.drawAxisLineEnabled = false
        chartView.leftAxis.drawLabelsEnabled = false
        chartView.leftAxis.enabled = false
        chartView.rightAxis.enabled = false
        chartView.delegate = self
        chartView.noDataText = ""
        
        
        chartView.drawMarkers = true
        chartView.marker = HyperLineMarker(config:  HyperLineMarkerConfig(selectedRoundColor: appearance.selectedValueColor, font: appearance.font, bottomSpacing: appearance.bottomValueToCircle, padding: appearance.tooltipPadding))
    }
    
    internal func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
//        let index: Int = chartView.data?.dataSets.firstIndex{$0.contains(entry)} ?? 0
//        var selectedDataSet = chartView.data?.dataSets[index]
//        let selectedData = config.data[index]
//        chartView.drawMarkers = true
//
//        var colors = selectedData.map{$0.appearance.textColor}
//        colors[index] = config.appearance.selectedValueColor
//        selectedDataSet!.valueColors = colors
//        hideSelectedValueTask?.cancel()
//
//        hideSelectedValueTask = DispatchWorkItem(block: {
//            self.chartView.drawMarkers = false
//            self.chartViewDataSet.valueColors = self.config.data.map{$0.appearance.textColor}
//            self.chartView.setNeedsDisplay()
//        })

//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: hideSelectedValueTask!)
    }
    
    internal func chartViewDidEndPanning(_ chartView: ChartViewBase) {
        print("chartViewDidEndPanning")
    }
    
    internal func chartValueNothingSelected(_ chartView: ChartViewBase) {
        print("chartValueNothingSelected")
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


struct HyperLineMarkerConfig {
    let selectedRoundColor: UIColor
    let font: UIFont
    let bottomSpacing: CGFloat
    let padding: CGFloat
}

class HyperLineMarker: IMarker {
    var selectedEntry: ChartDataEntry?
    var config: HyperLineMarkerConfig
    var labels: [String]!
    
    init(config: HyperLineMarkerConfig) {
        self.config = config
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
//        let index = Int(selectedEntry?.x ?? 0);
//        if(index == 0 || index == labels.count - 1) {
//            let selectedStringValue = labels[index]
//            let selectedStringWidth = selectedStringValue.widthOfString(usingFont: config.font)
//            let spacing: CGFloat = config.padding
//            let x: CGFloat  = point.x - selectedStringWidth/2 - spacing
//            let y: CGFloat = point.y - config.font.lineHeight*1.5 - config.bottomSpacing - spacing //5 is horizontal spacing
//            let width: CGFloat = selectedStringWidth + spacing*2
//            let height: CGFloat = config.font.lineHeight + spacing*2
//            let rectFrame = CGRect(x: x, y: y, width: width, height: height)
//            let clipPath = UIBezierPath(roundedRect: rectFrame, cornerRadius: 10).cgPath
//            context.addPath(clipPath)
//            context.setLineWidth(1)
//            context.setStrokeColor(config.selectedRoundColor.cgColor)
//        
//            context.closePath()
//            context.strokePath()
//        }
    }
}
