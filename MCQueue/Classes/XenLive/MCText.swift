//
//  MCText.swift
//  MCQueue
//
//  Created by yixiaochuan on 01/11/2024.
//  Copyright (c) 2024 yixiaochuan. All rights reserved.
//

import UIKit


public class MCItem: NSObject {
    var idx: Int = 0
}

public class MCItem2: MCItem {
    var width: CGFloat = 0
}

public class MCItem3: MCItem {
    var scale: CGFloat = 0.5
}

public class MCQueueCell2: MCQueueCell<MCQueueItem> {
    
    public override init() {
        super.init()

        backgroundColor = UIColor.yellow
    }
    
    public override var item: MCQueueItem? {
        didSet {
            guard let bizItem = item?.bizItem as? MCItem else {
                return
            }
            backgroundColor = UIColor.orange
        }
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class MCQueueCell3: MCQueueCell<MCQueueItem> {
    
    public override var item: MCQueueItem? {
        didSet {
            
        }
    }
    
    public override init() {
        super.init()
        
        backgroundColor = UIColor.red
        
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class MCQueueCell4: MCQueueCell<MCQueueItem> {
    
    public override init() {
        super.init()
        
        backgroundColor = UIColor.gray
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class MCQueueCell5: MCQueueCell<MCQueueItem> {
    
    public override init() {
        super.init()
        
        backgroundColor = UIColor.purple
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
