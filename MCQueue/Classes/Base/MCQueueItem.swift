//
//  MCQueueItem.swift
//  MCQueue
//
//  Created by xiaochuan on 2024/1/12.
//

import Foundation

open class MCQueueItem: NSObject, MCQueueItemProtocol {
    
    public typealias T = AnyObject
    open var identifier: String = ""
    open var bizItem: T?
    
    public init(bizItem: T? = nil) {
        if let bizItem = bizItem {
            self.identifier = String(describing: type(of: bizItem))
        }
        self.bizItem = bizItem
        super.init()
    }
    
    public init(identifier: String, bizItem: T? = nil) {
        self.identifier = identifier
        if identifier.isEmpty, let bizItem = bizItem {
            self.identifier = String(describing: type(of: bizItem))
        }
        self.bizItem = bizItem
        super.init()
    }
}
