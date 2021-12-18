//
//  Home2ViewController.swift
//  DaangnMarket
//
//  Created by 김윤서 on 2021/11/13.
//

import UIKit

import Kingfisher
import Moya
import SnapKit
import Then

class Home2ViewController: UIViewController {

    // UI 요소 먼저 정의
    // private lazy var tableView = UITableView(frame: .zero, style: .grouped).then {
    private lazy var tableView = UITableView().then {
        $0.registerReusableCell(ProductTableViewCell.self)
        $0.separatorColor = Color.daangnGray1
        $0.separatorInset = UIEdgeInsets(top: 0, left: 17, bottom: 0, right: 30)
        if #available(iOS 15, *) {
            $0.sectionHeaderTopPadding = 0
        }
    }

    private let tableViewHeader = UITableViewHeaderFooterView().then {
        $0.backgroundView = UIImageView()
        $0.backgroundView?.backgroundColor = Color.daangnWhite
    }

    private let sortButton = UIButton(type: .custom).then {
        $0.titleLabel?.font = .systemFont(ofSize: 12)
        $0.setTitle("추천순", for: .normal)
        $0.setTitleColor(Color.daangnGray3, for: .normal)
        $0.setImage(Image.sortIcon, for: .normal)
        let spacing: CGFloat = 4
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -spacing, bottom: 0, right: spacing)
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: -spacing)
        $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
    }

    private let filterButton = UIButton().then {
        $0.titleLabel?.font = .systemFont(ofSize: 12)
        $0.setTitle("가격", for: .normal)
        $0.setTitleColor(Color.daangnGray3, for: .normal)
        $0.setImage(Image.filterIcon, for: .normal)
        let spacing: CGFloat = 4
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -spacing, bottom: 0, right: spacing)
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: -spacing)
        $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
    }

    private let floatingButton = UIButton().then {
        $0.setImage(Image.createButtonImage, for: .normal)
        $0.addTarget(self, action: #selector(floatingButtonAction(_:)), for: .touchUpInside)
    }

    private var itemList: [Item] = []

    let provider = MoyaProvider<PostInquiryService>()

    override func viewDidLoad() {
        super.viewDidLoad()
        notificationCenterReload()
        productInquiry()
        setLayouts()
        updateData()
        setDelegation()
        tableView.reloadData()
    }
}

// MARK: Set 함수
extension Home2ViewController {
    private func setDelegation() {
            tableView.delegate = self
            tableView.dataSource = self
    }

    private func updateData() {
        let itemList = ItemListModel()
        self.itemList = itemList.getItemListModel()
    }

    func notificationCenterReload() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(notificationAction),
                                               name: NSNotification.Name("reload"),
                                               object: nil)
    }

    @objc func notificationAction(_ notification: Notification) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension Home2ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableViewHeader
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 셀을 눌렀을 때 화면전환 연결하기
        // 현재는 cell에서 클릭을 막아둔 상태
    }
}

extension Home2ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch GlobalValue.shared.productListData?.data.count {
        case nil:
            return 0
        default:
            return GlobalValue.shared.productListData!.data.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath: indexPath) as ProductTableViewCell

        switch GlobalValue.shared.productListData {
        case nil:
            return UITableViewCell()
        default:
            let url = URL(string: "\(GlobalValue.shared.productListData!.data[indexPath.row].img)")
            cell.productImageView.kf.setImage(with: url)
            cell.productTitleLabel.text = GlobalValue.shared.productListData?.data[indexPath.row].title
            cell.productSubTatleLabel.text = "\(GlobalValue.shared.productListData!.data[indexPath.row].address) · \(indexPath.row)분 전"

            // 제품 가격
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let priceResult = numberFormatter.string(from: NSNumber(value: GlobalValue.shared.productListData!.data[indexPath.row].price))
            cell.productPriceLabel.text = "\(priceResult!)원"

            cell.likeIconImageView.image = Image.likeIcon
            if indexPath.row == 0 {
                cell.likeIconImageView.isHidden = true
                cell.likeCountLabel.isHidden = true
            } else {
                cell.likeCountLabel.text = "\(indexPath.row)"
            }
            cell.separatorInset = UIEdgeInsets(top: 0, left: 17, bottom: 0, right: 30)
            return cell
        }
    }
}

extension Home2ViewController {
    @objc private func floatingButtonAction(_ sender: UIButton) {
        let nextVC = WritingViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension Home2ViewController {
    func setLayouts() {
        setViewHierarchies()
        setConstraints()
    }

    func setViewHierarchies() {
        view.addSubviews(tableView, floatingButton)
        tableViewHeader.addSubviews(sortButton, filterButton)
    }

    func setConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        sortButton.snp.makeConstraints {
            $0.trailing.equalTo(filterButton.snp.leading).offset(-6)
            $0.width.equalTo(60)
            $0.height.equalTo(17)
            $0.centerY.equalTo(tableViewHeader.snp.centerY)
        }

        filterButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(50)
            $0.height.equalTo(17)
            $0.centerY.equalTo(tableViewHeader.snp.centerY)
        }

        floatingButton.snp.makeConstraints {
            $0.width.equalTo(floatingButton.snp.height)
            $0.trailing.equalToSuperview().inset(21)
            $0.bottom.equalToSuperview().inset(103)
        }
    }
}

// MARK: Network
extension Home2ViewController {

           // signUp 함수
       func productInquiry() {
           provider.request(.postInquiry) { response in
               switch response {
               case .success(let result):
                   do {
                       GlobalValue.shared.productListData = try result.map(PostInquiryDataModel.self)
                       NotificationCenter.default.post(name: NSNotification.Name("reload"),
                                                       object: nil)
                   } catch(let err) {
                       print("---> catch 실패 \(err.localizedDescription)")
                   }
               case .failure(let err):
                   print("---> 실패 \(err.localizedDescription)")
               }
           }
       }
}

extension String { func toDate() -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    dateFormatter.timeZone = TimeZone(identifier: "UTC")
    if let date = dateFormatter.date(from: self) {return date} else { return nil }
}
}

extension Date { func toString() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    dateFormatter.timeZone = TimeZone(identifier: "UTC")
    return dateFormatter .string(from: self)}
}
