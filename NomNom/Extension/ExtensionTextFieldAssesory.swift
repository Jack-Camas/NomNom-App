//
//  ExtensionTextFiledForIcon.swift
//  nomnom
//
//  Created by Life on 11/9/23.
//

import UIKit

extension UITextField {
    
    func addAssesory(_ image: UIImage, size: Int, withColor: UIColor){
        let padding = 8
        let outerBounds = UIView(frame: CGRect(x: 0, y: 0, width: size+padding, height: size))
        let imageAssesory = UIImageView(frame: CGRect(x: -padding, y: 0, width: size, height: size))
        
        imageAssesory.image = image
        imageAssesory.tintColor = withColor
        outerBounds.addSubview(imageAssesory)
        
        
        rightView = outerBounds
        rightViewMode = .always
    }
}
