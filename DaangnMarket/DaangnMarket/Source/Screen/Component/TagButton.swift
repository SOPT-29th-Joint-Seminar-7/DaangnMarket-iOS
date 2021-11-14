//
//  TagButton.swift
//  DaangnMarket
//
//  Created by 김윤서 on 2021/11/15.
//

import UIKit.UIButton

class TagButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeButton()
        addTapAction()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension TagButton {
    public func setText(with text: String, state: UIControl.State = .normal) {
        setTitle(text, for: .normal)
        sizeToFit()

        switch state {
        case .selected:
            isSelected = true
        default:
            isSelected = false
        }
    }
}
extension TagButton {
    private func makeButton() {
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

        titleLabel?.font = .systemFont(ofSize: 12, weight: .semibold)

        layer.cornerRadius = 12
        clipsToBounds = true

        setTitleColor(Color.daangnWhite, for: .selected)
        setTitleColor(Color.daangnGray3, for: .normal)
        setBackgroundColor(Color.daangnOrange, for: .selected)
        setBackgroundColor(Color.daangnGray1, for: .normal)
    }

    private func addTapAction() {
        addTarget(self, action: #selector(buttonDidTapped), for: .touchUpInside)
    }
}

extension TagButton {
    @objc
    private func buttonDidTapped() {
        isSelected.toggle()
    }
}
