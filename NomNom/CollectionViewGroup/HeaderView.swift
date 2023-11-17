//
//  SearchHeaderView.swift
//  nomnom
//
//  Created by Jack on 11/9/23.
//

import UIKit


class HeaderView: UICollectionReusableView, UICollectionViewDelegate, UITextFieldDelegate {
    
    static let id = "searchHeaderView"
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addCustomConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addCustomConstraints() {
            
      //  contentView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: topAnchor,constant: 8).isActive = true
        collectionView.leftAnchor.constraint(equalTo: leftAnchor, constant:  24).isActive = true
        collectionView.bottomAnchor.constraint(equalTo:bottomAnchor ,constant: 0).isActive = false
        collectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: -24).isActive = true
        collectionView.widthAnchor.constraint(equalToConstant: 0).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell1")
        

        
    }


    
lazy var collectionView: UICollectionView = {
    let viewLayout = makeCompositionalLayoutViewControllerWithZoomingCarousel()
    //let viewLayout = UICollectionViewFlowLayout()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
    
    collectionView.backgroundColor = .white
    return collectionView
}()
    
}


extension HeaderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell1", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("HORIZONTAL View\(indexPath)")
    }
    

}


//struct CompositionalLayout {
    
func makeCompositionalLayoutViewControllerWithZoomingCarousel() -> UICollectionViewCompositionalLayout {
        let compositionalLayout: UICollectionViewCompositionalLayout = {
            let fraction: CGFloat = 1.0 / 4.0
            
            // Item
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // Group
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction), heightDimension: .fractionalWidth(fraction))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 2.5, bottom: 0, trailing: 2.5)
            section.orthogonalScrollingBehavior = .continuous
            section.visibleItemsInvalidationHandler = { (items, offset, environment) in
                items.forEach { item in
                    let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                    let minScale: CGFloat = 0.7
                    let maxScale: CGFloat = 0.7
                    let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                    item.transform = CGAffineTransform(scaleX: scale, y: scale)
                }
            }
            
            return UICollectionViewCompositionalLayout(section: section)
        }()
        return compositionalLayout
    }
//}


