//
//  Line2ChartView.swift
//  Chart
//
//  Created by trinhhcse on 02/11/2021.
//

import UIKit

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
        
        
        //fake data
        let lineData = [[
            HyperLineData(value: 8, label: "A", appearance: HyperLineDataAppearance(textColor:  "#DDDDDD".color, circleColor:  "#246FEE".color, lineColor: "#246FEE".color,isShowCircle: false)),
            HyperLineData(value: 24, label: "B", appearance: HyperLineDataAppearance(textColor:  "#DDDDDD".color, circleColor:  "#246FEE".color, lineColor: "#246FEE".color, isShowCircle: false)),
            HyperLineData(value: 16, label: "C", appearance: HyperLineDataAppearance(textColor:  "#DDDDDD".color, circleColor:  "#246FEE".color, lineColor: "#246FEE".color, isShowCircle: false)),
            HyperLineData(value: 36, label: "D", appearance: HyperLineDataAppearance(textColor:  "#DDDDDD".color, circleColor:  "#246FEE".color, lineColor: "#246FEE".color, isShowCircle: true)),
        ]]

        let descriptions =  [
            CircleInfoData(color: "#246FEE".color, description: "A"),
            CircleInfoData(color: "#DDDDDD".color, description: "B")
        ]

        let xAxisData = ["1A","2B","3C","4D"]
        let defaultFont = UIFont.systemFont(ofSize: 11)

        let appearence = HyperLineAppearance(font: defaultFont,  selectedValueColor: "#222222".color, xAxisValueColor: "#DDDDDD".color ,circleHoleColor: "#FFFFFF".color, circleRadius: 4, circleHoleRadius: 2, lineWidth: 3, tooltipPadding: 10, bottomValueToCircle: 10 , lineMode: .cubicBezier, getValueFormatter: getValueFormatter, xAxisFormatter: IndexAxisValueFormatter(values: xAxisData))

        let defaultConfig = HyperLineChartConfig(
            data:lineData,
            xAxisData: xAxisData,
            descriptions: descriptions,
            appearance: appearence
            
        )
        
        chartView.setupUI(config: defaultConfig)
    }
    
    
    func getValueFormatter(_ data: [HyperLineData]) -> IValueFormatter{
        return aos_ma_line_04DataSetValueFormatter(data: data)
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
        return index == (data.count - 1) ? Formattor.getValueDescription(value,label) : ""
    }
}

