//
//  DemoViewController.swift
//  Hyperloung
//
//  Created by Thai Nguyen on 11/9/21.
//

import UIKit

class DemoViewController: UIViewController {
    @IBOutlet var containerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        insertChartView_aos_d_bar_04()
    }


    func insertChartView_aos_d_bar_04() {
        let barChartView = VerticalStackBarChart(frame: CGRect(x: 50, y: 60, width: 400, height: 300))
        barChartView.clipsToBounds = false
        containerView.addSubview(barChartView)
        barChartView.fullscreen()
        
        let chartVisual: StackBarChartVisual = StackBarChartVisual(space: 50, width: 8, bottomTitleSpace: 0)
        barChartView.setStackBarChartVisual(chartVisual)
        
        var chartItems: [StackBarChartItemData] = []
        let barVisual: StackBarVisual = StackBarVisual(radius: 4, normalColor: #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1), highlightColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), normalTextColor: #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1), highlightTextColor: #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1))
        chartItems.append(StackBarChartItemData(stackItems: [StactBarItem(color: #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), value: 25.0), StactBarItem(color: #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1), value: 6.0), StactBarItem(color: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), value: 7.0)], title: "10울산", valueTitle: "5공식", value: 2.3, barVisual: barVisual))
        chartItems.append(StackBarChartItemData(stackItems: [StactBarItem(color: #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), value: 8.0), StactBarItem(color: #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1), value: 9.0), StactBarItem(color: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), value: 10.0)],title: "8울산", valueTitle: "15공식", value: 30.0, isHighlight: true, barVisual: barVisual))
        chartItems.append(StackBarChartItemData(stackItems: [StactBarItem(color: #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), value: 11.0), StactBarItem(color: #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1), value: 12.0), StactBarItem(color: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), value: 13.0)], title: "6울산", valueTitle: "45공식", value: 30.0, barVisual: barVisual))
        chartItems.append(StackBarChartItemData(stackItems: [StactBarItem(color: #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), value: 14.0), StactBarItem(color: #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1), value: 5.0), StactBarItem(color: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), value: 6.0)], title: "9울산", valueTitle: "75공식", value: 26.0, barVisual: barVisual))

        barChartView.setChartItems(items: chartItems)
    }
}
