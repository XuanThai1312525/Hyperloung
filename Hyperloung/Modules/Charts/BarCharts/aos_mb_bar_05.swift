//
//  aos_d_bar_01.swift
//  Hyperloung
//

import UIKit
import Charts

class aos_mb_bar_05: UIView {
    @IBOutlet weak var chartContainerView: UIView!
    @IBOutlet weak var chartNameLabel: UILabel!
    
    var barChartView: VeritalBarChartView!
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
        chartNameLabel.text = "aos_d_bar_05"
    }
    
    func setupUI() {
        barChartView = VeritalBarChartView()
        barChartView.clipsToBounds = false
        chartContainerView.addSubview(barChartView)
        barChartView.setHeight(175)
        barChartView.fullscreen()


        barChartView.isHaveLeftAxis = true
        let chartVisual: ChartVisual = ChartVisual(space: 24, width: 32, bottomTitleSpace: 5)
        barChartView.setChartVisual(chartVisual)
        
        let leftAxis = barChartView.chartView.leftAxis
        leftAxis.enabled = true
        leftAxis.entries = [35]
        leftAxis.granularityEnabled = true
        leftAxis.gridColor = #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1)
        leftAxis.gridLineWidth = 1
        leftAxis.gridLineDashLengths = [0,3]
        leftAxis.labelTextColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        leftAxis.setLabelCount(1, force: true)
        leftAxis.isForceEntriesEnable = true
        leftAxis.labelAlignment = .right
        leftAxis.valueFormatter  = LeftAxisValueFormat_aos_mb_bar_05()
        
        
        var limitLine = ChartLimitLine()
        limitLine = ChartLimitLine(limit: 22, label: "Hello")
        limitLine.lineColor = #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1)
        limitLine.valueTextColor = #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1)
        limitLine.lineWidth = 0.5
        limitLine.labelPosition = .bottomLeft
        barChartView.chartView.xAxis.addLimitLine(limitLine)
        
    }
    
    func setData() {
        var chartItems: [BarChartItemData] = []
        let barVisual: BarVisual = BarVisual(radius: 4, barNormalColor: #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1), barHighlightColor: #colorLiteral(red: 0.1411764706, green: 0.4352941176, blue: 0.9333333333, alpha: 1), valueNormalTextColor:  #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1),  valueHighlightTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), titleNormalTextColor: #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), titleHighlightTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        chartItems.append(BarChartItemData(title: "7월",  valueTitle: "",  value: 7, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "최대글자",  valueTitle: "21억", value: 21, isHighlight: true, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "9월", valueTitle: "", value: 9, barVisual: barVisual))
        barChartView.setChartItems(items: chartItems)

        barChartView.setChartLines(lines: [8,18,10])
    }
    
    func setDataMinus() {
        var chartItems: [BarChartItemData] = []
        let barVisual: BarVisual = BarVisual(radius: 4, barNormalColor: #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1), barHighlightColor: #colorLiteral(red: 0.9333333333, green: 0.1960784314, blue: 0.1411764706, alpha: 1), valueNormalTextColor:  #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1),  valueHighlightTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), titleNormalTextColor: #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), titleHighlightTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        chartItems.append(BarChartItemData(title: "7월",  valueTitle: "-7억",  value: -7, isHighlight: true, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "최대글자",  valueTitle: "21억", value: 21, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "9월", valueTitle: "9억", value: 9, barVisual: barVisual))
        barChartView.setChartItems(items: chartItems)

        barChartView.setChartLines(lines: [8,18,10])

    }
}


class LeftAxisValueFormat_aos_mb_bar_05: IAxisValueFormatter {
    func stringForValue(_ value: Double,
                        axis: AxisBase?) -> String {
        return "사업계획\n  300억"
    }
}
