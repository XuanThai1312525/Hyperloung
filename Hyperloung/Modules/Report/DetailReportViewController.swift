//
//  DetailReportViewController.swift
//  Hyperloung
//
//  Created by Thai Nguyen on 10/26/21.
//

import UIKit
protocol ReportViewControllerDelegate: AnyObject {
    func shouldExpandView(ofsset: CGFloat)
}

struct DetailReport {
    var title: String
    var isRead: Bool
    var category: String
    var content: String
    var date: String
    
    static var `default`: [DetailReport] {
        return [
            DetailReport(title: "전사 예상 매출", isRead: false, category: "매출", content: "전사 월예상 매출의 사업계획 미달 감지", date: "2021.06.05"),
            DetailReport(title: "본부별 예상 매출", isRead: true, category: "매출", content: "월예상 매출의 사업계획 미달 본부 감지", date: "2021.06.05"),
            DetailReport(title: "본부별 예상 매출", isRead: true, category: "매출", content: "월예상 매출의 사업계획 미달 본부 감지", date: "2021.06.05"),
            DetailReport(title: "제품군별 매출", isRead: true, category: "매출", content: "수주 하락 추세의 제품군 감지", date: "2021.06.05"),
            DetailReport(title: "오라클 고객군별 매출", isRead: true, category: "매출", content: "수주 하락 추세의 오라클 고객군 감지", date: "2021.06.05"),
            DetailReport(title: "법인카드 사용액", isRead: false, category: "비용", content: "금주 법인카드 사용액 지출 과도 감지", date: "2021.06.05"),
            DetailReport(title: "본부별 경비 사용액", isRead: true, category: "비용", content: "예산 대비 경비 사용 과도 본부 감지", date: "2021.06.05"),
            DetailReport(title: "본부별 인건비", isRead: true, category: "비용", content: "계획 대비 인건비 지출 과도 본부 감지", date: "2021.06.05"),
        ]
    }
}

class ReportBaseViewController: BaseViewController {
    weak var delegate: ReportViewControllerDelegate?
}
extension ReportBaseViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.shouldExpandView(ofsset: scrollView.contentOffset.y)
    }
}

class DetailReportViewController: ReportBaseViewController {
 
    private var data: [DetailReport] = DetailReport.default
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension DetailReportViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailReportTableViewCell.identifier, for: indexPath) as! DetailReportTableViewCell
        cell.bindingUI(data: data[indexPath.row])
        return cell
    }
}
