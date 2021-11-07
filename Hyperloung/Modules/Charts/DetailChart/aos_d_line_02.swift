//
//  aos_d_line_02.swift
//  Hyperloung
//
//  Created by trinhhcse on 05/11/2021.
//

import UIKit

import Charts
class aos_d_line_02: UIView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupUI()
    }
    
    func setupUI() {
        let chartView: HyperLineChartView = .fromNib()
        
        self.addSubview(chartView)
        chartView.fullscreen()
        
        let defaultHyperLineDataSetAppearance = HyperLineDataSetAppearance(selectedValueColor: "#222222".color, selectedValueRoundColor:  "#DDDDDD".color ,circleHoleColor: "#FFFFFF".color, circleRadius: 4, circleHoleRadius: 2, lineWidth: 3, tooltipPadding: 10, bottomValueToCircle: 15 )
        
        //fake data
        let lineData = [
            HyperLineChartDataSet(
                data:
                    [
                        HyperLineData(value: 0, label: "", appearance: HyperLineDataAppearance(textColor:  UIColor.clear, circleColor:  UIColor.clear, lineColor: UIColor.clear,isShowCircle: false)),
                        HyperLineData(value: 100, label: "A", appearance: HyperLineDataAppearance(textColor:  "#DDDDDD".color, circleColor:  "#61D0F0".color, lineColor: "#61D0F0".color,isShowCircle: true)),
                        HyperLineData(value: 75, label: "B", appearance: HyperLineDataAppearance(textColor:  "#DDDDDD".color, circleColor:  "#61D0F0".color, lineColor: "#61D0F0".color, isShowCircle: true)),
                        HyperLineData(value: 85, label: "C", appearance: HyperLineDataAppearance(textColor:  "#DDDDDD".color, circleColor:  "#61D0F0".color, lineColor: "#61D0F0".color, isShowCircle: true)),
                        HyperLineData(value: 65, label: "D", appearance: HyperLineDataAppearance(textColor:  "#DDDDDD".color, circleColor:  "#61D0F0".color, lineColor: "#61D0F0".color, isShowCircle: true)),
                        HyperLineData(value: 0, label: "", appearance: HyperLineDataAppearance(textColor:  UIColor.clear, circleColor:  UIColor.clear, lineColor: UIColor.clear,isShowCircle: false)),
                    ], appearance: defaultHyperLineDataSetAppearance),
            HyperLineChartDataSet(
                data:
                    [
                        HyperLineData(value: 0, label: "", appearance: HyperLineDataAppearance(textColor:  UIColor.clear, circleColor:  UIColor.clear, lineColor: UIColor.clear,isShowCircle: false)),
                        HyperLineData(value: 70, label: "A", appearance: HyperLineDataAppearance(textColor:  "#DDDDDD".color, circleColor:  "#3557C9".color, lineColor: "#3557C9".color,isShowCircle: true)),
                        HyperLineData(value: 45, label: "B", appearance: HyperLineDataAppearance(textColor:  "#DDDDDD".color, circleColor:  "#3557C9".color, lineColor: "#3557C9".color, isShowCircle: true)),
                        HyperLineData(value: 60, label: "C", appearance: HyperLineDataAppearance(textColor:  "#DDDDDD".color, circleColor:  "#3557C9".color, lineColor: "#3557C9".color, isShowCircle: true)),
                        HyperLineData(value: 40, label: "D", appearance: HyperLineDataAppearance(textColor:  "#DDDDDD".color, circleColor:  "#3557C9".color, lineColor: "#3557C9".color, isShowCircle: true)),
                        HyperLineData(value: 0, label: "", appearance: HyperLineDataAppearance(textColor:  UIColor.clear, circleColor:  UIColor.clear, lineColor: UIColor.clear,isShowCircle: false)),
                    ], appearance: defaultHyperLineDataSetAppearance),
            HyperLineChartDataSet(
                data:
                    [
                        HyperLineData(value: 0, label: "", appearance: HyperLineDataAppearance(textColor:  UIColor.clear, circleColor:  UIColor.clear, lineColor: UIColor.clear,isShowCircle: false)),
                        HyperLineData(value: 47, label: "A", appearance: HyperLineDataAppearance(textColor:  "#DDDDDD".color, circleColor:  "#1F92E4".color, lineColor: "#1F92E4".color,isShowCircle: true)),
                        HyperLineData(value: 50, label: "B", appearance: HyperLineDataAppearance(textColor:  "#DDDDDD".color, circleColor:  "#1F92E4".color, lineColor: "#1F92E4".color, isShowCircle: true)),
                        HyperLineData(value: 20, label: "C", appearance: HyperLineDataAppearance(textColor:  "#DDDDDD".color, circleColor:  "#1F92E4".color, lineColor: "#1F92E4".color, isShowCircle: true)),
                        HyperLineData(value: 82, label: "D", appearance: HyperLineDataAppearance(textColor:  "#DDDDDD".color, circleColor:  "#1F92E4".color, lineColor: "#1F92E4".color, isShowCircle: true)),
                        HyperLineData(value: 0, label: "", appearance: HyperLineDataAppearance(textColor:  UIColor.clear, circleColor:  UIColor.clear, lineColor: UIColor.clear,isShowCircle: false)),
                        
                    ], appearance: defaultHyperLineDataSetAppearance)
        ]
        
        let descriptions =  [
            CircleInfoData(color: "#3557C9".color, description: "A"),
            CircleInfoData(color: "#1F92E4".color, description: "B"),
            CircleInfoData(color: "#61D0F0".color, description: "C")
        ]
        
        let xAxisData = ["","1A","2B","3C","4D",""]
        let defaultFont = UIFont.systemFont(ofSize: 13)
        let highLightValueFont = UIFont.boldSystemFont(ofSize: 13)
        let appearence = HyperLineAppearance(font: defaultFont, highLightValueFont: highLightValueFont,  xAxisValueColor: "#222222".color,  lineMode: .linear, getValueFormatter: getValueFormatter, xAxisFormatter: IndexAxisValueFormatter(values: xAxisData), leftAxisConfig: HyperLineLeftAxisConfig( labelCount: 3, minValue: 0, maxValue: 100, xOffset: 25, valueFormatter: getIAxisValueFormatter(),labelColor: "#AAAAAA".color))
        
        let defaultConfig = HyperLineChartConfig(
            dataSets: lineData,
            xAxisData: xAxisData,
            descriptions: descriptions,
            appearance: appearence
            
        )
        
        chartView.setupUI(config: defaultConfig)
    }
    
    func getIAxisValueFormatter() -> IAxisValueFormatter{
        return aos_d_line_02DataSetIAxisValueFormatter()
    }
    
    func getValueFormatter(_ data: [HyperLineData]) -> IValueFormatter{
        return aos_d_line_02DataSetValueFormatter(data: data)
    }
}

class aos_d_line_02DataSetIAxisValueFormatter: IAxisValueFormatter {
    
    init() {
    }
    
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let convertedValue = Int(value)
        return convertedValue == 0 ? String(convertedValue) : "\(convertedValue)%"
    }
}


class aos_d_line_02DataSetValueFormatter: IValueFormatter {
    let data: [HyperLineData]
    
    init(data: [HyperLineData]) {
        self.data = data
    }
    
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        return ""
    }
}

