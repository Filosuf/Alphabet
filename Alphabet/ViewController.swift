//
//  ViewController.swift
//  Alphabet
//
//  Created by Filosuf on 29.01.2023.
//

import UIKit

final class ViewController: UIViewController {
    private let letters = [
                "а", "б", "в", "г", "д", "е", "ё", "ж", "з", "и", "й", "к",
                "л", "м", "н", "о", "п", "р", "с", "т", "у", "ф", "х", "ц",
                "ч", "ш" , "щ", "ъ", "ы", "ь", "э", "ю", "я"
            ]

    private lazy var LetterCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.allowsMultipleSelection = false
        collectionView.register(LetterCollectionViewCell.self, forCellWithReuseIdentifier: LetterCollectionViewCell.identifier)
        collectionView.register(SupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.register(SupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer")
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
    }
    // MARK: - Methods
        private func layout() {
            
            [LetterCollectionView].forEach { view.addSubview($0) }

            NSLayoutConstraint.activate([
                LetterCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                LetterCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                LetterCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                LetterCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }

    private func makeBold(indexPath: IndexPath) {
            let cell = LetterCollectionView.cellForItem(at: indexPath) as? LetterCollectionViewCell
            cell?.titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        }

    private func makeItalic(indexPath: IndexPath) {
        let cell = LetterCollectionView.cellForItem(at: indexPath) as? LetterCollectionViewCell
        cell?.titleLabel.font = UIFont.italicSystemFont(ofSize: 17)
    }
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        letters.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LetterCollectionViewCell.identifier, for: indexPath) as! LetterCollectionViewCell
        cell.setupCell(date: letters[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var id: String                                      // 1
        switch kind {                                       // 2
        case UICollectionView.elementKindSectionHeader:     // 3
            id = "header"
        case UICollectionView.elementKindSectionFooter:     // 4
            id = "footer"
        default:
            id = ""                                         // 5
        }

        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: id, for: indexPath) as? SupplementaryView // 6
        view?.titleLabel.text = "Здесь находится Supplimentary view"
        return view!
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    private var sideInset: CGFloat { return 8}

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {       // 2

        let indexPath = IndexPath(row: 0, section: section)         // 3
        let headerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath)                   // 4

        return headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width,
                                                         height: UIView.layoutFittingExpandedSize.height),
                                                  withHorizontalFittingPriority: .required,
                                                  verticalFittingPriority: .fittingSizeLevel)           // 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let indexPath = IndexPath(row: 0, section: section)
        let footerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionFooter, at: indexPath)

        return footerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width,
                                                         height: UIView.layoutFittingExpandedSize.height),
                                                    withHorizontalFittingPriority: .required,
                                                    verticalFittingPriority: .fittingSizeLevel)
    }

}
// MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) { // 2
        let cell = collectionView.cellForItem(at: indexPath) as? LetterCollectionViewCell // 3
        cell?.titleLabel.font = UIFont.boldSystemFont(ofSize: 17)                         // 4
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? LetterCollectionViewCell
        cell?.titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
    }

    private func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemsAt indexPaths: [IndexPath], point: CGPoint) -> UIContextMenuConfiguration? {   // 1
            guard indexPaths.count > 0 else {                                 // 2
                return nil
            }

            let indexPath = indexPaths[0]                                     // 3

            return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { actions in    // 4
                return UIMenu(children: [                                     // 5
                    UIAction(title: "Bold") { [weak self] _ in                // 6
                        self?.makeBold(indexPath: indexPath)
                    },
                    UIAction(title: "Italic") { [weak self] _ in              // 7
                        self?.makeItalic(indexPath: indexPath)
                    },
                ])
            }
        }
}
