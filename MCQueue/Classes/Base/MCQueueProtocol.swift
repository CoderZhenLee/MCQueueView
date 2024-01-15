//
//  File.swift
//  MCQueue
//
//  Created by xiaochuan on 2024/1/11.
//

import Foundation

public protocol MCQueueAnimationProtocol: NSObjectProtocol {
    
    /** 开始展示动画 */
    func startToShow()
    /** 结束展示动画 */
    func finishToShow()
    
    /** 点击cell */
    func cellDidClick(_ item: any MCQueueItemProtocol)
    
    /** 自定义礼物展示 */
    var customAnimation: Bool { get }
    /** 开始自定义动画 */
    func startToShowCustomAnimation(_ completion: ((MCQueueCell<any MCQueueItemProtocol>?) -> Void)?)
}

public extension MCQueueAnimationProtocol {
    
    /** 开始展示动画 */
    func startToShow() {}
    /** 结束展示动画 */
    func finishToShow() {}
    
    /** 点击cell */
    func cellDidClick(_ item: any MCQueueItemProtocol) {}
    
    /** 是否要自定义动画*/
    var customAnimation: Bool {
        return false
    }
    
    /** 开始自定义动画 */
    func startToShowCustomAnimation(_ completion: ((MCQueue.MCQueueCell<any MCQueueItemProtocol>?) -> Void)?) {}
}

public protocol MCQueueProtocol {
    
    associatedtype T: MCQueueItemProtocol
    
    /** 基础配置 */
    var config: MCQueueConfig? { set get }
    
    /** 动画相关操作 */
    var delegate: MCQueueAnimationProtocol? { set get }
    
    /** 入列 */
    mutating func push(_ item: T)
    mutating func push(_ items: [T])
    
    /** 插入数据 */
    mutating func insert(_ item: T, at index: Int)
    
    /** 出列 */
    mutating func pop() -> T
    
    /** 清空队列 */
    mutating func clearAll()
    
    /** 队列个数  */
    func size() -> Int
    
    /** 
     映射，若不调用，默认使用 MCQueueCell
     key：唯一标识
     value：要展示的cell
     */
    func classCustomMapper(_ dic: [String: MCQueueCell<T>.Type])
}

public struct MCQueueConfig {
    /** 动画进入时间 */
    public var enterInterval: TimeInterval = 0.3
    /** 动画停留时间 */
    public var stayInterval: TimeInterval = 1
    /** 动画离开时间 */
    public var leaveInterval: TimeInterval = 0.3
    /** 下一个展示间隔 */
    public var nextInterval: TimeInterval = 0.15
    
    /** cell距离两侧间距 */
    public var cellLeading: CGFloat = 10
}

/** 推荐使用 MCQueueItem，继承于 MCQueueItemProtocol */
public protocol MCQueueItemProtocol: NSObjectProtocol {
    
    associatedtype T
    
    /** 业务数据模型 */
    var bizItem: T? { set get }
    
    /** 当前模型唯一标识，用来判断展示对应cell，默认展示 MCQueueCell */
    var identifier: String { set get }
}
