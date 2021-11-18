//
//  ItemTableViewCell.swift
//  DaangnMarket
//
//  Created by 김수연 on 2021/11/18.
//

import UIKit

import SnapKit
import Then

class ItemTableViewCell: UITableViewCell {
    
    private let itemImageView = UIImageView().then {
        $0.image = Image.photoIcon
        $0.contentMode = .scaleAspectFit
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayouts()
        makeHomeTagButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateData(data:Item) {
        itemImageView.image = UIImage(named:data.itemImage)
        itemTitleLabel.text = data.itemTitle
        itemDescriptionLabel.text = "\(data.location) · \(data.uploadDate) 전"
        itemPriceLabel.text = "\(data.itemPrice)원"
    }
}

extension ItemTableViewCell {
    public func makeHomeTagButton() {
        let statusButton = TagButton()
        statusButton.setText(with: "중고", state: .selected)
        
        let dealButton = TagButton()
        dealButton.setText(with: "택배", state: .normal)
        
        statusButton.titleLabel?.font = .systemFont(ofSize: 10, weight: .bold)
        statusButton.layer.cornerRadius = 10
        dealButton.titleLabel?.font = .systemFont(ofSize: 10, weight: .bold)
        dealButton.layer.cornerRadius = 10
        
        statusButton.snp.makeConstraints {
            $0.height.equalTo(20)
        }
        dealButton.snp.makeConstraints {
            $0.height.equalTo(20)
        }
        hStackView.addArrangedSubview(statusButton)
        hStackView.addArrangedSubview(dealButton)
    }
}
    
extension ItemTableViewCell {
    private func setLayouts() {
        setViewHierarchies()
        setConstraints()
    }
    
    private func setViewHierarchies() {
        contentView.addSubviews(itemImageView, hStackView, itemTitleLabel, itemDescriptionLabel, itemPriceLabel)
    }
    
    private func setConstraints() {
        itemImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(17)
            $0.width.height.equalTo(90)
            
        }
        
        hStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(21)
            $0.leading.equalTo(itemImageView.snp.trailing).offset(10)
            $0.height.equalTo(19)
        }
        
        itemTitleLabel.snp.makeConstraints {
            $0.top.equalTo(hStackView.snp.bottom).offset(3)
            $0.leading.equalTo(itemImageView.snp.trailing).offset(10)
        }
        
        itemDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(itemTitleLabel.snp.bottom).offset(0)
            $0.leading.equalTo(itemImageView.snp.trailing).offset(10)
        }
        
        itemPriceLabel.snp.makeConstraints {
            $0.top.equalTo(itemDescriptionLabel.snp.bottom).offset(9)
            $0.leading.equalTo(itemImageView.snp.trailing).offset(10)
            $0.bottom.equalToSuperview().inset(23)
        }
    }
}
