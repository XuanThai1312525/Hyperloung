//
//  aos_d_bar_01.swift
//  Hyperloung
//

import UIKit
import Charts

class aos_mb_bar_04_: UIView {
    @IBOutlet weak var chartContainerView: UIView!
    @IBOutlet weak var chartNameLabel: UILabel!
    
    var barChartView: VeritalBarChartView!
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
        chartNameLabel.text = "mb_bar_04"
    }
    
    func setupUI() {
        barChartView = VeritalBarChartView(frame: CGRect(x: 50, y: 60, width: 400, height: 300))
        barChartView.clipsToBounds = false
        chartContainerView.addSubview(barChartView)
        barChartView.centralize()
        barChartView.setHeight(190)


        barChartView.isHaveLeftAxis = true
        barChartView.chartView.leftAxis.enabled = false
        let chartVisual: ChartVisual = ChartVisual(space: 24, width: 32, bottomTitleSpace: 5)
        barChartView.setChartVisual(chartVisual)
        
        let leftAxis = barChartView.chartView.leftAxis
        leftAxis.enabled = true
        leftAxis.entries = [35]
        leftAxis.granularityEnabled = true
        leftAxis.gridColor = #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1)
        leftAxis.gridLineWidth = 2
        leftAxis.gridLineDashLengths = [0,3]
        leftAxis.labelTextColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        leftAxis.setLabelCount(1, force: true)
        leftAxis.isForceEntriesEnable = true
        leftAxis.labelAlignment = .left
        leftAxis.valueFormatter  = LeftAxisValueFormat_aos_mb_bar_04_()
        
        leftAxis.axisMinimum = 0
        leftAxis.drawZeroLineEnabled = false
    }
    
    func setData() {
        let barVisual: BarVisual = BarVisual(radius: 4, barNormalColor: #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1), barHighlightColor: #colorLiteral(red: 0.1411764706, green: 0.4352941176, blue: 0.9333333333, alpha: 1), valueNormalTextColor: #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1), valueHighlightTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), titleNormalTextColor: #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), titleHighlightTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        
        var chartItems: [BarChartItemData] = []
        chartItems.append(BarChartItemData(title: "7월",  valueTitle: "85억",  value: 85, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "최대글자", valueTitle: "213억", value: 213, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "9월",  valueTitle: "365억", value: 365, isHighlight: true, barVisual: barVisual))
        barChartView.setChartItems(items: chartItems)
    }
    
    func setDataMinus() {
        let barVisual: BarVisual = BarVisual(radius: 4, barNormalColor: #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1), barHighlightColor: #colorLiteral(red: 0.9333333333, green: 0.1960784314, blue: 0.1411764706, alpha: 1), valueNormalTextColor: #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1), valueHighlightTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), titleNormalTextColor: #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), titleHighlightTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        
        var chartItems: [BarChartItemData] = []
        chartItems.append(BarChartItemData(title: "7월",  valueTitle: "-85억",  value: -85, isHighlight: true, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "최대글자", valueTitle: "213억", value: 213, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "9월",  valueTitle: "365억", value: 365, barVisual: barVisual))
        barChartView.setChartItems(items: chartItems)
    }
}


class LeftAxisValueFormat_aos_mb_bar_04_: IAxisValueFormatter {
    func stringForValue(_ value: Double,
                        axis: AxisBase?) -> String {
        return "사업계획\n 300억"
    }
}
