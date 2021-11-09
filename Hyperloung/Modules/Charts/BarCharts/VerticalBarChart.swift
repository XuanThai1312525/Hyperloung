//
//  VerticalBarChart.swift
//  Hyperloung
//

import UIKit
import Charts

struct ChartVisual {
    var space: Int
    var width: Int
    var bottomTitleSpace: CGFloat = 0
    var fontForValueLabel: UIFont = UIFont.bold(size: 12)
    var fontForXaxisLabel: UIFont = UIFont.normal(size: 12)
    static var defaultVisual: ChartVisual {
        return ChartVisual(space: 24, width: 32)
    }
}

struct BarChartItemData {
    var title: String
    var valueTitle: String
    var value: Double
    var isHighlight: Bool = false

    var barVisual: BarVisual
}

struct BarVisual {
    var radius: Double
    var barNormalColor: UIColor
    var barHighlightColor: UIColor
    var valueNormalTextColor: UIColor
    var valueHighlightTextColor: UIColor
    var titleNormalTextColor: UIColor
    var titleHighlightTextColor: UIColor

    var isHighlight: Bool = false
    
    static func defaultVisual() -> BarVisual {
        return BarVisual(radius: 4.0, barNormalColor: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), barHighlightColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), valueNormalTextColor: #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1), valueHighlightTextColor: #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1), titleNormalTextColor: #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), titleHighlightTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
    }
}

class VeritalBarChartView: UIView {
    // MARK: Properties
    var chartView: BarChartView!
    var visual: ChartVisual = ChartVisual.defaultVisual
    private var numOfBar: Int = 3
    var chartItems: [BarChartItemData] = []
    var leftAxisUnit: String = ""
    var isHaveLeftAxis: Bool = false
    
    // MARK: LifeCycle
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    private func customInit() {
        let width = CGFloat(visual.width * numOfBar + visual.space * (numOfBar - 1))
        chartView = BarChartView(frame: CGRect(x: 0, y: 0, width: width, height: 200))
        addSubview(chartView)
        chartView.centralize()
        chartView.setBottom(0, relativeToView: self)
        chartView.setWidth(width)
        setup(barLineChartView: chartView)
        
//        setDataCount(numOfBar, range: 50, highlight: 2)
        

    }
    
    func updateChartViewSize() {
        let width = CGFloat(visual.width * numOfBar + visual.space * (numOfBar - 1)) + 50 + (isHaveLeftAxis ? 50 : 0) // 30 is additonal padding for xaxis label
        var frame = chartView.frame
        frame.size.width = width
        chartView.setWidth(width)
//        chartView.barData?.barWidth = Double(numOfBar * visual.width) / Double(width) - 0.3
//        chartView.frame = frame
    }
    
    func setChartVisual(_ visual: ChartVisual) {
        self.visual = visual
        chartView.xAxis.yOffset = visual.bottomTitleSpace // spacing bottom  bar title - bar rect
        updateChartViewSize()
    }
    
    func setLeftAxisSuffix(_ string: String) {
        leftAxisUnit = string
        chartView.leftAxis.valueFormatter = VerticalBarLeftAxisValueFormatter(unit: leftAxisUnit)

    }
    
    func addLimitLine(value: Double, title: String) {
        var limitLine = ChartLimitLine()
        limitLine = ChartLimitLine(limit: value, label: title)
        limitLine.lineColor = #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1)
        limitLine.valueTextColor = #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1)
        limitLine.lineWidth = 0.5
        limitLine.labelPosition = .topLeft
        limitLine.yOffset = 0
        limitLine.lineDashLengths = [3.0]
        chartView.rightAxis.addLimitLine(limitLine)

    }
    
    func setChartItems(items: [BarChartItemData], isNeedToHighLight: Bool = false) {
        numOfBar = items.count
        updateChartViewSize()
        var yVals: [BarChartDataEntry] = []
        var index:Double = 0
        var highLight: Highlight?
        items.forEach { item in
            let data = BarChartDataEntry(x: index, y: item.value , data: item)
            yVals.append(data)
            
            if(item.isHighlight) {
                highLight = Highlight(x: index, y: item.value, dataSetIndex: 0)
            }
            
            index += 1
        }
        
        chartView.xAxis.valueFormatter = VerticalBarXAxisLabelFormatter(barItems: items)
        chartView.xAxis.setLabelCount(numOfBar, force: false)

        let dataSet: HyperChartBaseDataSet = HyperChartBaseDataSet(entries: yVals, label: "Hi Legend ")
        dataSet.colors = [.black, .green, .gray] // array always have more than 1 item so "color(atIndex index: Int)" to be called
        dataSet.drawValuesEnabled = true
        dataSet.barCornerRadius = 4
        dataSet.valueFormatter = VerticalBarValueFormatter(barItems: items)
        dataSet.stackLabels = ["Births", "Divorces", "Marriages"]

                
        let data = BarChartData(dataSet: dataSet)
        data.setValueFont(visual.fontForValueLabel)
        data.setValueTextColor( .black)
        data.barWidth = calculateBarWidth()
        
        chartView.data = data
        
        if isNeedToHighLight, let highLight = highLight{
            //5 is value for display above or bellow
            chartView.setExtraOffsets(left: 30, top: 45, right: 30, bottom: 0)
            chartView.marker = HyperMarker(config: IMarkerConfig(label: items[Int(highLight.x)].valueTitle, selectedLabelFont: UIFont.boldSystemFont(ofSize: 13), bottomValueToCircle: 15, selectedValueRoundColor: "#DDDDDD".color))
            dataSet.valueSpacing = 15
            chartView.highlightValue(highLight)
        }
    }
        
