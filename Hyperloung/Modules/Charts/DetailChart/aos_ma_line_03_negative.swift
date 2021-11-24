//
//  Line1Chart.swift
//  Chart
//
//  Created by trinhhcse on 01/11/2021.
//

import Foundation
import UIKit
import Charts // You need this line to be able to use Charts Library


class aos_ma_line_03_negative: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupUI()
    }
    
    func setupUI() {
        let chartView: HyperLineChartView = .fromNib()
        
        self.addSubview(chartView)
        chartView.fullscreen()
        
        let defaultHyperLineDataSetAppearance = HyperLineDataSetAppearance(selectedValueColor: "#222222".color, selectedValueRoundColor:  "#DDDDDD".color, circleHoleColor: "#FFFFFF".color, circleRadius: 4, circleHoleRadius: 2, lineWidth: 3, tooltipPadding: 10, bottomValueToCircle: 10 )
        //fake data
        let dataSets = [
            HyperLineChartDataSet(data: [
                HyperLineData(value: 8, label: "억", appearance: HyperLineDataAppearance(textColor:  "#DDDDDD".color, circleColor:  "#ee3224".color, lineColor: "#ee3224".color,isShowCircle: true, isShowValue: true)),
                HyperLineData(value: 24, label: "억", appearance: HyperLineDataAppearance(textColor:  "#DDDDDD".color, circleColor:  "#ee3224".color, lineColor: "#ee3224".color, isShowCircle: true, isShowValue: true)),
                HyperLineData(value: 16, label: "억", appearance: HyperLineDataAppearance(textColor:  "#DDDDDD".color, circleColor:  "#ee3224".color, lineColor: "#ee3224".color, isShowCircle: true, isShowValue: true)),
                HyperLineData(value: -36, label: "억", appearance: HyperLineDataAppearance(textColor:  "#DDDDDD".color, circleColor:  "#ee3224".color, lineColor: "#ee3224".color, isShowCircle: true, isShowValue: true, isHightLight: true)),
            ], appearance: defaultHyperLineDataSetAppearance)]
        
        let descriptions:[CircleInfoData] =  []
        
        let xAxisData = ["8억","9억","10억","11억"]
        let defaultFont = UIFont.normal(size: 13)
        let highLightValueFont = UIFont.bold(size: 13)
        let appearence = HyperLineAppearance(font: defaultFont, highLightValueFont: highLightValueFont, xAxisLabelColor: "#DDDDDD".color  , lineMode: .linear, getValueFormatter: getValueFormatter, xAxisFormatter: IndexAxisValueFormatter(values: xAxisData))
        
        let defaultConfig = HyperLineChartConfig(
            title: String(describing: type(of: self)),
            dataSets: dataSets,
            xAxisData: xAxisData,
            descriptions: descriptions,
            appearance: appearence
            
        )
        
        chartView.setupUI(config: defaultConfig)
    }
    
    func getValueFormatter(_ data: [HyperLineData]) -> IValueFormatter{
        return aos_ma_line_03_negativeDataSetValueFormatter(data: data)
    }
}


class aos_ma_line_03_negativeDataSetValueFormatter: IValueFormatter {
    let data: [HyperLineData]
    
    init(data: [HyperLineData]) {
        self.data = data
    }
    
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        let index = Int(entry.x)
        let value = data[index].value
        let label = data[index].label
        return Formattor.getValueDescription(value,label)
    }
}

