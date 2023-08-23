//
//  RecipesEmptyView.swift
//  MobileTask
//
//  Created by Ahmed Azab on 19/08/2023.
//

import UIKit

class RecipesEmptyView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)
        contentView.fixInView(self)
    }
}
