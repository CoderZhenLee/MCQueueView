//
//  ViewController.swift
//  MCQueue
//
//  Created by yixiaochuan on 01/11/2024.
//  Copyright (c) 2024 yixiaochuan. All rights reserved.
//

import UIKit
import MCQueue

class ViewController: UIViewController {
    
    @IBOutlet weak var pushButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var insertButton: UIButton!
    
    
    var barrageView = MCQueueView<MCQueueItem>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        barrageView.frame = CGRect(x: 0, y: 120, width: self.view.bounds.width, height: 50)
        barrageView.delegate = self
        
        barrageView.classCustomMapper(["insert": MCQueueCell5.self,
                                       "2": MCQueueCell3.self,
                                       "3": MCQueueCell4.self,
                                       "MCItem": MCQueueCell2.self,
                                      ])
        self.view.addSubview(barrageView)
    }
    
    /** 添加到队列 */
    @IBAction func pushAction(_ sender: Any) {
        for _ in 1...10 {
            
            /** bizItem 为业务数据模型, 可为任意类型 */
            let bizItem = MCItem()
            let item = MCQueueItem(bizItem: bizItem)
            
            /** 插入单条数据 */
            barrageView.push(item)
            
            
            
            let item2 = MCQueueItem()
            item2.identifier = "2"
            let bizItem2 = MCItem()
            item2.bizItem = bizItem2
            
            let item3 = MCQueueItem()
            item3.identifier = "3"
            let bizItem3 = MCItem2()
            item3.bizItem = bizItem3
            
            /** 同时插入多条数据 */
            barrageView.push([item2, item3])
        }
    }
    
    /** 清空队列 */
    @IBAction func clearAction(_ sender: Any) {
        barrageView.clearAll()
    }
    
    /** 插入队列 */
    @IBAction func insertAction(_ sender: Any) {
        let item3 = MCQueueItem()
        item3.identifier = "insert"
        let bizItem3 = MCItem()
        item3.bizItem = bizItem3
        
        barrageView.insert(item3, at: 0)
    }

}

/** 动画协议 */
extension ViewController: MCQueueAnimationProtocol {
//    var customAnimation: Bool {
//        return false
//    }
//    
//    func startToShowCustomAnimation(_ completion: ((MCQueue.MCQueueCell<MCQueueItem>?) -> Void)?) {
//        
//    }
//    
    func startToShow() {
        print("【MCQueueView】开始展示")
    }
    
    func finishToShow() {
        print("【MCQueueView】结束展示")
    }
    
    func cellDidClick(_ item: any MCQueueItemProtocol) {
        print("【MCQueueView】点击了cell, identifier:\(item.identifier)")
    }
}
