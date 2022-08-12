//
//  New.swift
//  Cal
//
//  Created by Nathaniel Whittington on 4/29/22.
//

import Foundation
import UIKit

@objc class Person: NSObject {
    @objc dynamic var name = "Taylor Swift"
}

let taylor = Person()


taylor.observe(\Person.name, options: .new) { person, change in
    print("I'm now called \(person.name)")
}
