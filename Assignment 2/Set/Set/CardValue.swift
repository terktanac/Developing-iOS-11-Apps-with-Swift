//
//  CardValue.swift
//  Set
//
//  Created by Chanchiew, Tana (Agoda) on 13/7/2564 BE.
//

import Foundation
import UIKit

enum Shape: CaseIterable {
    case circle
    case triangle
    case square
}

enum Shade: CaseIterable {
    case striped
    case solid
    case open
}

enum Color: CaseIterable {
    case red
    case blue
    case green

}

struct CardValue: Equatable, Hashable {
    
    var shape: Shape
    
    var shade: Shade
    
    var color: Color
    
    var number: Int
    
    func toNSAttributedString() -> NSAttributedString {
        let textColor = color == Color.red ? UIColor.red : color == Color.blue ? UIColor.blue : UIColor.green
        let attributes : [NSAttributedString.Key : Any] = [
            .strokeColor: textColor,
            .foregroundColor: shade == Shade.striped ? textColor.withAlphaComponent(0.15) : shade == Shade.solid ? textColor.withAlphaComponent(1.0) : textColor.withAlphaComponent(0.0),
            .strokeWidth: shade == Shade.striped ? -5 : shade == Shade.solid ? -5 : -20
        ]
        let textShape = shape == Shape.circle ? "●" : shape == Shape.triangle ? "▲" : "■"
        let text = NSAttributedString(string: String(repeating: textShape, count: number), attributes: attributes)
        return text
    }
    
    init(shape: Shape, shade: Shade, color: Color, number: Int) {
        self.shape = shape
        self.shade = shade
        self.color = color
        self.number = number
    }
}

