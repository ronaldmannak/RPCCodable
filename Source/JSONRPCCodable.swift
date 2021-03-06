//
//  JSONRPCCodable.swift
//  Example
//
//  Created by Ronald "Danger" Mannak on 2/27/18.
//  Copyright © 2018 A Puzzle A Day. All rights reserved.
//

import Foundation

/**
 Protocol used for encoding and decoding JSON RPC requests
 
 Example: {"jsonrpc":"2.0","method":"web3_clientVersion","params":[],"id":67}
 */
public protocol JSONRPCRequestCodable: JSONRPCCodable {
    static func method() -> String
    
    /// If true, the dictionary of the by name parameters will be wrapped in an array when encoded in a .byName dictionary
    static func wrapParamsInArray() -> Bool
}

public extension JSONRPCRequestCodable {
    static func wrapParamsInArray() -> Bool {
        return true
    }
}

/**
 Protocol used for encoding and decoding JSON RPC Results
 
 Example: {"id":67, "jsonrpc":"2.0", "result": "Mist/v0.9.3/darwin/go1.4.1"}
 */
public protocol JSONRPCResponseCodable: JSONRPCCodable {
//    var id: Int { get }
}

/**
 Base JSON RPC protocol
 */
public protocol JSONRPCCodable: Codable, Equatable {
    static func structure() -> JSONRPCStructure
}

// Default implementations for JSONRPCResultCodable
public extension JSONRPCCodable {
    /**
     Default parameter encoding is .byPosition
     */
    static func structure() -> JSONRPCStructure {
        return .byPosition
    }
}

/// Supported RPC version, currently 2.0
public let rpcVersion = "2.0"

/**
 Defines whether parameters needs ot be encoded by name or position.
 E.g. eth_getCode's params need to be encoded by position: ["0xa94f5374fce5edbc8e2a8697c15331677e6ebf0b", "genesis"]
 eth_sendTransaction's params need to be encoded byName: [{"from":"0xb60e8dd61c5d32be8058bb8eb970870f07233155","to":"0xd46e8dd67c5d32be8058bb8eb970870f07244567",...}]
 */
public enum JSONRPCStructure { case byName, byPosition }
