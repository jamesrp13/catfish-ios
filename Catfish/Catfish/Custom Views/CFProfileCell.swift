//
//  CFProfileCell.swift
//  Catfish
//
//  Created by Shawn Gee on 4/1/20.
//  Copyright © 2020 James Pacheco. All rights reserved.
//

import UIKit

class CFProfileCell: UICollectionViewCell {
    // MARK: - Properties
    
    var profile: Profile? { didSet { updateViews() }}
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    // MARK: - Private
    private let imageView = CircularImageView(width: 50)
    private let nameLabel = UILabel(text: "Jonny", font: .systemFont(ofSize: 14, weight: .bold) , textAlignment: .center)
    private lazy var vStack = UIStackView(arrangedSubviews: [imageView, nameLabel])
    
    private func configure() {
        vStack.axis = .vertical
        vStack.alignment = .center
        vStack.translatesAutoresizingMaskIntoConstraints = false
        addSubviews(vStack)
        
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: topAnchor),
            vStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            vStack.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        imageView.backgroundColor = Colors.purple
        imageView.image = Images.postPlaceholder
    }
    
    private func updateViews() {
        // Fetch image
        
        nameLabel.text = profile?.name
    }
}


// Uncomment below to enable SwiftUI previews for visual feedback

//import SwiftUI
//
//struct ViewWrapper: UIViewRepresentable {
//    func makeUIView(context: UIViewRepresentableContext<ViewWrapper>) -> UIView {
//        return CFProfileCell()
//    }
//
//    func updateUIView(_ uiView: ViewWrapper.UIViewType, context: UIViewRepresentableContext<ViewWrapper>) {
//    }
//}
//
//struct ViewWrapper_Previews: PreviewProvider {
//    static var previews: some View {
//        ViewWrapper().frame(width: 80, height: 80)
//    }
//}

