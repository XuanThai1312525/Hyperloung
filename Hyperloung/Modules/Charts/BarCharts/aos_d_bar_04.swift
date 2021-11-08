//
//  aos_d_bar_01.swift
//  Hyperloung
//

import UIKit

class aos_d_bar_04: UIView {
    @IBOutlet weak var chartContainerView: UIView!
    @IBOutlet weak var chartNameLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
        chartNameLabel.text = "aos_d_bar_04"
    }
    
    func setupUI() {
        let barChartView = VerticalStackBarChart(frame: CGRect(x: 50, y: 60, width: 400, height: 300))
        barChartView.clipsToBounds = false
        chartContainerView.addSubview(barChartView)
        barChartView.centralize()
        barChartView.setHeight(250)



//        let barChartView = VerticalStackBarChart(frame: CGRect(x: 50, y: 60, width: 400, height: 300))
//        barChartView.clipsToBounds = false
//        chartContainerStackView.insertArrangedSubview(barChartView, at: 0)
////        view.addSubview(barChartView)
//        barChartView.setHeight(250)
        
        
        let chartVisual: StackBarChartVisual = StackBarChartVisual(space: 56, width: 8, bottomTitleSpace: 4)
        barChartView.setStackBarChartVisual(chartVisual)
        
        var chartItems: [StackBarChartItemData] = []
        let barVisual: StackBarVisual = StackBarVisual(radius: 4, normalColor: #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1), highlightColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), normalTextColor: #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1), highlightTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        chartItems.append(StackBarChartItemData(stackItems: [StactBarItem(color: #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), value: 8.3), StactBarItem(color: #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1), value: 6.0), StactBarItem(color: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), value: 7.0)], title: "외상매출", valueTitle: "22.3억", value: 2.3, barVisual: barVisual))
        chartItems.append(StackBarChartItemData(stackItems: [StactBarItem(color: #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), value: 14.0), StactBarItem(color: #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1), value: 18.0), StactBarItem(color: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), value: 14.0)],title: "받을어음", valueTitle: "823억", value: 30.0, barVisual: barVisual))
        chartItems.append(StackBarChartItemData(stackItems: [StactBarItem(color: #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), value: 21.0), StactBarItem(color: #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1), value: 23.0), StactBarItem(color: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), value: 22.0)], title: "기타", valueTitle: "672억", value: 30.0, barVisual: barVisual))
        chartItems.append(StackBarChartItemData(stackItems: [StactBarItem(color: #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), value: 31.0), StactBarItem(color: #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1), value: 22.0), StactBarItem(color: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), value: 23.0)], title: "기타", valueTitle: "1,234억", value: 30.0, barVisual: barVisual))

        barChartView.setChartItems(items: chartItems)
    }
}
