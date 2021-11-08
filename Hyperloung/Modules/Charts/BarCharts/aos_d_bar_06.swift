//
//  aos_d_bar_01.swift
//  Hyperloung
//

import UIKit

class aos_d_bar_06: UIView {
    @IBOutlet weak var chartContainerView: UIView!
    @IBOutlet weak var chartNameLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
        chartNameLabel.text = "aos_d_bar_06"
    }
    
    func setupUI() {
        let barChartView = VeritalBarChartView(frame: CGRect(x: 50, y: 60, width: 400, height: 300))
        barChartView.clipsToBounds = false
        chartContainerView.addSubview(barChartView)
        barChartView.centralize()
        barChartView.setHeight(190)

        barChartView.chartView.leftAxis.enabled = true
        barChartView.chartView.leftAxis.drawLabelsEnabled = true
        barChartView.chartView.leftAxis.gridColor = #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1)
        barChartView.setLeftAxisSuffix("역")
        
        let chartVisual: ChartVisual = ChartVisual(space: 56, width: 8, bottomTitleSpace: 4)
        barChartView.setChartVisual(chartVisual)
        var chartItems: [BarChartItemData] = []

        let barVisual: BarVisual = BarVisual(radius: 4, barNormalColor: #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1), barHighlightColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), valueNormalTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), valueHighlightTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), titleNormalTextColor: #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), titleHighlightTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        chartItems.append(BarChartItemData(title: "외상매출", valueTitle: "", value: 20.3, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "받을어음", valueTitle: "", value: 53.0, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "기타", valueTitle: "", value: 69.9, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "기타", valueTitle: "89.9억", value: 89.9, isHighlight: true, barVisual: barVisual))

        barChartView.setChartItems(items: chartItems)
    }
}
