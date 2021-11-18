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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setupUI() {
        let chartView: HyperLineChartView = .fromNib()
        
        self.addSubview(chartView)
        chartView.fullscreen()
        
        let defaultHyperLineDataSetAppearance = HyperLineDataSetAppearance(selectedValueColor: "#222222".color, selectedValueRoundColor:  "#DDDDDD".color, circleHoleColor: "#FFFFFF".color, circleRadius: 4, circleHoleRadius: 2, lineWidth: 3, tooltipPadding: 10, bottomValueToCircle: 10)
        
        
        //fake data
        let dataSets = [
            HyperLineChartDataSet(data: [
                HyperLineData(value: 0, label: "", appearance: HyperLineDataAppearance(textColor:  UIColor.clear, circleColor:  UIColor.clear, lineColor: UIColor.clear,isShowCircle: false)),
                HyperLineData(value: 72, label: "억", appearance: HyperLineDataAppearance(textColor:  "#EEEEEE".color, circleColor:  "#EEEEEE".color, lineColor: "#EEEEEE".color,isShowCircle: true)),
                HyperLineData(value: 65, label: "억", appearance: HyperLineDataAppearance(textColor:  "#EEEEEE".color, circleColor:  "#EEEEEE".color, lineColor: "#EEEEEE".color, isShowCircle: true)),
                HyperLineData(value: 70, label: "억", appearance: HyperLineDataAppearance(textColor:  "#EEEEEE".color, circleColor:  "#EEEEEE".color, lineColor: "#EEEEEE".color, isShowCircle: true)),
                HyperLineData(value: 66, label: "억", appearance: HyperLineDataAppearance(textColor:  "#EEEEEE".color, circleColor:  "#EEEEEE".color, lineColor: "#EEEEEE".color, isShowCircle: true)),
                HyperLineData(value: 0, label: "", appearance: HyperLineDataAppearance(textColor:  UIColor.clear, circleColor:  UIColor.clear, lineColor: UIColor.clear,isShowCircle: false)),
            ], appearance: defaultHyperLineDataSetAppearance),
            HyperLineChartDataSet(data: [
                HyperLineData(value: 0, label: "", appearance: HyperLineDataAppearance(textColor:  UIColor.clear, circleColor:  UIColor.clear, lineColor: UIColor.clear,isShowCircle: false)),
                HyperLineData(value: 82, label: "억", appearance: HyperLineDataAppearance(textColor:  "#000000".color, circleColor:  "#000000".color, lineColor: "#000000".color,isShowCircle: true, isShowValue: true, isShowMark: false)),
                HyperLineData(value: 70, label: "억", appearance: HyperLineDataAppearance(textColor:  "#000000".color, circleColor:  "#000000".color, lineColor: "#000000".color, isShowCircle: true, isShowValue: true, isShowMark: false)),
                HyperLineData(value: 75, label: "억", appearance: HyperLineDataAppearance(textColor:  "#000000".color, circleColor:  "#000000".color, lineColor: "#000000".color, isShowCircle: true, isShowValue: true, isShowMark: false)),
                HyperLineData(value: 69, label: "억", appearance: HyperLineDataAppearance(textColor:  "#000000".color, circleColor:  "#000000".color, lineColor: "#000000".color, isShowCircle: true, isShowValue: true, isShowMark: false)),
                HyperLineData(value: 0, label: "", appearance: HyperLineDataAppearance(textColor:  UIColor.clear, circleColor:  UIColor.clear, lineColor: UIColor.clear,isShowCircle: false)),
            ], appearance: defaultHyperLineDataSetAppearance)]
        
        let descriptions =  [
            CircleInfoData(color: "#000000".color, description: "범례1"),
            CircleInfoData(color: "#EEEEEE".color, description: "범례2")
        ]
        
        let xAxisData =  ["","4월","5월","6월","7월",""]
        let defaultFont = UIFont.normal(size: 13)
        let highLightValueFont = UIFont.bold(size: 13)
        let appearence = HyperLineAppearance(font: defaultFont, highLightValueFont: highLightValueFont,  xAxisLabelColor: "#222222".color , lineMode: .linear, getValueFormatter: getValueFormatter, xAxisFormatter: IndexAxisValueFormatter(values: xAxisData), leftAxisConfig: HyperLineLeftAxisConfig(labelCount: 3, minValue: 0, maxValue: 82, xOffset: 25, valueFormatter: getIAxisValueFormatter(),labelColor: "#AAAAAA".color, entries: [0,42,82]))
        
        let defaultConfig = HyperLineChartConfig(
            title: String(describing: type(of: self)),
            dataSets: dataSets,
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
        return convertedValue == 0 ? String(convertedValue) : "\(convertedValue)억"
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


