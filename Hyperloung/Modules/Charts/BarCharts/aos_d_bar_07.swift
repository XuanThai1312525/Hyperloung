//
//  aos_d_bar_01.swift
//  Hyperloung
//

import UIKit
import Charts

class aos_d_bar_07: UIView {
    @IBOutlet weak var chartContainerView: UIView!
    @IBOutlet weak var chartNameLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
        chartNameLabel.text = "aos_d_bar_07"
    }
    
    func setupUI() {
        let barChartView: VeriticalBarGroupChartView = VeriticalBarGroupChartView()
        barChartView.clipsToBounds = false
        chartContainerView.addSubview(barChartView)
        barChartView.centralize()
        barChartView.setHeight(190)

        let leftAxis = barChartView.chartView.leftAxis
        leftAxis.enabled = true
        leftAxis.gridColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        leftAxis.gridLineWidth = 1
        leftAxis.labelTextColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        leftAxis.axisLineColor = .clear
        leftAxis.axisMinimum = 0
        
        leftAxis.entries = [0, 617, 1234]
        leftAxis.setLabelCount(3, force: true)
//        leftAxis.isForceEntriesEnable = true
        leftAxis.labelAlignment = .right
        leftAxis.valueFormatter  = LeftAxisValueFormat_aos_d_bar_07()

        let months = ["Text", "Text", "Text"]
        let col1: [Double] = [56, 720, 600]
        let col2: [Double] = [22.3, 812, 1234]

        barChartView.setData(titles: months, colors: [#colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1), #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)], labels: ["범례1", "범례2"], items: [col1, col2], valueTitleList: [[],["22.3억", "812억", "1234억"]])
    }
}

class LeftAxisValueFormat_aos_d_bar_07: IAxisValueFormatter {
    func stringForValue(_ value: Double,
                        axis: AxisBase?) -> String {
        return (String(format: "%g", value).thousandString ?? "") + (value == 0 ? "" : "억")
    }
}
