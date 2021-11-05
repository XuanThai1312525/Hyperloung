//
//  aos_d_line_01.swift
//  Hyperloung
//
//  Created by trinhhcse on 05/11/2021.
//

import UIKit

import Charts
class aos_d_line_01: UIView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupUI()
    }
    
    func setupUI() {
        let chartView: HyperLineChartView = .fromNib()
        
        self.addSubview(chartView)
        chartView.fullscreen()
        
        
        //fake data
        let lineData = [[
            HyperLineData(value: 0, label: "", appearance: HyperLineDataAppearance(textColor:  UIColor.clear, circleColor:  UIColor.clear, lineColor: UIColor.clear,isShowCircle: false)),
            HyperLineData(value: 82, label: "A", appearance: HyperLineDataAppearance(textColor:  "#000000".color, circleColor:  "#000000".color, lineColor: "#000000".color,isShowCircle: true, isShowValue: true, isShowMark: false)),
            HyperLineData(value: 70, label: "B", appearance: HyperLineDataAppearance(textColor:  "#000000".color, circleColor:  "#000000".color, lineColor: "#000000".color, isShowCircle: true, isShowValue: true, isShowMark: false)),
            HyperLineData(value: 75, label: "C", appearance: HyperLineDataAppearance(textColor:  "#000000".color, circleColor:  "#000000".color, lineColor: "#000000".color, isShowCircle: true, isShowValue: true, isShowMark: false)),
            HyperLineData(value: 69, label: "D", appearance: HyperLineDataAppearance(textColor:  "#000000".color, circleColor:  "#000000".color, lineColor: "#000000".color, isShowCircle: true, isShowValue: true, isShowMark: false)),
            HyperLineData(value: 0, label: "", appearance: HyperLineDataAppearance(textColor:  UIColor.clear, circleColor:  UIColor.clear, lineColor: UIColor.clear,isShowCircle: false)),
        ], [
            HyperLineData(value: 0, label: "", appearance: HyperLineDataAppearance(textColor:  UIColor.clear, circleColor:  UIColor.clear, lineColor: UIColor.clear,isShowCircle: false)),
            HyperLineData(value: 72, label: "A", appearance: HyperLineDataAppearance(textColor:  "#EEEEEE".color, circleColor:  "#EEEEEE".color, lineColor: "#EEEEEE".color,isShowCircle: true)),
            HyperLineData(value: 65, label: "B", appearance: HyperLineDataAppearance(textColor:  "#EEEEEE".color, circleColor:  "#EEEEEE".color, lineColor: "#EEEEEE".color, isShowCircle: true)),
            HyperLineData(value: 70, label: "C", appearance: HyperLineDataAppearance(textColor:  "#EEEEEE".color, circleColor:  "#EEEEEE".color, lineColor: "#EEEEEE".color, isShowCircle: true)),
            HyperLineData(value: 66, label: "D", appearance: HyperLineDataAppearance(textColor:  "#EEEEEE".color, circleColor:  "#EEEEEE".color, lineColor: "#EEEEEE".color, isShowCircle: true)),
            HyperLineData(value: 0, label: "", appearance: HyperLineDataAppearance(textColor:  UIColor.clear, circleColor:  UIColor.clear, lineColor: UIColor.clear,isShowCircle: false)),
        ]]
        
        let descriptions =  [
            CircleInfoData(color: "#000000".color, description: "A"),
            CircleInfoData(color: "#EEEEEE".color, description: "B")
        ]
        
        let xAxisData = ["","1A","2B","3C","4D",""]
        let defaultFont = UIFont.systemFont(ofSize: 11)
        
        let appearence = HyperLineAppearance(font: defaultFont,  selectedValueColor: "#222222".color, selectedValueRoundColor:  "#111111".color, xAxisValueColor: "#222222".color ,circleHoleColor: "#FFFFFF".color, circleRadius: 4, circleHoleRadius: 2, lineWidth: 3, tooltipPadding: 10, bottomValueToCircle: 5 , lineMode: .linear, getValueFormatter: getValueFormatter, xAxisFormatter: IndexAxisValueFormatter(values: xAxisData), leftAxisConfig: HyperLineLeftAxisConfig(isShowAxis: true, labelCount: 3, minValue: 0, maxValue: 82, xOffset: 25, labels: [
            "100%","50%","0"], valueFormatter: getIAxisValueFormatter(),labelColor: "#AAAAAA".color))
        
        let defaultConfig = HyperLineChartConfig(
            data: lineData,
            xAxisData: xAxisData,
            descriptions: descriptions,
            appearance: appearence
            
        )
        
        chartView.setupUI(config: defaultConfig)
    }
    
    func getIAxisValueFormatter() -> IAxisValueFormatter{
        return aos_d_line_01DataSetIAxisValueFormatter()
    }
    
    func getValueFormatter(_ data: [HyperLineData]) -> IValueFormatter{
        return aos_d_line_01DataSetValueFormatter(data: data)
    }
}

class aos_d_line_01DataSetIAxisValueFormatter: IAxisValueFormatter {
    
    init() {
    }
    
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let convertedValue = Int(value)
        return convertedValue == 0 ? String(convertedValue) : "\(convertedValue)%"
    }
}


class aos_d_line_01DataSetValueFormatter: IValueFormatter {
    let data: [HyperLineData]
    
    init(data: [HyperLineData]) {
        self.data = data
    }
    
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        let index = Int(entry.x)
        let value = data[index].value
        let label = data[index].label
        return data[index].appearance.isShowValue ? Formattor.getValueDescription(value,label) : ""
    }
}


