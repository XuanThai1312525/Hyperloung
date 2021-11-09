//
//  aos_d_bar_01.swift
//  Hyperloung
//

import UIKit
import Charts

class aos_d_bar_02: UIView {
    @IBOutlet weak var chartContainerView: UIView!
    @IBOutlet weak var chartNameLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
        chartNameLabel.text = "aos_d_bar_02"
    }
    
    func setupUI() {
        let barChartView = VeritalBarChartView(frame: CGRect(x: 50, y: 60, width: 400, height: 300))
        barChartView.clipsToBounds = false
        chartContainerView.addSubview(barChartView)
        barChartView.centralize()
        barChartView.setHeight(190)

        let leftAxis = barChartView.chartView.leftAxis
        leftAxis.enabled = true
        
        
        leftAxis.entries = [70]
        leftAxis.granularityEnabled = true
        leftAxis.gridColor = #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1)
        leftAxis.gridLineWidth = 1
        leftAxis.gridLineDashLengths = [0,3]
        leftAxis.labelTextColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        leftAxis.setLabelCount(1, force: true)
        leftAxis.isForceEntriesEnable = true
        leftAxis.labelAlignment = .right
        leftAxis.valueFormatter  = LeftAxisValueFormat_aos_d_bar_02()
        
        let chartVisual: ChartVisual = ChartVisual(space: 56, width: 8, bottomTitleSpace: 4)
        barChartView.setChartVisual(chartVisual)
        
//        barChartView.addLimitLine(value: 60.0, title: "limit line")

        var chartItems: [BarChartItemData] = []

        let barVisual: BarVisual = BarVisual(radius: 4, barNormalColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), barHighlightColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), valueNormalTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), valueHighlightTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), titleNormalTextColor: #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), titleHighlightTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        chartItems.append(BarChartItemData(title: "외상매출", valueTitle: "20.3억", value: 20.3, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "받을어음", valueTitle: "123억", value: 123.0, isHighlight: true, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "기타", valueTitle: "89.9억", value: 89.9, barVisual: barVisual))
        barChartView.setChartItems(items: chartItems)
    }
    

}

class LeftAxisValueFormat_aos_d_bar_02: IAxisValueFormatter {
    func stringForValue(_ value: Double,
                        axis: AxisBase?) -> String {
        return "사업계획\n100억"
    }
}
