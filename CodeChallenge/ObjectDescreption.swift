//
//  ObjectDescreption.swift
//  CodeChallenge
//
//  Created by Matt Lintlop on 9/22/18.
//  Copyright © 2018 Matt Lintlop. All rights reserved.
//

import Foundation

// Object Summary structure
struct ObjectSummary: Decodable {
    let type:String                 // object type
    let name: String                // object name
    let color: String               // object color
    let descreption: String         // object descreption
    
}

// Object Data class
class ObjectDescreption {
    let summary: ObjectSummary      // object summary

    init(summary: ObjectSummary) {
        self.summary = summary
    }
}
