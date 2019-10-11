//
//  MasterScrollView.swift
//  Property-Wrappers
//
//  Created by Satish Babariya on 28/12/18.
//  Copyright © 2018 Satish Babariya. All rights reserved.
//

import Foundation
import UIKit

@propertyWrapper
class Scrollable{
    var wrappedValue: UIView
    var projectedValue: ScrollView

    public init(Direction direction: ScrollView.Direction) {
        self.wrappedValue = UIView()
        self.projectedValue = ScrollView(with: direction)
        self.wrappedValue = projectedValue.container
    }
}

class ScrollView: UIScrollView {
    // MARK: - Attributes -
    /// Scroll View Scroll Direction
    ///
    /// - vertical: Vertical Scroll
    /// - horizontal: Horizontal Scroll
    /// - all: Scroll in Both Direction ( Vertical + Horizontal )
    internal enum Direction {
        case vertical
        case horizontal
        case all
    }

    /// Scroll Container View
    public var container: UIView!

    /// Scroll Direction
    fileprivate var direction: Direction = .vertical

    // MARK: - Lifecycle -
    init(with direction: Direction = .vertical) {
        super.init(frame: CGRect.zero)
        self.direction = direction
        setupView()
        setupLayout()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        if container != nil, container.superview != nil {
            container.removeFromSuperview()
            container = nil
        }
    }

    // MARK: - Initializations -
    func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false

        container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        addSubview(container)
    }

    // MARK: - Layout -
    func setupLayout() {
        let viewDictionary: [String: Any] = ["container": container, "self": self]

        /// Abstraction of addConstraints function
        ///
        /// - Parameter withVisualFormat: VFC String
        func addConstraint(withVisualFormat: String) {
           addConstraints(NSLayoutConstraint.constraints(withVisualFormat: withVisualFormat, options: [], metrics: nil, views: viewDictionary))
        }

        // Set Constraints according to Direction
        switch direction {
        case .vertical:
            addConstraint(withVisualFormat: "H:|[container(==self)]|")
            addConstraint(withVisualFormat: "V:|[container(==self@249)]|")
        case .horizontal:
            addConstraint(withVisualFormat: "H:|[container(==self@249)]|")
            addConstraint(withVisualFormat: "V:|[container(==self)]|")
        case .all:
            addConstraint(withVisualFormat: "H:|[container(==self@249)]|")
            addConstraint(withVisualFormat: "V:|[container(==self@249)]|")
        }
    }
}
