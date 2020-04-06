//
//  NewGameViewController.swift
//  Catfish
//
//  Created by Shawn Gee on 4/1/20.
//  Copyright © 2020 James Pacheco. All rights reserved.
//

import UIKit

class NewGameViewController: FormViewController {

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        contentView = newGameView
        super.viewDidLoad()
        configure()
    }
    
    override func loadView() {
        view = BGGradientView()
    }
    
    // MARK: - Private Properties
    
    private var durationManager: PickerTextFieldManager?
    
    private let newGameView = NewGameView()
    
    private lazy var teamNameTextField = newGameView.teamNameTextField
    private lazy var gameDurationTextField: UITextField = newGameView.gameDurationTextField
    private lazy var inviteCodeTextField = newGameView.inviteCodeTextField
    private lazy var createButton = newGameView.createButton
    
    // MARK: - Private Methods
    
    private func configure() {
        durationManager = PickerTextFieldManager(textField: gameDurationTextField, options: ["3 Days", "5 Days", "7 Days"], initialIndex: 2)
    }
}




// Uncomment below to enable SwiftUI previews for visual feedback

//import SwiftUI
//
//struct ViewWrapper: UIViewRepresentable {
//    func makeUIView(context: UIViewRepresentableContext<ViewWrapper>) -> UIView {
//        return NewGameViewController().view
//    }
//
//    func updateUIView(_ uiView: ViewWrapper.UIViewType, context: UIViewRepresentableContext<ViewWrapper>) {
//    }
//}
//
//struct ViewWrapper_Previews: PreviewProvider {
//    static var previews: some View {
//        ViewWrapper()
//    }
//}
