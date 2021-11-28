//
//  aos_d_bar_01.swift
//  Hyperloung
//

import UIKit
import Charts

class aos_d_bar_06: UIView {
    @IBOutlet weak var chartContainerView: UIView!
    @IBOutlet weak var chartNameLabel: UILabel!
    
    var barChartView: VeritalBarChartView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
        chartNameLabel.text = "aos_d_bar_06"
    }
    
    func setupUI() {
        barChartView = VeritalBarChartView(frame: CGRect(x: 50, y: 60, width: 400, height: 300))
        barChartView.clipsToBounds = false
        chartContainerView.addSubview(barChartView)
        barChartView.centralize()
        barChartView.setHeight(190)

        barChartView.chartView.leftAxis.enabled = true
        barChartView.chartView.leftAxis.drawLabelsEnabled = true
        barChartView.chartView.leftAxis.gridColor = #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1)
        barChartView.setLeftAxisSuffix("역")
        
        let leftAxis = barChartView.chartView.leftAxis
        leftAxis.granularityEnabled = true
        leftAxis.gridColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        leftAxis.gridLineWidth = 1
        leftAxis.labelTextColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        leftAxis.setLabelCount(1, force: true)
        leftAxis.isForceEntriesEnable = true
        leftAxis.labelAlignment = .right
        leftAxis.valueFormatter  = LeftAxisValueFormat_aos_d_bar_06()
        
        let chartVisual: ChartVisual = ChartVisual(space: 56, width: 8, bottomTitleSpace: 4)
        barChartView.setChartVisual(chartVisual)
    }
    
    func setData() {
        barChartView.chartView.leftAxis.entries = [0, 617, 1234]

        let barVisual: BarVisual = BarVisual(radius: 4, barNormalColor: #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1), barHighlightColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), valueNormalTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), valueHighlightTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), titleNormalTextColor: #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), titleHighlightTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        
        var chartItems: [BarChartItemData] = []
        chartItems.append(BarChartItemData(title: "외상매출", valueTitle: "15.9억", value: 100, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "받을어음", valueTitle: "29.2억", value: 400, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "기타", valueTitle: "72억", value: 550.9, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "기타", valueTitle: "89.9억", value: 1234, isHighlight: false, barVisual: barVisual))

        barChartView.setChartItems(items: chartItems)
    }
    
    func setDataMinus() {
        barChartView.chartView.leftAxis.entries = [0, 617, 1234, -600]

        let barVisual: BarVisual = BarVisual(radius: 4, barNormalColor: #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1), barHighlightColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), valueNormalTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), valueHighlightTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), titleNormalTextColor: #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), titleHighlightTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        
        var chartItems: [BarChartItemData] = []
        chartItems.append(BarChartItemData(title: "외상매출", valueTitle: "-15.9억", value: -100, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "받을어음", valueTitle: "29.2억", value: 400, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "기타", valueTitle: "72억", value: 550.9, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "기타", valueTitle: "89.9억", value: 1234, isHighlight: true, barVisual: barVisual))

        barChartView.setChartItems(items: chartItems)
    }
}

class LeftAxisValueFormat_aos_d_bar_06: IAxisValueFormatter {
    func stringForValue(_ value: Double,
                        axis: AxisBase?) -> String {
        return String(format: "%g", value) + (value == 0 ? "" : "억")
    }
}
