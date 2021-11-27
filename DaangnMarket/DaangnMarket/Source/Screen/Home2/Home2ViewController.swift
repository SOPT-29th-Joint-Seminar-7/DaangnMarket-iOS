//
//  Home2ViewController.swift
//  DaangnMarket
//
//  Created by 김윤서 on 2021/11/13.
//

/*
 구현할 기능 리스트
 1. [o] 테이블뷰
 2. [o] 테이블뷰 헤더
 3. [o] 글쓰기 플로팅 버튼
 
 할 일 순서
 1. [o] UI 요소 만들기
 2. [o] 버튼마다 액션 정의
 3. [o] cell 구성하기
 4. [o] header로 구성하기
 5. [o] 하트 0개일 때는 숨기기
 
 고려사항
 - [o] 중고 버튼은 스택뷰로 구현
 - [o] 하트 0개일 때는 숨기기
 - [x] 0번째 셀 구분선 삭제
 - task 브랜치는 총 4개 만들기 예시) task/#18-ItemTableView
 - task 하나 완성할 때마다 draft PR 날려서 리뷰 받기
 - 테이블뷰셀
 init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
     super.init(style: style, reuseIdentifier: reuseIdentifier) } required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
 5. UI 뷰
 View Life Cycle override init(frame: CGRect) { super.init(frame: frame) } required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
 
 궁금증
 - 레이아웃을 잡을 때 이미지로부터 똑같은 간격을 띄울 경우 나는 타이틀, 서브타이틀, 가격 3개 다 이미지로부터 거리로 잡았는데 수연이는 각각 값을 10씩 줬더라 실제 구현하다보면 뭐가 더 편한가
 - 1번째 cell의 상단 구분선만 삭제하기... 너무 어렵다

해결
 - lazy: 메모리를 아끼기 위햐 쓴다. UI 요소를 설정할 떄 lazy로 하면 되는 것 같음
 */

import UIKit

import SnapKit
import Then

class Home2ViewController: UIViewController {

    // UI 요소 먼저 정의
    private lazy var tableView = UITableView(frame: .zero, style: .grouped).then {
        $0.registerReusableCell(ProductTableViewCell.self)
        $0.separatorColor = Color.daangnGray1
        $0.separatorInset = UIEdgeInsets(top: 0, left: 17, bottom: 0, right: 30)
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

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayouts()
        setDelegation()
        updateData()
    }
}

extension Home2ViewController {
    private func setDelegation() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func updateData() {
        let itemList = ItemListModel()
        self.itemList = itemList.getItemListModel()
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
        return itemList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath: indexPath) as ProductTableViewCell
        cell.updateData(data: itemList[indexPath.row])
        // 안 되네
        switch indexPath.row {
        case 0:
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            return cell
        case 1, 2:
            cell.separatorInset = UIEdgeInsets(top: 0, left: 17, bottom: 0, right: 30)
            return cell
        default:
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
