//
//  ReportCardView.swift
//  Hyperloung
//
//  Created by Thai Nguyen on 10/26/21.
//

import Foundation
import UIKit

struct ReportSummary {
    var title: String
    var value: String
    var unit: String
    var image: UIImage?
    var description: String
    var subDescription: String
    
    static var `default`: [ReportSummary] {
        [
            ReportSummary(title: "오늘 매출 실적이 좋아요.", value: "131.2", unit: "억원", image: UIImage(named: "ic_smile"), description: "월계획 달성", subDescription: "14%"),
            ReportSummary(title: "오늘의 자금", value: "142", unit: "억원", image: nil, description: "입출금", subDescription: "-11억"),
            ReportSummary(title: "월 경비 소진", value: "25.7", unit: "%", image: nil, description: "누적금액", subDescription: "17억"),
            ReportSummary(title: "월 예상이익", value: "15.7", unit: "%", image: nil, description: "누적이익", subDescription: "15.4억"),
            ReportSummary(title: "오늘의 생산", value: "37", unit: "만톤", image: nil, description: "계획달성", subDescription: "82%")
        ]
    }
}

class ReportCardView: UIView {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleButton: UIButton!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var subDescriptionLabel: UILabel!
    
    func bindingUI(data: ReportSummary) {
        titleButton.setTitle(data.title, for: .normal)
        valueLabel.text = data.value
        unitLabel.text = data.unit
        descriptionLabel.text = data.description
        subDescriptionLabel.text = data.subDescription
        iconImageView.image = data.image
    }
    
}