    // MARK: Functions
    /*
     Because BarChartView will calculate the with of bar by percentage,
     It will calculate by with and number of item
     But our design persist  with and space so the with of BarChartView will change by number of view and visual
     **/
    
    func setup(barLineChartView chartView: BarChartView) {
        chartView.isUserInteractionEnabled = false
        
        chartView.chartDescription?.enabled = false
        
        chartView.dragEnabled = false
        chartView.setScaleEnabled(false)
        chartView.pinchZoomEnabled = false
        chartView.drawBarShadowEnabled = false
        
        // ChartYAxis *leftAxis = chartView.leftAxis;
        chartView.xAxis.wordWrapEnabled = true
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.axisLineColor = .clear
        chartView.xAxis.granularity = 1
        
        chartView.rightAxis.enabled = true
        chartView.rightAxis.axisLineColor = .clear
        chartView.rightAxis.drawLabelsEnabled = false // Hide label
        chartView.rightAxis.drawGridLinesEnabled = false

        chartView.leftAxis.enabled = true
        chartView.leftAxis.axisLineColor = .clear
        chartView.leftAxis.drawLabelsEnabled = true // Hide label
        chartView.leftAxis.drawGridLinesEnabled = true
        chartView.leftAxis.gridColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        chartView.leftAxis.valueFormatter = VerticalBarLeftAxisValueFormatter(unit: leftAxisUnit)
            
        chartView.legend.enabled = false

        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelTextColor = #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1)
        xAxis.labelFont = visual.fontForXaxisLabel
        
        // set bottom item titles
        chartView.xAxis.yOffset = visual.bottomTitleSpace // spacing bottom  bar title - bar rect
//        chartView.xAxis.valueFormatter = VerticalBarValueFormatter(barItems: chartItems)
//        chartView.highlightValues([Highlight(x: 2, dataSetIndex: 1, stackIndex: 0)])
        
    }
        
    func calculateBarWidth() -> Double {
        let width = CGFloat(visual.width * numOfBar + visual.space * (numOfBar - 1)) + 50
        return Double(visual.width * numOfBar) / Double(width)
    }
    
}

class HyperChartBaseDataSet: BarChartDataSet {
    override init(entries: [ChartDataEntry]?, label: String?) {
        super.init(entries: entries, label: label)
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    // body Bar color
    override func color(atIndex index: Int) -> NSUIColor {
        let entry = entries[index]
        if let data = entry.data as? BarChartItemData {
            return data.isHighlight ? data.barVisual.barHighlightColor : data.barVisual.barNormalColor
        }
        return UIColor.red
    }
    
    // value title color on top of each bar
    override func valueTextColorAt(_ index: Int) -> NSUIColor {
        let entry = entries[index]
        if let data = entry.data as? BarChartItemData {
            return data.isHighlight ? data.barVisual.valueHighlightTextColor : data.barVisual.valueNormalTextColor
        }
        
        return UIColor.red
    }
}


class VerticalBarXAxisLabelFormatter: NSObject, IAxisValueFormatter {
    var barItems: [BarChartItemData] = []
    
    init(barItems: [BarChartItemData]) {
        self.barItems = barItems
    }

    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let index = Int(value)
        if index < barItems.count {
            return barItems[index].title
        }

        return ""
    }

    public func colorForValue(_ value: Double, axis: AxisBase?) -> UIColor? {
        let index = Int(value)
        if barItems.count > index {
            let item = barItems[index]

            return item.isHighlight ? item.barVisual.valueHighlightTextColor : item.barVisual.valueNormalTextColor
        }
        return nil
    }
}


public class VerticalBarValueFormatter: NSObject, IValueFormatter, IAxisValueFormatter {
    var barItems: [BarChartItemData] = []
    
