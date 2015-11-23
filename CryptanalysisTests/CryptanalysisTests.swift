import UIKit
import XCTest
import Cryptanalysis

class CryptanalysisTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testUtf8ToASCII() {
        let utf_8 = "ěščřžýáíéúů ťďľó äëïöü ß żź ôòø ñŝçş ĵĥğĝę"
        let ascii = "escrzyaieuu tdlo aeiou s zz ooo nscs jhgge"
        XCTAssertEqual(ascii, Utils.rewriteTextToASCIIChars(utf_8))
    }
    
    
    /*
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    */
    
}
