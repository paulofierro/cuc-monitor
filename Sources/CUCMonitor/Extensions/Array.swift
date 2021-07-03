//
//  Array.swift
//  
//
//  Created by Paulo Fierro on 03/07/2021.
//

import Foundation

extension Array {

    /// Returns an element at a specific index, or nil if the index is out of bounds.
    subscript(safeIndex index: Int) -> Element? {
        guard index >= startIndex, index < endIndex else {
            return nil
        }
        return self[index]
    }
}
