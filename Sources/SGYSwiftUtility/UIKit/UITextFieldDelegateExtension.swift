//
//  UITextFieldDelegateExtension.swift
//  
//
//  Created by Sean Young on 1/13/22.
//

#if canImport(UIKit)

import UIKit

extension UITextFieldDelegate {
    
    public func makeNewString(from textField: UITextField, replacementRange range: NSRange, replacementString string: String) -> String {
        return (textField.text ?? "").replacingCharacters(in: Range<String.Index>(range, in: textField.text ?? "")!, with: string)
    }
}

#endif
