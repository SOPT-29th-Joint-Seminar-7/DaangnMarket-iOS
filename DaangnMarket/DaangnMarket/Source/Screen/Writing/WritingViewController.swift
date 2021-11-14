//
//  WritingViewController.swift
//  DaangnMarket
//
//  Created by 김윤서 on 2021/11/13.
//

import UIKit

import SnapKit
import Then

final class WritingViewController: UIViewController {

    private lazy var closeButton = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.contentMode = .scaleToFill
        $0.imageEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
    }

    private lazy var doneButton = UIButton().then {
        $0.setTitle("완료", for: .normal)
        $0.setTitleColor(Color.daangnOrange, for: .normal)
        $0.setTitleColor(Color.daangnGray3, for: .disabled)
        $0.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
    }

    private let tableView = UITableView().then {
        $0.allowsSelection = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setDelegation()
        setLayouts()
    }
}

extension WritingViewController {
    private func setDelegation() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func setNavigationBar() {
        title = "중고거래 글쓰기"
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 19, weight: .regular)]
        navigationItem.leftBarButtonItem = makeBarButtonItem(with: closeButton)
        navigationItem.rightBarButtonItem = makeBarButtonItem(with: doneButton)
    }

    private func makeBarButtonItem(with button: UIButton) -> UIBarButtonItem {
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        button.addTarget(self, action: #selector(buttonDidTapped(_:)), for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }
}

extension WritingViewController {
    @objc
    private func buttonDidTapped(_ sender: UIButton) {
        switch sender {
        case closeButton:
            dismiss(animated: true, completion: nil)
        case doneButton:
            //TODO:- 통신 구현시 disabled 구현
            dismiss(animated: true, completion: nil)
        default:
            break
        }
    }
}

extension WritingViewController: UITableViewDelegate {

}

extension WritingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}

extension WritingViewController {
    func setLayouts() {
        setViewHierarchies()
        setConstraints()
    }

    func setViewHierarchies() {
        view.addSubview(tableView)
    }

    func setConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
