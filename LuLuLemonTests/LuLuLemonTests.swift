//
//  LuLuLemonTests.swift
//  LuLuLemonTests
//
//  Created by Preeti Priyam on 7/20/21.
//

import XCTest
@testable import LuLuLemon

class LuLuLemonTests: XCTestCase {

    let garmentViewModel = GarmentViewModel()
    
    func testGreaterThanMethod(){
        let g2 = Date()
        let g1 = Date().addingTimeInterval(50)
        XCTAssertEqual(true, garmentViewModel.isGreater(g1: Int16(5), g2: Int16(1)))
        XCTAssertEqual(true, garmentViewModel.isGreater(g1: "b", g2: "a"))
        XCTAssertEqual(true, garmentViewModel.isGreater(g1: g1, g2: g2))
        
    }
}
