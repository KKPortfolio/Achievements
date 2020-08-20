//
//  InitialData.swift
//  Achievements
//
//  Created by Kurt Kim on 2020-08-20.
//  Copyright © 2020 Kurt Kim. All rights reserved.
//

import Foundation

struct InitialData {
    let userId = Int.random(in: 0..<9999)
    let personalRecords: [String] = ["01:22", "2095 ft", "00:00", "00:00:00", "00:00", ""]
    let virtualRaces: [String] = ["00:00", "00:00:00", "00:00:00", "00:00:00", "00:00:00", "23:07"]
}

