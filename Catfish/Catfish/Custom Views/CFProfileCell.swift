//
//  CFProfileCell.swift
//  Catfish
//
//  Created by Shawn Gee on 4/1/20.
//  Copyright © 2020 James Pacheco. All rights reserved.
//

import UIKit

class CFProfileCell: UICollectionViewCell {
    enum State {
        case filled(Profile)
        case empty
    }
    
    // MARK: - Public Methods
    
    func set(state: State,
             imageSize: CGFloat = 50,
             imageOnly: Bool = false,
             labelFont: UIFont = UIFont.systemFont(ofSize: 14, weight: .bold),
             layoutAxis: NSLayoutConstraint.Axis = .vertical) {
        self.imageSize = imageSize
        self.imageOnly = imageOnly
        self.labelFont = labelFont
        self.layoutAxis = layoutAxis
        updateViews(with: state)
    }
    
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
    
    private var imageSize: CGFloat = 50
    private var imageOnly = false
    private var labelFont: UIFont = .systemFont(ofSize: 14, weight: .bold)
    private var layoutAxis: NSLayoutConstraint.Axis = .horizontal
    
    private lazy var imageView = CircularImageView(width: imageSize)
    private lazy var nameLabel = UILabel(text: "Jonny", font: labelFont , textAlignment: .center)
    private lazy var stackView = UIStackView(arrangedSubviews: [imageView, nameLabel])
    
    private func configure() {
        stackView.axis = layoutAxis
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubviews(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        imageView.backgroundColor = Colors.purple
        imageView.image = Images.postPlaceholder
    }
    
    private func updateViews(with state: State) {
        if case let .filled(profile) = state {
            imageView.setWidth(imageSize)
            nameLabel.isHidden = imageOnly
            nameLabel.font = labelFont
            nameLabel.textAlignment = layoutAxis == .vertical ? .center : .left
            stackView.spacing = layoutAxis == .vertical ? 0 : 12
            stackView.axis = layoutAxis
            
            // Fetch image
            
            nameLabel.text = profile.username
        } else {
            // TODO: What does empty look like?
        }
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

