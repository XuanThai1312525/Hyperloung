//
//  ReportChartViewController+AddDemoBarChart.swift
//  Hyperloung
//

import UIKit
import Charts

extension ReportChartViewController {
    func insertBarChart_aos_d_bar_01() {
        let barChartView = VeritalBarChartView(frame: CGRect(x: 50, y: 60, width: 400, height: 300))
        barChartView.clipsToBounds = false
        chartContainerStackView.insertArrangedSubview(barChartView, at: 0)
        barChartView.setHeight(200)
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 50))
        titleLabel.text = "Demo: aos_d_bar_01"
        chartContainerStackView.insertArrangedSubview(titleLabel, at: 0)
        titleLabel.setHeight(30)

        chartContainerStackView.layoutIfNeeded()
        
        
        barChartView.chartView.leftAxis.enabled = false
        let chartVisual: ChartVisual = ChartVisual(space: 50, width: 8, bottomTitleSpace: 0)
        barChartView.setChartVisual(chartVisual)
        var chartItems: [BarChartItemData] = []
        
        let barVisual: BarVisual = BarVisual(radius: 4, normalColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), highlightColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), normalTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), highlightTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        chartItems.append(BarChartItemData(title: "10울산", valueTitle: "5공식", value: 2.3, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "8울산", valueTitle: "15공식", value: 30.0, isHighlight: true, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "6울산", valueTitle: "45공식", value: 30.0, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "9울산", valueTitle: "75공식", value: 46.0, barVisual: barVisual))
        barChartView.setChartItems(items: chartItems)
    }
    
    func insertChartView_aos_d_bar_02() {
        let barChartView = VeritalBarChartView(frame: CGRect(x: 50, y: 60, width: 400, height: 300))
        barChartView.clipsToBounds = false
        chartContainerStackView.insertArrangedSubview(barChartView, at: 0)
        barChartView.setHeight(200)
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 50))
        titleLabel.text = "Demo: aos_d_bar_02"
        chartContainerStackView.insertArrangedSubview(titleLabel, at: 0)
        titleLabel.setHeight(30)

        chartContainerStackView.layoutIfNeeded()
        
        barChartView.chartView.leftAxis.enabled = false
        barChartView.addLimitLine(value: 26.0, title: "limit line")
        
        let chartVisual: ChartVisual = ChartVisual(space: 50, width: 8, bottomTitleSpace: 0)
        barChartView.setChartVisual(chartVisual)
        
        var chartItems: [BarChartItemData] = []
        let barVisual: BarVisual = BarVisual(radius: 4, normalColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), highlightColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), normalTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), highlightTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        chartItems.append(BarChartItemData(title: "10울산", valueTitle: "5공식", value: 2.3, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "8울산", valueTitle: "15공식", value: 30.0, isHighlight: true, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "6울산", valueTitle: "45공식", value: 30.0, barVisual: barVisual))

        barChartView.setChartItems(items: chartItems)
    }

    func insertChartView_aos_d_bar_03() {
        let barChartView = VeritalBarChartView(frame: CGRect(x: 50, y: 60, width: 400, height: 300))
        barChartView.clipsToBounds = false
        chartContainerStackView.insertArrangedSubview(barChartView, at: 0)
        barChartView.setHeight(200)
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 50))
        titleLabel.text = "Demo: aos_d_bar_03"
        chartContainerStackView.insertArrangedSubview(titleLabel, at: 0)
        titleLabel.setHeight(30)

        chartContainerStackView.layoutIfNeeded()
        
        barChartView.chartView.leftAxis.enabled = false
        
        let chartVisual: ChartVisual = ChartVisual(space: 50, width: 8, bottomTitleSpace: 0)
        barChartView.setChartVisual(chartVisual)
        
        var chartItems: [BarChartItemData] = []
        let barVisual: BarVisual = BarVisual(radius: 4, normalColor: #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1), highlightColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), normalTextColor: #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1), highlightTextColor: #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1))
        chartItems.append(BarChartItemData(title: "10울산", valueTitle: "5공식", value: 2.3, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "8울산", valueTitle: "15공식", value: 30.0, isHighlight: true, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "6울산", valueTitle: "45공식", value: 30.0, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "9울산", valueTitle: "75공식", value: 46.0, barVisual: barVisual))

        barChartView.setChartItems(items: chartItems)
    }
    
    
    func insertChartView_aos_d_bar_06() {
        let barChartView = VeritalBarChartView(frame: CGRect(x: 50, y: 60, width: 400, height: 300))
        barChartView.clipsToBounds = false
        chartContainerStackView.insertArrangedSubview(barChartView, at: 0)
        barChartView.setHeight(200)
        chartContainerStackView.layoutIfNeeded()

        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 50))
        titleLabel.text = "Demo: aos_d_bar_06"
        chartContainerStackView.insertArrangedSubview(titleLabel, at: 0)
        titleLabel.setHeight(30)

        
        barChartView.leftAxisUnit = "역"
        barChartView.chartView.leftAxis.enabled = true
        barChartView.chartView.leftAxis.drawLabelsEnabled = true
        barChartView.chartView.leftAxis.gridColor = #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1)
        
        let chartVisual: ChartVisual = ChartVisual(space: 50, width: 8, bottomTitleSpace: 0)
        barChartView.setChartVisual(chartVisual)
        
        var chartItems: [BarChartItemData] = []
        let barVisual: BarVisual = BarVisual(radius: 4, normalColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), highlightColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), normalTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), highlightTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        chartItems.append(BarChartItemData(title: "10울산", valueTitle: "5공식", value: 2.3, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "8울산", valueTitle: "15공식", value: 30.0, isHighlight: true, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "6울산", valueTitle: "45공식", value: 30.0, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "9울산", valueTitle: "75공식", value: 46.0, barVisual: barVisual))

        barChartView.setChartItems(items: chartItems)
    }
    
    func insertChartView_aos_d_bar_07() {
        let veriticalBarGroupChartView: VeriticalBarGroupChartView = VeriticalBarGroupChartView()
        chartContainerStackView.insertArrangedSubview(veriticalBarGroupChartView, at: 0)

        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 50))
        titleLabel.text = "Demo: aos_d_bar_07"
        chartContainerStackView.insertArrangedSubview(titleLabel, at: 0)
        titleLabel.setHeight(30)
        
        let months = ["Jan", "Feb", "Mar"]
        let unitsSold = [20.0, 4.0, 6.0]
        let unitsBought = [10.0, 14.0, 60.0]

        veriticalBarGroupChartView.setData(titles: months, colors: [#colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1), #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)], labels: ["울산", "공식"], items: [unitsSold, unitsBought], valueTitleList: [[],["col2 val1", "col2 val2", "col2 val3"]])
        
        veriticalBarGroupChartView.setHeight(200)
    }

    
    func insertChartView_aos_d_bar_04() {
        let barChartView = VerticalStackBarChart(frame: CGRect(x: 50, y: 60, width: 400, height: 300))
        barChartView.clipsToBounds = false
        chartContainerStackView.insertArrangedSubview(barChartView, at: 0)
//        view.addSubview(barChartView)
        barChartView.setHeight(250)
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 50))
        titleLabel.text = "Demo: aos_d_bar_04"
        chartContainerStackView.insertArrangedSubview(titleLabel, at: 0)
        titleLabel.setHeight(30)

        chartContainerStackView.layoutIfNeeded()
        
        
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
    
    
    func insertBarChart_aos_mb_bar_01() {
        let barChartView = VeritalBarChartView(frame: CGRect(x: 50, y: 60, width: 400, height: 300))
        barChartView.clipsToBounds = false
        chartContainerStackView.insertArrangedSubview(barChartView, at: 0)
        barChartView.setHeight(200)
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 50))
        titleLabel.text = "Demo: aos_mb_bar_01"
        chartContainerStackView.insertArrangedSubview(titleLabel, at: 0)
        titleLabel.setHeight(30)

        chartContainerStackView.layoutIfNeeded()
        
        
        barChartView.chartView.leftAxis.enabled = false
        let chartVisual: ChartVisual = ChartVisual(space: 24, width: 32, bottomTitleSpace: 5)
        barChartView.setChartVisual(chartVisual)
        var chartItems: [BarChartItemData] = []
        
        let barVisual: BarVisual = BarVisual(radius: 4, normalColor: #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1), highlightColor: #colorLiteral(red: 0.1411764706, green: 0.4352941176, blue: 0.9333333333, alpha: 1), normalTextColor: #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1), highlightTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        chartItems.append(BarChartItemData(title: "8울산", valueTitle: "", value: 30.0, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "6울산", valueTitle: "", value: 40.0, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "9울산", valueTitle: "75공식", value: 46.0, isHighlight: true,barVisual: barVisual))
        barChartView.setChartItems(items: chartItems)
    }
    
    func insertBarChart_aos_mb_bar_02() {
        let barChartView = VeritalBarChartView(frame: CGRect(x: 50, y: 60, width: 400, height: 300))
        barChartView.clipsToBounds = false
        chartContainerStackView.insertArrangedSubview(barChartView, at: 0)
        barChartView.setHeight(200)
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 50))
        titleLabel.text = "Demo: aos_mb_bar_02"
        chartContainerStackView.insertArrangedSubview(titleLabel, at: 0)
        titleLabel.setHeight(30)

        chartContainerStackView.layoutIfNeeded()
        
        
        barChartView.chartView.leftAxis.enabled = false
        let chartVisual: ChartVisual = ChartVisual(space: 24, width: 32, bottomTitleSpace: 5)
        barChartView.setChartVisual(chartVisual)
                
        var chartItems: [BarChartItemData] = []
        let barVisual: BarVisual = BarVisual(radius: 4, normalColor: #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1), highlightColor: #colorLiteral(red: 0.1411764706, green: 0.4352941176, blue: 0.9333333333, alpha: 1), normalTextColor: #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1), highlightTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        chartItems.append(BarChartItemData(title: "8울산", valueTitle: "A공식", value: 30.0, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "6울산", valueTitle: "B공식", value: 40.0, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "9울산", valueTitle: "C공식", value: 46.0, isHighlight: true, barVisual: barVisual))
        barChartView.setChartItems(items: chartItems)
    }
    
    func insertBarChart_aos_mb_bar_03() {
        let barChartView = VeritalBarChartView(frame: CGRect(x: 50, y: 60, width: 400, height: 300))
        barChartView.clipsToBounds = false
        chartContainerStackView.insertArrangedSubview(barChartView, at: 0)
        barChartView.setHeight(200)
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 50))
        titleLabel.text = "Demo: aos_mb_bar_03"
        chartContainerStackView.insertArrangedSubview(titleLabel, at: 0)
        titleLabel.setHeight(30)

        chartContainerStackView.layoutIfNeeded()
        
        
        barChartView.chartView.leftAxis.enabled = false
        let chartVisual: ChartVisual = ChartVisual(space: 24, width: 32, bottomTitleSpace: 5)
        barChartView.setChartVisual(chartVisual)
        barChartView.addLimitLine(value: 41, title: "")

        var chartItems: [BarChartItemData] = []
        let barVisual: BarVisual = BarVisual(radius: 4, normalColor: #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1), highlightColor: #colorLiteral(red: 0.1411764706, green: 0.4352941176, blue: 0.9333333333, alpha: 1), normalTextColor: #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1), highlightTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        chartItems.append(BarChartItemData(title: "8울산", valueTitle: "", value: 30.0, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "6울산", valueTitle: "", value: 40.0, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "9울산", valueTitle: "75공식", value: 46.0, isHighlight: true,barVisual: barVisual))
        barChartView.setChartItems(items: chartItems)
    }
    
    func insertBarChart_aos_mb_bar_04() {
        let barChartView = VeritalBarChartView(frame: CGRect(x: 50, y: 60, width: 400, height: 300))
        barChartView.clipsToBounds = false
        chartContainerStackView.insertArrangedSubview(barChartView, at: 0)
        barChartView.setHeight(200)
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 50))
        titleLabel.text = "Demo: aos_mb_bar_02"
        chartContainerStackView.insertArrangedSubview(titleLabel, at: 0)
        titleLabel.setHeight(30)

        chartContainerStackView.layoutIfNeeded()
        
        
        barChartView.chartView.leftAxis.enabled = false
        let chartVisual: ChartVisual = ChartVisual(space: 24, width: 32, bottomTitleSpace: 5)
        barChartView.setChartVisual(chartVisual)
        
        barChartView.addLimitLine(value: 41, title: "")
        
        var chartItems: [BarChartItemData] = []
        let barVisual: BarVisual = BarVisual(radius: 4, normalColor: #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1), highlightColor: #colorLiteral(red: 0.1411764706, green: 0.4352941176, blue: 0.9333333333, alpha: 1), normalTextColor: #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1), highlightTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        chartItems.append(BarChartItemData(title: "8울산", valueTitle: "A공식", value: 30.0, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "6울산", valueTitle: "B공식", value: 40.0, barVisual: barVisual))
        chartItems.append(BarChartItemData(title: "9울산", valueTitle: "C공식", value: 46.0, isHighlight: true, barVisual: barVisual))
        barChartView.setChartItems(items: chartItems)
    }
}

