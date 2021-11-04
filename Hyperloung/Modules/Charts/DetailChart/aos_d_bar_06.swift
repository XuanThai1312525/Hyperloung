//
//  aos_d_bar_06.swift
//  Hyperloung
//
//  Created by Thai Nguyen on 11/3/21.
//

import UIKit
import Charts

class aos_d_bar_06: UIView {
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet var view: UIView!
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        Bundle.main.loadNibNamed("aos_d_bar_06", owner: self, options: nil)
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.fullscreen()
        layoutIfNeeded()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.setupView()
        }
    }
    
    let months = ["3Q", "4Q", "1Q", "2Q"]
    let unitsSold = [20.0, 4.0, 6.0, 3.0]
    let unitsBought = [10.0, 14.0, 60.0, 13.0]
    
    func setChart() {
        barChartView.noDataText = "You need to provide data for the chart."
        var dataEntries: [BarChartDataEntry] = []
        var dataEntries1: [BarChartDataEntry] = []
        
        for i in 0..<self.months.count {
            
            let dataEntry = BarChartDataEntry(x: Double(i) , y: self.unitsSold[i])
            dataEntries.append(dataEntry)
            
            let dataEntry1 = BarChartDataEntry(x: Double(i) , y: self.self.unitsBought[i])
            dataEntries1.append(dataEntry1)
        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Unit sold")
        let chartDataSet1 = BarChartDataSet(entries: dataEntries1, label: "Unit Bought")
        
        let dataSets: [BarChartDataSet] = [chartDataSet,chartDataSet1]
        chartDataSet = [#colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1), #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)]
        barChartView.legend.enabled = false
        barChartView.xAxis.drawAxisLineEnabled = false
        
        //chartDataSet.colors = ChartColorTemplates.colorful()
        //let chartData = BarChartData(dataSet: chartDataSet)
        
        let chartData = BarChartData(dataSets: dataSets)
        
        
        let groupSpace = 0.4
        let barSpace = 0.05
        let barWidth = 0.1
        // (0.3 + 0.05) * 2 + 0.3 = 1.00 -> interval per "group"
        
        let groupCount = self.months.count
        let startYear = 0
        
        
        chartData.barWidth = barWidth;
        barChartView.xAxis.axisMinimum = Double(startYear)
        let gg = chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        print("Groupspace: \(gg)")
        barChartView.xAxis.axisMaximum = Double(startYear) + gg * Double(groupCount)
        
        chartData.groupBars(fromX: Double(startYear), groupSpace: groupSpace, barSpace: barSpace)
        //chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        barChartView.notifyDataSetChanged()
        barChartView.data = chartData
        
        //background color
        //
    }
    
     
    private func setupView(){
        barChartView.noDataText = "You need to provide data for the chart."
        
        //legend
        let legend = barChartView.legend
        legend.enabled = true
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.orientation = .vertical
        legend.drawInside = true
        legend.yOffset = 10.0;
        legend.xOffset = 10.0;
        legend.yEntrySpace = 0.0;
        
        
        let xaxis = barChartView.xAxis
        //        xaxis.valueFormatter = axisFormatDelegate
        xaxis.drawGridLinesEnabled = false
        xaxis.labelPosition = .bottom
        xaxis.centerAxisLabelsEnabled = false
        xaxis.valueFormatter = IndexAxisValueFormatter(values:self.months)
        xaxis.granularity = 1
        
        
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.maximumFractionDigits = 1
        
        let yaxis = barChartView.leftAxis
        yaxis.labelCount = 2
        yaxis.axisMinimum = 0
        yaxis.drawAxisLineEnabled = false
        barChartView.rightAxis.enabled = false
        //axisFormatDelegate = self
        
        setChart()
    }
    
}
