//
//  TagTableViewCell.swift
//  DaangnMarket
//
//  Created by 김윤서 on 2021/11/15.
//

import UIKit

enum TagTableViewCellType {
    case title
    case titleWithSubtitle

    func getText() -> String {
        switch self {
        case .title:
            return "상품 상태"
        case .titleWithSubtitle:
            return "거래 방식"
        }
    }
}

final class TagTableViewCell: UITableViewCell {

    public var type: TagTableViewCellType = .title {
        didSet {
            titleLabel.text = type.getText()
            setLayouts()
        }
    }

    private let hStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 5
        $0.alignment = .leading
        $0.distribution = .fill
    }

    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15, weight: .semibold)
    }

    private let subtitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.textColor = Color.daangnGray5
        $0.text = "(중복 선택 가능)"
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TagTableViewCell {
    public func makeTagButtons(with words: String...) {
        for (index, word) in words.enumerated() {
            let tagButton = TagButton()
            if index == 0 {
                tagButton.setText(with: word, state: .selected)
            } else {
                tagButton.setText(with: word, state: .normal)
            }
            tagButton.snp.makeConstraints {
                $0.height.equalTo(25)
            }
            hStackView.addArrangedSubview(tagButton)
        }
    }
}

extension TagTableViewCell {
    private func setLayouts() {
        setViewHierarchies()
        setConstraints()
    }

    private func setViewHierarchies() {
        switch type {
        case .title:
            contentView.addSubviews(titleLabel, hStackView)
        case .titleWithSubtitle:
            contentView.addSubviews(titleLabel, subtitleLabel, hStackView)
        }
    }

    private func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().offset(20)
        }

        switch type {
        case .title:
            break
        case .titleWithSubtitle:
            subtitleLabel.snp.makeConstraints {
                $0.leading.equalTo(titleLabel.snp.trailing).inset(-6)
                $0.centerY.equalTo(titleLabel.snp.centerY)
            }
        }

        hStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().offset(-21)
            $0.height.equalTo(25)
        }
    }
}
