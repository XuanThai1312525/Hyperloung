//
//  aos_d_bar_01.swift
//  Hyperloung
//

import UIKit

class aos_mb_bar_02_: UIView {
    @IBOutlet weak var chartContainerView: UIView!
    @IBOutlet weak var chartNameLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
        chartNameLabel.text = "mb_bar_02"
    }
    
    func setupUI() {
        let barChartView = VeritalBarChartView(frame: CGRect(x: 50, y: 60, width: 400, height: 300))
        barChartView.clipsToBounds = false
        chartContainerView.addSubview(barChartView)
        barChartView.centralize()
        barChartView.setHeight(190)
        
        barChartView.chartView.leftAxis.axisMinimum = 0
        barChartView.barHightlighColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)

        barChartView.chartView.leftAxis.enabled = false
        let chartVisual: ChartVisual = ChartVisual(space: 24, width: 32, bottomTitleSpace: 5)
        barChartView.setChartVisual(chartVisual)
        var chartItems: [BarChartItemData] = []
        
        
        let barVisual: BarVisual = BarVisual(radius: 4, barNormalColor: #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1), barHighlightColor: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), valueNormalTextColor: #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1), valueHighlightTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), titleNormalTextColor: #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), titleHighlightTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        chartItems.append(BarChartItemData(title: "7월",  valueTitle: "85억", value: -80.0, isHighlight: true, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "최대글자", valueTitle: "213억", value: 40.0, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "9월",  valueTitle: "365억", value: -46.0, barVisual: barVisual))
        barChartView.setChartItems(items: chartItems)

    }
}
