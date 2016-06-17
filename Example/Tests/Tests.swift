// https://github.com/Quick/Quick

import Quick
import Nimble
import Vandelay

class TableOfContentsSpec: QuickSpec {
    override func spec() {
        describe("these will fail") {

            it("can do maths") {
                expect(1) == 1
            }

            it("can read") {
                expect("number") == "number"
            }

            it("will eventually fail") {
                expect("time").toEventually( equal("time") )
            }
            
            context("these will pass") {

                it("can do maths") {
                    expect(23) == 23
                }

                it("can read") {
                    expect("🐮") == "🐮"
                }

                it("will eventually pass") {
                    var time = "passing"

                    dispatch_async(dispatch_get_main_queue()) {
                        time = "done"
                    }

                    waitUntil { done in
                        NSThread.sleepForTimeInterval(0.5)
                        expect(time) == "done"

                        done()
                    }
                }
            }
        }
    }
}
