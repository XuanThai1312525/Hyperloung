//
//  aos_d_bar_01.swift
//  Hyperloung
//

import UIKit
import Charts

class aos_mb_bar_06: UIView {
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
        barChartView = VeritalBarChartView()
        barChartView.clipsToBounds = false
        chartContainerView.addSubview(barChartView)
        barChartView.setHeight(175)
        barChartView.fullscreen()


        barChartView.isHaveLeftAxis = true
        barChartView.chartView.leftAxis.enabled = false
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
        leftAxis.valueFormatter  = LeftAxisValueFormat_aos_mb_bar_06()
        leftAxis.axisMinimum = 0 // FIXME: HUH?? this replaces startAtZero = YES
        leftAxis.drawZeroLineEnabled = false

    }
    
    func setData() {
        var chartItems: [BarChartItemData] = []
        let barVisual: BarVisual = BarVisual(radius: 4, barNormalColor: #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1), barHighlightColor: #colorLiteral(red: 0.1411764706, green: 0.4352941176, blue: 0.9333333333, alpha: 1), valueNormalTextColor: #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1), valueHighlightTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), titleNormalTextColor: #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), titleHighlightTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        chartItems.append(BarChartItemData(title: "7월",  valueTitle: "",  value: 85, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "최대글자", valueTitle: "", value: 162, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "9월",  valueTitle: "365억", value: 365, isHighlight: true, barVisual: barVisual))
        barChartView.setChartItems(items: chartItems)
    }
    
    func setDataMinus() {
        var chartItems: [BarChartItemData] = []
        let barVisual: BarVisual = BarVisual(radius: 4, barNormalColor: #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1), barHighlightColor: #colorLiteral(red: 0.9333333333, green: 0.1960784314, blue: 0.1411764706, alpha: 1), valueNormalTextColor: #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1), valueHighlightTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), titleNormalTextColor: #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), titleHighlightTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        chartItems.append(BarChartItemData(title: "7월",  valueTitle: "-85월",  value: -85, isHighlight: true, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "최대글자", valueTitle: "162월", value: 162, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "9월",  valueTitle: "365억", value: 365, barVisual: barVisual))
        barChartView.setChartItems(items: chartItems)
    }
}



class LeftAxisValueFormat_aos_mb_bar_06: IAxisValueFormatter {
    func stringForValue(_ value: Double,
                        axis: AxisBase?) -> String {
        return "사업계획\n  300억"
    }
}
