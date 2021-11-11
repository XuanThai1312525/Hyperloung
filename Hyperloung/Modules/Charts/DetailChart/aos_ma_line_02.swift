//
//  Line1Chart.swift
//  Chart
//
//  Created by trinhhcse on 01/11/2021.
//

import Foundation
import UIKit
import Charts // You need this line to be able to use Charts Library


class aos_ma_line_02: UIView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupUI()
    }
    
    func setupUI() {
        let chartView: HyperLineChartView = .fromNib()
        
        self.addSubview(chartView)
        chartView.fullscreen()
        
        let defaultHyperLineDataSetAppearance = HyperLineDataSetAppearance(selectedValueColor: "#222222".color, selectedValueRoundColor: "#DDDDDD".color, circleHoleColor: "#FFFFFF".color, circleRadius: 4, circleHoleRadius: 2, lineWidth: 3, tooltipPadding: 10, bottomValueToCircle: 10)
        
        //fake data
        let dataSets = [
            HyperLineChartDataSet(data: [
                HyperLineData(value: 8, label: "억", appearance: HyperLineDataAppearance(textColor:  "#DDDDDD".color, circleColor:  "#246FEE".color, lineColor: "#246FEE".color,isShowCircle: true)),
                HyperLineData(value: 24, label: "억", appearance: HyperLineDataAppearance(textColor:  "#DDDDDD".color, circleColor:  "#246FEE".color, lineColor: "#246FEE".color, isShowCircle: true)),
                HyperLineData(value: 16, label: "억", appearance: HyperLineDataAppearance(textColor:  "#DDDDDD".color, circleColor:  "#246FEE".color, lineColor: "#246FEE".color, isShowCircle: true)),
                HyperLineData(value: 36, label: "억", appearance: HyperLineDataAppearance(textColor:  "#DDDDDD".color, circleColor:  "#246FEE".color, lineColor: "#246FEE".color, isShowCircle: true, isShowValue: true, isHightLight: true)),
            ], appearance: defaultHyperLineDataSetAppearance)]
        
        let descriptions =  [
            CircleInfoData(color: "#246FEE".color, description: "범례1"),
            CircleInfoData(color: "#DDDDDD".color, description: "범례2")
        ]
        
        let xAxisData = ["4월","5월","6월","7월"]
        let defaultFont = UIFont.normal(size: 13)
        let highLightValueFont = UIFont.bold(size: 13)
        let appearence = HyperLineAppearance(font: defaultFont, highLightValueFont: highLightValueFont,xAxisLabelColor: "#DDDDDD".color , lineMode: .linear, getValueFormatter: getValueFormatter, xAxisFormatter: IndexAxisValueFormatter(values: xAxisData))
        
        let defaultConfig = HyperLineChartConfig(
            title: String(describing: type(of: self)),
            dataSets:dataSets,
            xAxisData: xAxisData,
            descriptions: descriptions,
            appearance: appearence
            
        )
        
        chartView.setupUI(config: defaultConfig)
    }
    
    
    func getValueFormatter(_ data: [HyperLineData]) -> IValueFormatter{
        return aos_ma_line_02DataSetValueFormatter(data: data)
    }
}






class aos_ma_line_02DataSetValueFormatter: IValueFormatter {
    let data: [HyperLineData]
    
    init(data: [HyperLineData]) {
        self.data = data
    }
    
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        let index = Int(entry.x)
        let value = data[index].value
        let label = data[index].label
        return index == (data.count - 1) ? Formattor.getValueDescription(value,label) : ""
    }
}

