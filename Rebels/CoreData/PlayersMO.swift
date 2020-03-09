//
//  PlayersMO.swift
//  Rebels
//
//  Created by Samuel Brasileiro on 08/03/20.
//  Copyright © 2020 Samuel. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class PlayersMO: NSManagedObject {
    
    @NSManaged var players: [Player]?
    
}
