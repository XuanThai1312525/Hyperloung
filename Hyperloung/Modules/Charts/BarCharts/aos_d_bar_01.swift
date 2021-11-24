//
//  aos_d_bar_01.swift
//  Hyperloung
//

import UIKit

class aos_d_bar_01: UIView {
    @IBOutlet weak var chartContainerView: UIView!
    @IBOutlet weak var chartNameLabel: UILabel!
    
    var barChartView: VeritalBarChartView!
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
        chartNameLabel.text = "aos_d_bar_01"
    }
    
    func setupUI() {
        barChartView = VeritalBarChartView(frame: CGRect(x: 50, y: 60, width: 400, height: 300))
        barChartView.clipsToBounds = false
        chartContainerView.addSubview(barChartView)
        barChartView.centralize()
        barChartView.setHeight(190)

        barChartView.chartView.leftAxis.enabled = true
        let chartVisual: ChartVisual = ChartVisual(space: 56, width: 8, bottomTitleSpace: 4)
        barChartView.setChartVisual(chartVisual)

        setData()
    }
    
    func setData() {
        let barVisual: BarVisual = BarVisual(radius: 4, barNormalColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), barHighlightColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), valueNormalTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), valueHighlightTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), titleNormalTextColor: #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), titleHighlightTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        
        var chartItems: [BarChartItemData] = []
        chartItems.append(BarChartItemData(title: "외상매출", valueTitle: "20.3억", value: 20.3, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "받을어음", valueTitle: "123억", value: 123.0, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "기타", valueTitle: "89.9억", value: 89.9, barVisual: barVisual))
        barChartView.setChartItems(items: chartItems)

    }
    
    func setDataMinus() {
        let barVisual: BarVisual = BarVisual(radius: 4, barNormalColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), barHighlightColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), valueNormalTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), valueHighlightTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), titleNormalTextColor: #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), titleHighlightTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        
        var chartItems: [BarChartItemData] = []
        chartItems.append(BarChartItemData(title: "외상매출", valueTitle: "-20.3억", value: -20.3, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "받을어음", valueTitle: "123억", value: 123.0, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "기타", valueTitle: "89.9억", value: 89.9, barVisual: barVisual))
        barChartView.setChartItems(items: chartItems)

    }
}
