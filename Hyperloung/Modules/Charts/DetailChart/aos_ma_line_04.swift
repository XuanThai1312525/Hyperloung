//
//  Line2ChartView.swift
//  Chart
//
//  Created by trinhhcse on 04/11/2041.
//

import UIKit
import Charts
class aos_ma_line_04: UIView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupUI()
    }
    
    func setupUI() {
        let chartView: HyperLineChartView = .fromNib()
        
        self.addSubview(chartView)
        chartView.fullscreen()
        
        let defaultHyperLineDataSetAppearance = HyperLineDataSetAppearance(selectedValueColor: "#222222".color, selectedValueRoundColor:  "#DDDDDD".color, circleHoleColor: "#FFFFFF".color, circleRadius: 4, circleHoleRadius: 2, lineWidth: 3, tooltipPadding: 10, bottomValueToCircle: 15)
        
        let lineDashHyperLineDataSetAppearance = HyperLineDataSetAppearance(selectedValueColor: "#222222".color, selectedValueRoundColor:  "#DDDDDD".color, circleHoleColor: "#FFFFFF".color, circleRadius: 4, circleHoleRadius: 2, lineWidth: 3, tooltipPadding: 10, bottomValueToCircle: 15, lineDashAppearance: HyperLineDataDashAppearance(lineDashLengths: [2,3]))
        
        
        
        //fake data
        let lineData = [
            HyperLineChartDataSet(data: [
                HyperLineData(value: 8, label: "A", appearance: HyperLineDataAppearance(textColor:  "#DDDDDD".color, circleColor:  "#246FEE".color, lineColor: "#246FEE".color,isShowCircle: false, isShowValue: false)),
                HyperLineData(value: 24, label: "B", appearance: HyperLineDataAppearance(textColor:  "#DDDDDD".color, circleColor:  "#246FEE".color, lineColor: "#246FEE".color, isShowCircle: false, isShowValue: false)),
                HyperLineData(value: 18, label: "D", appearance: HyperLineDataAppearance(textColor:  "#DDDDDD".color, circleColor:  "#246FEE".color, lineColor: "#246FEE".color, isShowCircle: true, isShowValue: true, isShowMark: true, isHightLight: true)),
                HyperLineData(value: 0, label: "C", appearance: HyperLineDataAppearance(textColor:  UIColor.clear, circleColor:  UIColor.clear, lineColor: UIColor.clear,isShowCircle: false, isShowMark: false)),
                
                ], appearance: defaultHyperLineDataSetAppearance),
            HyperLineChartDataSet(data: [
                HyperLineData(value: 5, label: "A", appearance: HyperLineDataAppearance(textColor:  "#DDDDDD".color, circleColor:   UIColor.clear, lineColor: "#EEEEEE".color,isShowCircle: true)),
                HyperLineData(value: 18, label: "B", appearance: HyperLineDataAppearance(textColor:  "#DDDDDD".color, circleColor:   UIColor.clear, lineColor: "#EEEEEE".color, isShowCircle: true)),
                HyperLineData(value: 10, label: "C", appearance: HyperLineDataAppearance(textColor:  "#DDDDDD".color, circleColor:   UIColor.clear, lineColor: "#EEEEEE".color, isShowCircle: true)),
                HyperLineData(value: 24, label: "D", appearance: HyperLineDataAppearance(textColor:  "#DDDDDD".color,  circleColor:  UIColor.clear, lineColor: "#EEEEEE".color, isShowCircle: true)),
            ], appearance: lineDashHyperLineDataSetAppearance)]
        
        
        let descriptions =  [
            CircleInfoData(color: "#3557C9".color, description: "A"),
            CircleInfoData(color: "#1F92E4".color, description: "B")
        ]
        
        let xAxisData = ["1","10","20","30"]
        let defaultFont = UIFont.systemFont(ofSize: 13)
        let highLightValueFont = UIFont.boldSystemFont(ofSize: 13)
        let appearence = HyperLineAppearance(font: defaultFont, highLightValueFont: highLightValueFont,  xAxisValueColor: "#222222".color ,lineMode: .cubicBezier, getValueFormatter: getValueFormatter, xAxisFormatter: IndexAxisValueFormatter(values: xAxisData))
        
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
        return aos_ma_line_04DataSetIAxisValueFormatter()
    }
    
    func getValueFormatter(_ data: [HyperLineData]) -> IValueFormatter{
        return aos_ma_line_04DataSetValueFormatter(data: data)
    }
}

class aos_ma_line_04DataSetIAxisValueFormatter: IAxisValueFormatter {
    
    init() {
    }
    
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let convertedValue = Int(value)
        return convertedValue == 0 ? String(convertedValue) : "\(convertedValue)%"
    }
}


class aos_ma_line_04DataSetValueFormatter: IValueFormatter {
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