    init(barItems: [BarChartItemData]) {
        self.barItems = barItems
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let index = Int(value)
        if index < barItems.count {
            return barItems[index].valueTitle
        }
        return ""
    }
    
    public func stringForValue(
        _ value: Double,
        entry: ChartDataEntry,
        dataSetIndex: Int,
        viewPortHandler: ViewPortHandler?) -> String {
        if let data = entry.data as? BarChartItemData {
            return data.valueTitle
        }
        return ""
    }
    
    public func colorForValue(_ value: Double, axis: AxisBase?) -> UIColor? {
        let index = Int(value)
        if barItems.count > index {
            let item = barItems[index]

            return item.isHighlight ? item.barVisual.valueHighlightTextColor : item.barVisual.valueNormalTextColor
        }
        return nil
    }
}


public class VerticalBarLeftAxisValueFormatter: NSObject, IAxisValueFormatter {
    let unit: String
    init(unit: String) {
        self.unit = unit
    }
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return unit.isEmpty ? String(format: "%g", value) : String(format: "%g %@", value, unit)
    }
    
}



struct IMarkerConfig {
    var label: String
    var selectedLabelFont: UIFont
    var bottomValueToCircle: CGFloat
    var selectedValueRoundColor: UIColor
}
class HyperMarker: IMarker {
    var selectedEntry: ChartDataEntry?
    var config: IMarkerConfig
    
    init(config: IMarkerConfig) {
        self.config = config
    }
    
    
    var offset: CGPoint = .zero
    
    func offsetForDrawing(atPoint: CGPoint) -> CGPoint {
        return .zero
    }
    
    func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        
    }
    
    func draw(context: CGContext, point: CGPoint) {
        //Need to be draw arrow later on and config base on Device dimension
        let selectedStringWidth = config.label.widthOfString(usingFont: UIFont.boldSystemFont(ofSize: 13))
        let spacing: CGFloat = 10
        let x: CGFloat  = point.x - selectedStringWidth/2 - spacing
        let y: CGFloat = point.y - config.selectedLabelFont.lineHeight - config.bottomValueToCircle - spacing/4
        let roundWidth: CGFloat = selectedStringWidth + spacing*2
        let roundHeight: CGFloat = config.selectedLabelFont.lineHeight + spacing/2
        let rectFrame = CGRect(x: x, y: y, width: roundWidth, height: roundHeight)
        
        //Dash line
//        let lineDashPath = UIBezierPath()
//        lineDashPath.move(to:  CGPoint(x: x, y: point.y+20))
//        lineDashPath.addLine(to: CGPoint(x: x + roundWidth, y: point.y+20))
//        context.addPath(lineDashPath.cgPath)
//        context.setLineWidth(1)
//        context.setStrokeColor(config.selectedValueRoundColor.cgColor)
//        context.setLineDash(phase: 0, lengths: [2,3])
//        context.strokePath()
        
        //Round
        context.setShadow(offset: CGSize(width: 1, height: 0.5), blur: 1,color:#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor)
        let roundPath = UIBezierPath(roundedRect: rectFrame, cornerRadius: roundHeight/2).cgPath
        context.addPath(roundPath)
        context.setLineWidth(0.5)
        context.setStrokeColor(config.selectedValueRoundColor.cgColor)
        
        //Rectangle
        let rectangleRect = CGRect(x: x+roundWidth/3, y: y+roundHeight, width: roundWidth/3, height: roundHeight/4)
        let rectanglePath = createRectanglePath(roundRect: rectangleRect).cgPath
        context.addPath(rectanglePath)
        context.setLineWidth(0.5)
        context.setStrokeColor(config.selectedValueRoundColor.cgColor)
        context.strokePath()
        
        //Clear round color
        let path = UIBezierPath()
        path.move(to:  CGPoint(x: rectangleRect.maxX-1, y: rectangleRect.minY))
        path.addLine(to: CGPoint(x: rectangleRect.minX+1, y: rectangleRect.minY))
        context.addPath(path.cgPath)
        context.setLineWidth(1)
        context.setShadow(offset: CGSize(width: 1, height: 1), blur: 1,color: UIColor.white.cgColor)
        context.setStrokeColor(UIColor.white.cgColor)
        context.strokePath()
        
        context.closePath()

    }
    
    
    
    func createRectanglePath(roundRect: CGRect) -> UIBezierPath{
        let trianglePath = UIBezierPath()
        trianglePath.move(to: CGPoint(x: roundRect.minX, y: roundRect.minY))
        trianglePath.addLine(to: CGPoint(x: roundRect.midX, y: roundRect.maxY))
        trianglePath.addLine(to: CGPoint(x: roundRect.maxX, y: roundRect.minY))
    
        trianglePath.close()
        return trianglePath
    }
}
