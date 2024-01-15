//
//  MCQueueCell.swift
//  MCQueue
//
//  Created by xiaochuan on 2024/1/11.
//

import Foundation

open class MCQueueCell<T>: UIView {
    
    open var item: T?
    
    open var itemDidClicked:((T) -> Void)?
    
    public init() {
        super.init(frame: .zero)
        
        backgroundColor = UIColor.clear
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(_itemDidClicked))
        addGestureRecognizer(tap)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func _itemDidClicked() {
        guard let item = item else {
            return
        }
        itemDidClicked?(item)
    }
}
