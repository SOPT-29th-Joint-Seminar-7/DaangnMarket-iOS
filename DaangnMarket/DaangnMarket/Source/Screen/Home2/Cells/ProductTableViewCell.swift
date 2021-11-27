//
//  ProductTableViewCell.swift
//  DaangnMarket
//
//  Created by 조양원 on 2021/11/25.
//

/*
 
 궁금한 것
 - final 키워드: 더 이상 하위클래스에 상속시키고 싶지 않다면 final 처리를 해준다
 
 */

import UIKit

import SnapKit
import Then

class ProductTableViewCell: UITableViewCell {
    private let productImageView = UIImageView().then {
        $0.image = Image.photoIcon
        $0.contentMode = .scaleAspectFit
    }

    private let statusStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.alignment = .leading
        $0.distribution = .fill
    }

    private let productStatusButton = TagButton().then {
        $0.titleLabel?.font = .systemFont(ofSize: 10, weight: .bold)
        $0.layer.cornerRadius = 10
        $0.setText(with: "중고", state: .selected)
    }

    private let tradeStatusButton = TagButton().then {
        $0.titleLabel?.font = .systemFont(ofSize: 10, weight: .bold)
        $0.layer.cornerRadius = 10
        $0.setText(with: "택배", state: .normal)
    }

    private let productTitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .regular)
    }

    private let productSubTatleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textColor = Color.daangnGray3
    }

    private let productPriceLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .medium)
    }

    private let likeIconImageView = UIImageView().then {
        $0.image = Image.likeIcon
        $0.clipsToBounds = true
    }

    private let likeCountLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textColor = Color.daangnGray4
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateData(data: Item) {
        productImageView.image = UIImage(named: data.itemImageName)
        productTitleLabel.text = data.itemTitle
        productSubTatleLabel.text = "\(data.location) · \(data.uploadDate) 전"
        productPriceLabel.text = "\(data.itemPrice)원"
        if data.likeNumber == 0 {
            likeIconImageView.isHidden = true
            likeCountLabel.isHidden = true
        } else {
            likeCountLabel.text = "\(data.likeNumber)"
        }
    }
}

extension ProductTableViewCell {
    private func setLayouts() {
        setSelectionStyle()
        setViewHierarchies()
        setConstraints()
    }

    private func setSelectionStyle() {
        self.selectionStyle = .none // 지금 상태에서는 클릭 막기
    }

    private func setViewHierarchies() {
        contentView.addSubviews(productImageView, statusStackView, productTitleLabel, productSubTatleLabel, productPriceLabel, likeIconImageView, likeCountLabel)
        statusStackView.addArrangedSubview(productStatusButton)
        statusStackView.addArrangedSubview(tradeStatusButton)
    }

    private func setConstraints() {
        productImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(22)
            $0.leading.equalToSuperview().inset(17)
            $0.width.height.equalTo(90)
        }

        statusStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(22)
            $0.leading.equalTo(productImageView.snp.trailing).offset(10)
            $0.height.equalTo(19)
        }

        productStatusButton.snp.makeConstraints {
            $0.height.equalTo(19)
        }
        tradeStatusButton.snp.makeConstraints {
            $0.height.equalTo(19)
        }

        productTitleLabel.snp.makeConstraints {
            $0.top.equalTo(statusStackView.snp.bottom).offset(3)
            $0.leading.equalTo(statusStackView.snp.leading)
        }

        productSubTatleLabel.snp.makeConstraints {
            $0.top.equalTo(productTitleLabel.snp.bottom).offset(0)
            $0.leading.equalTo(statusStackView.snp.leading)
            $0.leading.equalTo(productImageView.snp.trailing).offset(10)
        }

        productPriceLabel.snp.makeConstraints {
            $0.top.equalTo(productSubTatleLabel.snp.bottom).offset(9)
            $0.leading.equalTo(statusStackView.snp.leading)
            $0.bottom.equalToSuperview().inset(23)
        }

        likeIconImageView.snp.makeConstraints {
            $0.width.equalTo(likeIconImageView.snp.height).multipliedBy(1.0 / 1.0)
            $0.trailing.equalTo(likeCountLabel.snp.leading).offset(-3)
            $0.bottom.equalToSuperview().inset(20)
        }

        likeCountLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(30)
            $0.bottom.equalToSuperview().inset(18)
        }
    }
}
