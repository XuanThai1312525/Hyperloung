//
//  Line1Chart.swift
//  Chart
//
//  Created by trinhhcse on 01/11/2021.
//

import Foundation
import UIKit
import Charts // You need this line to be able to use Charts Library


class aos_ma_line_03: UIView {
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
            HyperLineData(value: 8, label: "A", appearance: HyperLineDataAppearance(textColor:  "#DDDDDD".color, circleColor:  "#246FEE".color, lineColor: "#246FEE".color,isShowCircle: true, isShowValue: true)),
            HyperLineData(value: 24, label: "B", appearance: HyperLineDataAppearance(textColor:  "#DDDDDD".color, circleColor:  "#246FEE".color, lineColor: "#246FEE".color, isShowCircle: true, isShowValue: true)),
            HyperLineData(value: 16, label: "C", appearance: HyperLineDataAppearance(textColor:  "#DDDDDD".color, circleColor:  "#246FEE".color, lineColor: "#246FEE".color, isShowCircle: true, isShowValue: true)),
            HyperLineData(value: 36, label: "D", appearance: HyperLineDataAppearance(textColor:  "#DDDDDD".color, circleColor:  "#246FEE".color, lineColor: "#246FEE".color, isShowCircle: true, isShowValue: true)),
        ]]

        let descriptions:[CircleInfoData] =  []

        let xAxisData = ["1A","2B","3C","4D"]
        let defaultFont = UIFont.systemFont(ofSize: 11)

        let appearence = HyperLineAppearance(font: defaultFont,  selectedValueColor: "#222222".color, selectedValueRoundColor:  "#111111".color, xAxisValueColor: "#DDDDDD".color ,circleHoleColor: "#FFFFFF".color, circleRadius: 4, circleHoleRadius: 2, lineWidth: 3, tooltipPadding: 10, bottomValueToCircle: 15 , lineMode: .linear, getValueFormatter: getValueFormatter, xAxisFormatter: IndexAxisValueFormatter(values: xAxisData), leftAxisConfig: HyperLineLeftAxisConfig(isShowAxis: false))

        let defaultConfig = HyperLineChartConfig(
            data: lineData,
            xAxisData: xAxisData,
            descriptions: descriptions,
            appearance: appearence
            
        )
        
        chartView.setupUI(config: defaultConfig)
    }
    
    func getValueFormatter(_ data: [HyperLineData]) -> IValueFormatter{
        return aos_ma_line_03DataSetValueFormatter(data: data)
    }
}


class aos_ma_line_03DataSetValueFormatter: IValueFormatter {
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

