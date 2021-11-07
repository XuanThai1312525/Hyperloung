//
//  aos_mb_pie_01.swift
//  Hyperloung
//
//  Created by Thai Nguyen on 11/2/21.
//

import UIKit
import Charts

class aos_mb_pie_01: UIView, ChartViewDelegate {
    private var chartView: PieChartView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateChartData()
    }
    
    func updateChartData()  {
        
        let chart = PieChartView(frame: bounds)
        let money = [38, 22, 18, 20]
        
        var entries = [PieChartDataEntry]()
        for (index, value) in money.enumerated() {
            let entry = PieChartDataEntry()
            entry.y = Double(value)
//            entry.label = track[index]
            entries.append( entry)
        }
        
        // 3. chart setup
        let set = PieChartDataSet( entries: entries, label: "Pie Chart")
        // this is custom extension method. Download the code for more details.
        set.drawValuesEnabled = false
//        set.drawEntryLabelsEnabled = false
        chart.drawEntryLabelsEnabled = false
        var colors: [UIColor] = []
        chart.legend.enabled = false
        [#colorLiteral(red: 0.2078431373, green: 0.3411764706, blue: 0.7882352941, alpha: 1),#colorLiteral(red: 0.1215686275, green: 0.5725490196, blue: 0.8941176471, alpha: 1),#colorLiteral(red: 0.3803921569, green: 0.8156862745, blue: 0.9411764706, alpha: 1),#colorLiteral(red: 0.2941176471, green: 0.7725490196, blue: 0.7647058824, alpha: 1)].forEach { color in
            colors.append(color)
        }
        
        set.colors = colors
        let data = PieChartData(dataSet: set)
        chart.data = data
        chart.noDataText = "No data available"
        // user interaction
        chart.isUserInteractionEnabled = true
        
        chart.centerText = "39.6억"
        chart.holeRadiusPercent = 0.65
        
        chart.transparentCircleColor = UIColor.clear
        addSubview(chart)
        chart.fullscreen()
    }

}

