//
//  aos_mb_line_01.swift
//  Hyperloung
//
//  Created by trinhhcse on 07/11/2021.
//

import UIKit
import Charts

class aos_ma_line_01: UIView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupUI()
    }
    
    func setupUI() {
        let chartView: HyperLineChartView = .fromNib()
        
        self.addSubview(chartView)
        chartView.fullscreen()
        
        let defaultHyperLineDataSetAppearance = HyperLineDataSetAppearance(selectedValueColor: "#000000".color, selectedValueRoundColor:  "#DDDDDD".color, circleHoleColor: "#FFFFFF".color, circleRadius: 4, circleHoleRadius: 2, lineWidth: 3, tooltipPadding: 10, bottomValueToCircle: 15)
        
        let lineDashHyperLineDataSetAppearance = HyperLineDataSetAppearance(selectedValueColor: "#222222".color, selectedValueRoundColor:  "#DDDDDD".color, circleHoleColor: "#FFFFFF".color, circleRadius: 4, circleHoleRadius: 2, lineWidth: 3, tooltipPadding: 10, bottomValueToCircle: 15, lineDashAppearance: HyperLineDataDashAppearance(lineDashLengths: [2,3]))
        
        
        
        //fake data
        let lineData = [
            HyperLineChartDataSet(data: [
                HyperLineData(value: 40, label: "", appearance: HyperLineDataAppearance(textColor:  "#DDDDDD".color, circleColor:  "#246FEE".color, lineColor: "#246FEE".color,isShowCircle: true, isShowValue: false)),
                HyperLineData(value: 54, label: "", appearance: HyperLineDataAppearance(textColor:  "#DDDDDD".color, circleColor:  "#246FEE".color, lineColor: "#246FEE".color, isShowCircle: true, isShowValue: false)),
                HyperLineData(value: 36, label: "%", appearance: HyperLineDataAppearance(textColor:  "#DDDDDD".color, circleColor:  "#246FEE".color, lineColor: "#246FEE".color, isShowCircle: true, isShowValue: true, isShowMark: true, isHightLight: true)),
                HyperLineData(value: 0, label: "", appearance: HyperLineDataAppearance(textColor:  UIColor.clear, circleColor:  UIColor.clear, lineColor: UIColor.clear,isShowCircle: false)),
                HyperLineData(value: 0, label: "", appearance: HyperLineDataAppearance(textColor:  UIColor.clear, circleColor:  UIColor.clear, lineColor: UIColor.clear,isShowCircle: false)),
                ], appearance: defaultHyperLineDataSetAppearance),
            HyperLineChartDataSet(data: [
                HyperLineData(value: 20, label: "A", appearance: HyperLineDataAppearance(textColor:  "#DDDDDD".color, circleColor:  "#EEEEEE".color, lineColor: "#EEEEEE".color,isShowCircle: true)),
                HyperLineData(value: 34, label: "B", appearance: HyperLineDataAppearance(textColor:  "#DDDDDD".color, circleColor:  "#EEEEEE".color, lineColor: "#EEEEEE".color, isShowCircle: true)),
                HyperLineData(value: 16, label: "C", appearance: HyperLineDataAppearance(textColor:  "#DDDDDD".color, circleColor:  "#EEEEEE".color, lineColor: "#EEEEEE".color, isShowCircle: true)),
                HyperLineData(value: 32, label: "D", appearance: HyperLineDataAppearance(textColor:  "#DDDDDD".color, circleColor:  "#EEEEEE".color, lineColor: "#EEEEEE".color, isShowCircle: true)),
                HyperLineData(value: 50, label: "D", appearance: HyperLineDataAppearance(textColor:  "#DDDDDD".color, circleColor:  "#EEEEEE".color, lineColor: "#EEEEEE".color, isShowCircle: true)),
            ], appearance: lineDashHyperLineDataSetAppearance)]
        
        
        let descriptions =  [
            CircleInfoData(color: "#3557C9".color, description: "A"),
            CircleInfoData(color: "#1F92E4".color, description: "B")
        ]
        
        let xAxisData = ["A","B","C","D","E"]
        let defaultFont = UIFont.systemFont(ofSize: 13)
        let highLightValueFont = UIFont.boldSystemFont(ofSize: 13)
        let appearence = HyperLineAppearance(font: defaultFont, highLightValueFont: highLightValueFont,  xAxisValueColor: "#DDDDDD".color ,lineMode: .linear, getValueFormatter: getValueFormatter, xAxisFormatter: IndexAxisValueFormatter(values: xAxisData))
        
        let defaultConfig = HyperLineChartConfig(
            title: String(describing: type(of: self)),
            dataSets: lineData,
            xAxisData: xAxisData,
            descriptions: descriptions,
            appearance: appearence
        )
        
        chartView.setupUI(config: defaultConfig)
    }
    
    func getIAxisValueFormatter() -> IAxisValueFormatter{
        return aos_ma_line_01DataSetIAxisValueFormatter()
    }
    
    func getValueFormatter(_ data: [HyperLineData]) -> IValueFormatter{
        return aos_ma_line_01DataSetValueFormatter(data: data)
    }
}

class aos_ma_line_01DataSetIAxisValueFormatter: IAxisValueFormatter {
    
    init() {
    }
    
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let convertedValue = Int(value)
        return convertedValue == 0 ? String(convertedValue) : "\(convertedValue)%"
    }
}


class aos_ma_line_01DataSetValueFormatter: IValueFormatter {
    let data: [HyperLineData]
    
    init(data: [HyperLineData]) {
        self.data = data
    }
    
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        let index = Int(entry.x)
        let value = data[index].value
        let label = data[index].label
        let isShowValue = data[index].appearance.isShowValue ?? true
        return isShowValue ? Formattor.getValueDescription(value,label) : ""
    }
}


