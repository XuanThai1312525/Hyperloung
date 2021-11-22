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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setupUI() {
        let chartView: HyperLineChartView = .fromNib()
        
        self.addSubview(chartView)
        chartView.fullscreen()
        
        let url = Bundle.main.url(forResource: "line04", withExtension: "json")!
        let jsonData = try! Data(contentsOf: url, options: .mappedIfSafe)
        let jsonResult = try! JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions(rawValue: 0)) as! [[String:Any]]
        
        
        
        let defaultHyperLineDataSetAppearance = HyperLineDataSetAppearance(selectedValueColor: "#222222".color, selectedValueRoundColor:  "#DDDDDD".color, circleHoleColor: "#FFFFFF".color, circleRadius: 4, circleHoleRadius: 2, lineWidth: 3, tooltipPadding: 10, bottomValueToCircle: 10)
        
        let lineDashHyperLineDataSetAppearance = HyperLineDataSetAppearance(selectedValueColor: "#222222".color, selectedValueRoundColor:  "#DDDDDD".color, circleHoleColor: "#FFFFFF".color, circleRadius: 4, circleHoleRadius: 2, lineWidth: 3, tooltipPadding: 10, bottomValueToCircle: 10, lineDashAppearance: HyperLineDataDashAppearance(lineDashLengths: [2,3]))
        var nomalLineData: [HyperLineData] = []
        
        var dashLineData: [HyperLineData] = []
        
        jsonResult.forEach { dic in
            let x = dic["x"]
            let y = dic["y"] as! [String:Any]
            let values = y["values"] as! [Int]
            let label = y["label"] as! String
            
            let aboveValue = Double(values.first!)
            if aboveValue == 0 {
                nomalLineData.append(HyperLineData(value: aboveValue, label: "억", appearance: HyperLineDataAppearance(textColor:  UIColor.clear, circleColor:  UIColor.clear, lineColor: UIColor.clear,isShowCircle: false, isShowMark: false)))
            } else if !label.isEmpty {
                nomalLineData.append(HyperLineData(value: aboveValue, label: label, appearance: HyperLineDataAppearance(textColor:  "#DDDDDD".color, circleColor:  "#246FEE".color, lineColor: "#246FEE".color, isShowCircle: true, isShowValue: true, isShowMark: true, isHightLight: true)))
            } else {
                nomalLineData.append(HyperLineData(value: aboveValue, label: label, appearance: HyperLineDataAppearance(textColor:  "#DDDDDD".color, circleColor:  "#246FEE".color, lineColor: "#246FEE".color, isShowCircle: false, isShowValue: false)))
            }
            
            let belowValue = Double(values.last!)
            dashLineData.append(HyperLineData(value: belowValue, label: label, appearance: HyperLineDataAppearance(textColor:  "#DDDDDD".color, circleColor:   UIColor.clear, lineColor: "#EEEEEE".color,isShowCircle: false)))
            
        }
        
        let lineData = [
            HyperLineChartDataSet(data: dashLineData, appearance: lineDashHyperLineDataSetAppearance),
            HyperLineChartDataSet(data: nomalLineData, appearance: defaultHyperLineDataSetAppearance)
        ]
        
        
        let descriptions =  [
            CircleInfoData(color: "#3557C9".color, description: "범례1"),
            CircleInfoData(color: "#1F92E4".color, description: "범례2")
        ]
        
        let xAxisData = (1...30).map{"\($0)"}
        let defaultFont = UIFont.normal(size: 13)
        let highLightValueFont = UIFont.bold(size: 13)
        let appearence = HyperLineAppearance(font: defaultFont, highLightValueFont: highLightValueFont, xAxisLabelColor: "#222222".color, xAxisLabelFont: UIFont.normal(size: 9) ,lineMode: .cubicBezier, getValueFormatter: getValueFormatter, xAxisFormatter: getIAxisValueFormatter(xAxisData))
        
        let defaultConfig = HyperLineChartConfig(
            title: String(describing: type(of: self)),
            dataSets: lineData,
            xAxisData: xAxisData,
            descriptions: descriptions,
            appearance: appearence
        )
        
        chartView.setupUI(config: defaultConfig)
    }
    
    func getIAxisValueFormatter(_ data: [String]) -> IAxisValueFormatter{
        return aos_ma_line_04DataSetIAxisValueFormatter(data: data)
    }
    
    func getValueFormatter(_ data: [HyperLineData]) -> IValueFormatter{
        return aos_ma_line_04DataSetValueFormatter(data: data)
    }
}

class aos_ma_line_04DataSetIAxisValueFormatter: IAxisValueFormatter {
    let data: [String]
    
    init(data: [String]) {
        self.data = data
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let index = Int(value);
        if [0,9,19,29].contains(index){
            return String(data[Int(value)])
        }
        
        return ""
        
    }
}


class aos_ma_line_04DataSetValueFormatter: IValueFormatter {
    let data: [HyperLineData]
    
    init(data: [HyperLineData]) {
        self.data = data
    }
    
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        let index = Int(entry.x)
        let label = data[index].label
        let isShowValue = data[index].appearance.isShowValue ?? true
        if(isShowValue) {
            print("Tesrt")
        }
        return isShowValue ? label : ""
    }
}



extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}
