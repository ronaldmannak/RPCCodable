//
//  Tests.swift
//  Tests
//
//  Created by Ronald "Danger" Mannak on 2/28/18.
//  Copyright © 2018 A Puzzle A Day. All rights reserved.
//

import XCTest
import JSONRPCCodable

class RequestCodableTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    /*
    func testEmptyParams() {
        struct Ethversion: JSONRPCCodable {
            static func method() -> String {
                return "eth_version"
            }
            static func paramEncoding() -> JSONRPCParamStructure {
                return .byName
            }
        }
        
        do {
            let ethVersion = Ethversion()
            try assertRoundtrip(ethVersion)
//            let result = try JSONRPCRequestEncoder.encode(ethVersion)
//            print(result)
        } catch {
            XCTFail("Unexpected Error: \(error)")
        }
    } */
    
    
    func testParameterByName() {
        struct ParamByName: JSONRPCCodable {
            
            let param1: String
            let param2: Int
            
            static func method() -> String { return "ParamByName" }
            static func paramEncoding() -> JSONRPCParamStructure { return .byName }
            static  func wrapParamsInArray() -> Bool { return false }
        }
        do {
            let p = ParamByName(param1: "FirstParameter", param2: 31)
            try assertRoundtrip(p)
        } catch {
            XCTFail("Unexpected Error: \(error)")
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
/*
// Requests
// This is an issue, if there's no property, encode is never called.
struct ClientVesionRequest: JSONRPCRequestCodable {
    let placeholder : String
//    let ph2: String
    func method() -> String { return "web3_clientVersion" }
    //{"jsonrpc":"2.0","method":"web3_clientVersion","params":[],"id":67}
}

struct Sha3: JSONRPCRequestCodable {
    
    //{"jsonrpc":"2.0","method":"web3_sha3","params":["0x68656c6c6f20776f726c64"],"id":64}
}

struct BlockTransactionCount: JSONRPCRequestCodable {
    // Make sure string isn't converted to hex
    // {"jsonrpc":"2.0","method":"eth_getBlockTransactionCountByNumber","params":["earliest"],"id":1}
}

struct Code: JSONRPCRequestCodable{
    // {"jsonrpc":"2.0","method":"eth_getCode","params":["0xa94f5374fce5edbc8e2a8697c15331677e6ebf0b", "genesis"],"id":1}
}

struct SendTransaction: JSONRPCRequestCodable {
    /*
     Make sure it gets encoded as a dictionary / byName
    {"jsonrpc":"2.0","method":"eth_sendTransaction","params":[{"from":"0xb60e8dd61c5d32be8058bb8eb970870f07233155","to":"0xd46e8dd67c5d32be8058bb8eb970870f07244567","gas":"0x76c0","gasPrice":"0x9184e72a000","value":"0x9184e72a","data":"0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8eb970870f072445675"}],"id":1}
 */
}
*/

private func assertEqual<T>(_ lhs: T, _ rhs: T) {
    XCTAssertEqual(String(describing: lhs), String(describing: rhs))
}

private func assertRoundtrip<T: JSONRPCCodable>(_ original: T) throws {
    // Encode
    let request = JSONRPCRequest<T>(params: original)
    let data = try JSONRPCRequestEncoder.encode(original)
    
    print("encoded: \(String(data: data, encoding: .utf8)!)")
    // Decode
    let decoder = JSONDecoder()
    let decodedRequest = try decoder.decode(JSONRPCRequest<T>.self, from: data)

    print(request)
    print(decodedRequest)
        
//        let roundtripped = try JSONRPCRequestDecoder.decode(T.self, data: data)
//        AssertEqual(original, roundtripped)

}
