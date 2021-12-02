//
//  Home1ViewController.swift
//  DaangnMarket
//
//  Created by 김윤서 on 2021/11/13.
//

import UIKit

import SnapKit
import Then
import Moya

class Home1ViewController: UIViewController {

    private let service = MoyaProvider<HomeService>()
    var itemData: HomeItem?
    private var itemList: [HomeItemData] = []

    private lazy var tableView = UITableView().then {
        $0.registerReusableCell(ItemTableViewCell.self)
        $0.separatorColor = Color.daangnGray1
        $0.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        /// iOS 15 부터 적용 : sectionHeaderTopPadding을 0으로 주면 구분선이 사라지고 1로 주면 생김.
        if #available(iOS 15, *) {
            $0.sectionHeaderTopPadding = 0
        }
    }

    private let headerView = UIView().then {
        $0.backgroundColor = .white
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
    
    private let plusButton = UIButton().then {
        $0.setImage(Image.createButtonImage, for: .normal)
        $0.addTarget(self, action: #selector(buttonDidTapped(_:)), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayouts()
        setDelegation()
        getItemData()
    }

    // Network
    func getItemData() {
        service.request(.getItemData) { [weak self] response in
            switch response {
            case .success(let result):
                do {
                    self?.itemData = try result.map(HomeItem.self)
                    self?.itemList = self?.itemData?.data ?? []
                    print("itemList", self?.itemList ?? [])
                    self?.tableView.reloadData()
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }

}

extension Home1ViewController {
    private func setDelegation() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension Home1ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 셀 선택시 회색으로 바뀌는 효과 해제 
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension Home1ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath: indexPath) as ItemTableViewCell
        cell.updateData(data: itemList[indexPath.row])
        return cell
    }
}

extension Home1ViewController {
    @objc
    private func buttonDidTapped(_ sender: UIButton) {
        let writingVC = WritingViewController()
        navigationController?.pushViewController(writingVC, animated: true)
    }
}

extension Home1ViewController {
    func setLayouts() {
        setViewHierarchies()
        setConstraints()
    }

    func setViewHierarchies() {
        view.addSubviews(tableView, plusButton)
        headerView.addSubviews(sortButton, filterButton)
    }

    func setConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        filterButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(50)
            $0.height.equalTo(20)
            $0.centerY.equalTo(headerView.snp.centerY)
        }
        sortButton.snp.makeConstraints {
            $0.trailing.equalTo(filterButton.snp.leading).offset(-6)
            $0.width.equalTo(60)
            $0.height.equalTo(20)
            $0.centerY.equalTo(headerView.snp.centerY)
        }

        plusButton.snp.makeConstraints {
            $0.width.equalTo(plusButton.snp.height)
            $0.trailing.equalToSuperview().inset(21)
            $0.bottom.equalToSuperview().inset(103)
        }

    }
}
