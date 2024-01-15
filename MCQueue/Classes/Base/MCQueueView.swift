//
//  MCQueueView.swift
//  MCQueue
//
//  Created by xiaochuan on 2024/1/11.
//

import Foundation

public class MCQueueView<T: MCQueueItemProtocol>: UIView, MCQueueProtocol {
    
    public weak var delegate: MCQueueAnimationProtocol?
    
    /** 默认配置信息 */
    public var config: MCQueueConfig?
    /** 所有元素 */
    var elements = [T]()
    var lock = DispatchSemaphore(value: 1)
    /** 上次展示时间 */
    var lastShowDate: Date?
    var waitingDelayFlag: Bool = false
    /** 缓存，暂未实现。。 */
    var cacheCell: MCQueueCell<T>?
    /** 映射转换 */
    var classMapper: [String: NSObject.Type]?
    
    /** 入队 */
    public func push(_ item: T) {
        lock.wait()
        self.elements.append(item)
        self.dispatchToShow()
        lock.signal()
    }
    
    public func push(_ items: [T]) {
        lock.wait()
        self.elements.append(contentsOf: items)
        self.dispatchToShow()
        lock.signal()
    }
    
    /** 插入队列 */
    public func insert(_ item: T, at index: Int) {
        lock.wait()
        self.elements.insert(item, at: index)
        lock.signal()
    }
    
    /** 弹出队列 */
    public func pop() -> T {
        lock.wait()
        let e = self.elements.removeFirst()
        lock.signal()
        return e
    }
    
    /** 清空队列 */
    public func clearAll() {
        lock.wait()
        self.elements.removeAll()
        print("【MCQueueView】已清空")
        lock.signal()
    }
    
    /** 总个数 */
    public func size() -> Int {
        lock.wait()
        let size = elements.count
        lock.signal()
        return size
    }
    
    /** 映射关系 */
    public func classCustomMapper(_ dic: [String : MCQueueCell<T>.Type]) {
        classMapper = dic
    }
    
    deinit {
        lock.signal()
    }
    
    public init() {
        config = MCQueueConfig()
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /** 动画展示前限定处理 */
    @objc private func dispatchToShow() {
        if elements.count == 0 {
            return
        }
        if checkShowFrequencyLimit() {
            return
        }
        let e = elements.removeFirst()
        print("【MCQueueView】当前identifier: \(e.identifier) 剩余个数: \(elements.count)")
        _dispatchToShow(e)
        
        if elements.count > 0 {
            dispatchToShow()
        }
    }
    
    /** 控制频率 */
    private func checkShowFrequencyLimit() -> Bool {
        guard let lastShowDate = lastShowDate,
                let config = config else {
            return false
        }
        if config.stayInterval < 0 {
            return true
        }
        let delay = config.stayInterval - fabs(lastShowDate.timeIntervalSinceNow) + config.enterInterval + config.leaveInterval + max(0, config.nextInterval)
        if delay > 0 {
            if waitingDelayFlag == false {
                waitingDelayFlag = true
                MCQueueView.self.cancelPreviousPerformRequests(withTarget: self, selector: #selector(dispatchToShow), object: nil)
                self.perform(#selector(dispatchToShow), with: nil, afterDelay: delay)
            }
            return true
        }
        return false
    }
    
    /** 找到要展示的cell */
    private func _dispatchToShow(_ item: T) {
        waitingDelayFlag = false
        lastShowDate = Date()
        
        var cell: MCQueueCell<T>?
//        if let cacheCell = cacheCell {
//            cell = cacheCell
//        } else 
        if let classMapper = classMapper,
           let tClass = classMapper[item.identifier],
            let tempCell = tClass.init() as? MCQueueCell<T> {
            cell = tempCell
        } else {
            cell = MCQueueCell<T>()
        }
        guard let cell = cell else {
            return
        }
        
        cell.frame.size = CGSize(width: self.width - (config?.cellLeading ?? 0) * 2, height: self.height)
        cell.item = item
        cell.item?.bizItem = item.bizItem
        cell.itemDidClicked = { [weak self] item in
            self?.delegate?.cellDidClick(item)
        }
        toShowAnimation(cell)
    }
    
    /** 开始动画 */
    private func toShowAnimation(_ cell: MCQueueCell<T>) {
        guard let config = config else {
            return
        }
        delegate?.startToShow()
        
        addSubview(cell)
        cell.isHidden = false
        
        let animatedView = cell
        animatedView.left = self.width
        
        if delegate?.customAnimation == true {
            delegate?.startToShowCustomAnimation({ [weak self] cell in
                if let cell = cell {
                    self?.delegate?.finishToShow()
                    
                    cell.isHidden = true
                    cell.removeFromSuperview()
                    self?.dispatchToShow()
                }
            })
            return
        }
        UIView.animate(withDuration: config.enterInterval, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 2) {
            animatedView.left = config.cellLeading
        } completion: { _ in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + config.stayInterval, execute: {
                UIView.animate(withDuration: config.leaveInterval) { [weak self] in
                    animatedView.left = -(self?.frame.size.width ?? UIScreen.main.bounds.size.width)
                } completion: { [weak self] _ in
                    self?.finishAnimation(animatedView)
                }
            })
        }
    }
    
    /** 结束动画 */
    private func finishAnimation(_ cell: MCQueueCell<T>) {
        delegate?.finishToShow()
        
        cell.isHidden = true
        cell.removeFromSuperview()
        dispatchToShow()
    }
}
