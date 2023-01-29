//
//  LetterCollectionViewCell.swift
//  Alphabet
//
//  Created by Filosuf on 29.01.2023.
//

import UIKit

class LetterCollectionViewCell: UICollectionViewCell {
    static let identifier = "LetterCollectionViewCell"

    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        label.font = UIFont(name: "Rubik-Regular", size: 18)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

//    override var isSelected: Bool {
//        didSet{
//            if self.isSelected {
//                UIView.animate(withDuration: 0.3) {
//                    self.backgroundColor = .blue
//                    self.dateLabel.textColor = .white
//                }
//            }
//            else {
//                UIView.animate(withDuration: 0.3) {
//                    self.backgroundColor = .darkGray
//                    self.dateLabel.textColor = .black
//                }
//            }
//        }
//    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCell(date: String) {
        titleLabel.text = date
    }

    private func layout() {
        [titleLabel].forEach { contentView.addSubview($0) }
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
