//
//  DemoViewController.swift
//  Hyperloung
//
//  Created by Thai Nguyen on 11/9/21.
//

import UIKit
enum ChartType {
    case dataType(Int), messageTypeB(Int)
}
class DemoViewController: UIViewController {
   var containerView: UIView!
    var chartType: ChartType!
    var chartTitle: String = "Demo"
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        titleLabel.text = chartTitle
        
        containerView = UIView()
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        showView()
    }
    
    private func showView() {
        switch chartType {
        case let.dataType(number):
            showDataType(number: number)
        case let .messageTypeB(number):
            showMessageTypeB(number: number)
            
        case .none:
            break
        }
    }
    
    private func showDataType(number: Int) {
        switch number {
        case 0:
            let bar_01: aos_d_bar_01 = .fromNib()
            containerView.addSubview(bar_01)
            bar_01.setHeight(292).setWidth(view.frame.width)
        case 1:
            let bar_01: aos_d_bar_02 = .fromNib()
            containerView.addSubview(bar_01)
            bar_01.setHeight(292).setWidth(view.frame.width)
        case 2:
            let bar_01: aos_d_bar_03 = .fromNib()
            containerView.addSubview(bar_01)
            bar_01.setHeight(292).setWidth(view.frame.width)
        case 3:
            let bar_01: aos_d_bar_04 = .fromNib()
            containerView.addSubview(bar_01)
            bar_01.setHeight(292).setWidth(view.frame.width)
        case 4:
            let bar_01: aos_d_bar_05 = aos_d_bar_05(frame: CGRect(x: 0, y: 10, width: view.frame.width, height: 200))
            containerView.addSubview(bar_01)
            bar_01.setHeight(200).setWidth(view.frame.width)
        case 5:
            let bar_01: aos_d_bar_06 = .fromNib()
            containerView.addSubview(bar_01)
            bar_01.setHeight(292).setWidth(view.frame.width)
        case 6:
            let bar_01: aos_d_bar_07 = .fromNib()
            containerView.addSubview(bar_01)
            bar_01.setHeight(292).setWidth(view.frame.width)
            
        case 7:
            let bar_01: aos_d_bar_08 = aos_d_bar_08(frame: CGRect(x: 0, y: 10, width: view.frame.width, height: 200))
            containerView.addSubview(bar_01)
            bar_01.setHeight(200).setWidth(view.frame.width)
            
        case 8:
            let pie01: aos_mb_pie_02 = .fromNib()
            containerView.addSubview(pie01)
            pie01.setHeight(200).setWidth(view.frame.width)
            
        case 9:
            let pie02: aos_mb_pie_01 = .fromNib()
            containerView.addSubview(pie02)
            pie02.setHeight(200).setWidth(view.frame.width)
        case 10:
            let pie02: aos_d_line_01 = aos_d_line_01(frame:CGRect(x: 0, y: 10, width: view.frame.width, height: 200))
            containerView.addSubview(pie02)
            
        case 11:
            let pie02: aos_d_line_02 = aos_d_line_02(frame:CGRect(x: 0, y: 10, width: view.frame.width, height: 200))
            containerView.addSubview(pie02)
            
        default:
            break
        }
    }
    
    private func showMessageTypeB(number: Int) {
        switch number {
        case 0:
            let mb_bar_01: aos_mb_bar_01_ = .fromNib()
            containerView.addSubview(mb_bar_01)
            mb_bar_01.setHeight(292)
        case 1:
            let mb_bar_02: aos_mb_bar_02_ = .fromNib()
            containerView.addSubview(mb_bar_02)
            mb_bar_02.setHeight(292)
        case 2:
            let mb_bar_03: aos_mb_bar_03_ = .fromNib()
            containerView.addSubview(mb_bar_03)
            mb_bar_03.setHeight(292)
        case 3:
            let mb_bar_04: aos_mb_bar_04_ = .fromNib()
            containerView.addSubview(mb_bar_04)
            mb_bar_04.setHeight(292)
        case 4:
            let aos_mb_bar_05: aos_mb_bar_05 = .fromNib()
            containerView.addSubview(aos_mb_bar_05)
            aos_mb_bar_05.setHeight(292)
        case 5:
            let aos_mb_bar_06: aos_mb_bar_06 = .fromNib()
            containerView.addSubview(aos_mb_bar_06)
            aos_mb_bar_06.setHeight(292)
        case 6:
            let horizontalLineView: HyperHorizontalLineChartView = .fromNib()
            containerView.addSubview(horizontalLineView)
            horizontalLineView.setHeight(120).setWidth(view.frame.width)
            
        case 7:
            let hyperCircleChartView = HyperCircleChartView(frame: CGRect(x: 0, y: 10, width: 200, height: 200))
            containerView.addSubview(hyperCircleChartView)
            hyperCircleChartView.datasource = self
            hyperCircleChartView.drawChart()
            
        case 8:
            let circle: aos_mb_pie_03 = .fromNib()
            containerView.addSubview(circle)
            circle.setWidth(view.frame.size.width).setHeight(200)
        case 9:
            let line = aos_ma_line_01(frame: CGRect(x: 0, y: 10, width: view.frame.width, height: 250))
            containerView.addSubview(line)
        case 10:
            let line = aos_ma_line_02(frame: CGRect(x: 0, y: 10, width: view.frame.width, height: 250))
            containerView.addSubview(line)
        case 11:
            let line = aos_ma_line_03(frame: CGRect(x: 0, y: 10, width: view.frame.width, height: 200))
            containerView.addSubview(line)
        case 12:
            let line = aos_ma_line_03_negative(frame: CGRect(x: 0, y: 10, width: view.frame.width, height: 200))
            containerView.addSubview(line)
        case 13:
            let line = aos_ma_line_04(frame: CGRect(x: 0, y: 10, width: view.frame.width, height: 250))
            containerView.addSubview(line)
        case 14:
            let line = aos_ma_line_04_negative(frame: CGRect(x: 0, y: 10, width: view.frame.width, height: 250))
            containerView.addSubview(line)
        default:
            break
        }
        
    }
}

extension DemoViewController: HyperCircleDataSource {
    var dataSet: [HyperCircleData] {
        [HyperCircleData(value: 68, color: #colorLiteral(red: 0.1411764706, green: 0.4352941176, blue: 0.9333333333, alpha: 1)),
         HyperCircleData(value: 32, color: #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1))]
    }
    
    func description(of data: HyperCircleData) -> String {
        ""
    }
    
    var lineWidth: CGFloat {
        return 10
    }
    
    var tooltip: NSAttributedString? {
        nil
    }
    
    var centerTextAppearnce: HyperCircleCenterTextAppearance? {
        return  HyperCircleCenterTextAppearance(prefix: "68%", suffix: "", prefixColor: #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), suffixColor: #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), prefixFont: FontFamily.customFont.displayFontWithSize(24, attributeType: .bold), suffixFont: FontFamily.customFont.displayFontWithSize(16, attributeType: .light))
    }
    
    
}
