//
//  ItemTableViewCell.swift
//  DaangnMarket
//
//  Created by 김수연 on 2021/11/18.
//

import UIKit

import SnapKit
import Then
import Kingfisher

class ItemTableViewCell: UITableViewCell {
    private let itemImageView = UIImageView().then {
        $0.image = Image.photoIcon
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
        $0.contentMode = .scaleToFill

    }

    private let hStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.alignment = .leading
        $0.distribution = .fill
    }

    private let itemTitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .regular)
    }

    private let itemDescriptionLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textColor = Color.daangnGray3
    }

    private let itemPriceLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .medium)
    }

    private let likeIconImageView = UIImageView().then {
        $0.image = Image.likeIcon
        $0.clipsToBounds = true
    }

    private let likeNumberLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textColor = Color.daangnGray4
    }

    private let statusButton = TagButton().then {
        $0.titleLabel?.font = .systemFont(ofSize: 10, weight: .bold)
        $0.layer.cornerRadius = 10
        $0.setText(with: "중고", state: .selected)
    }

    private let dealButton = TagButton().then {
        $0.titleLabel?.font = .systemFont(ofSize: 10, weight: .bold)
        $0.layer.cornerRadius = 10
        $0.setText(with: "택배", state: .normal)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        itemImageView.image = nil
        itemTitleLabel.text = ""
    }

    func updateData(data: HomeItemData) {
        let url = URL(string: data.img)
        itemImageView.kf.setImage(with: url)

        itemTitleLabel.text = data.title
        itemDescriptionLabel.text = "\(data.address) · 3일전"
        itemPriceLabel.text = "\(data.price)원"
        likeNumberLabel.text = "7"
    }
}

extension ItemTableViewCell {

}

extension ItemTableViewCell {
    private func setLayouts() {
        setViewHierarchies()
        setConstraints()
    }

    private func setViewHierarchies() {
        contentView.addSubviews(itemImageView, hStackView, itemTitleLabel, itemDescriptionLabel, itemPriceLabel, likeIconImageView, likeNumberLabel)
        hStackView.addArrangedSubview(statusButton)
        hStackView.addArrangedSubview(dealButton)
    }

    private func setConstraints() {
        itemImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(17)
            $0.width.height.equalTo(90)
        }

        hStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(21)
            $0.leading.equalTo(itemImageView.snp.trailing).offset(15)
            $0.height.equalTo(19)
        }

        statusButton.snp.makeConstraints {
            $0.height.equalTo(20)
        }
        dealButton.snp.makeConstraints {
            $0.height.equalTo(20)
        }

        itemTitleLabel.snp.makeConstraints {
            $0.top.equalTo(hStackView.snp.bottom).offset(3)
            $0.leading.equalTo(itemImageView.snp.trailing).offset(15)
        }

        itemDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(itemTitleLabel.snp.bottom).offset(0)
            $0.leading.equalTo(itemImageView.snp.trailing).offset(15)
        }

        itemPriceLabel.snp.makeConstraints {
            $0.top.equalTo(itemDescriptionLabel.snp.bottom).offset(9)
            $0.leading.equalTo(itemImageView.snp.trailing).offset(15)
            $0.bottom.equalToSuperview().inset(23)
        }

        likeIconImageView.snp.makeConstraints {
            $0.width.equalTo(likeIconImageView.snp.height).multipliedBy(1.0 / 1.0)
            $0.trailing.equalTo(likeNumberLabel.snp.leading).offset(-3)
            $0.bottom.equalToSuperview().inset(20)
        }

        likeNumberLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(30)
            $0.bottom.equalToSuperview().inset(18)
        }
    }
}
