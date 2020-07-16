//
//  NetModule.swift
//  
//
//  Created by Quentin Berry on 7/15/20.
//

import Foundation
import SwiftyBytes

/// This is a protocol in which all NetModules should conform to.
public protocol NetModule{
    /**
    Call this function to decode a netmodule from a given BinaryReader's data.
    */
    mutating func decode(_ reader: BinaryReader) throws
    
    /**
    Call this function to encode the payload of a netmodule to a given BinaryWriter.
    */
    mutating func encode(_ writer: BinaryWriter) throws
    
    /**
    Placeholder init
    */
    init()
}
