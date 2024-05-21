import XCTest
import SwiftUI
import ViewInspector
@testable import easy_chores


class ErrorViewTests: XCTestCase {
    
    func testErrorViewDisplaysErrorMessage() throws {
        let errorManager = ErrorManager()
        errorManager.error = CustomDataError.error("This is custom error.")
        
        let view = ErrorView().environmentObject(errorManager)
        
        let _ = try view.inspect().find(text: "This is custom error.")
        let _ = try view.inspect().find(text: "Please try again later.")
        let button = try view.inspect().find(button: "Okay")
        try button.tap()
        XCTAssertNil(errorManager.error)
        
    }
}
