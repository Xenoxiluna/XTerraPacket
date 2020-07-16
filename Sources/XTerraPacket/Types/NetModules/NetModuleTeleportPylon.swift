//
//  NetModuleTeleportPylon.swift
//  
//
//  Created by Quentin Berry on 7/16/20.
//

import Foundation
import SwiftyBytes

/// This is a struct for the TeleportPylon NetModule.
public struct NetModuleTeleportPylon: NetModule{
    public var action: UInt8 = 0
    public var x: Int16 = 0
    public var y: Int16 = 0
    public var pylonType: UInt8 = 0

    public init(){}

    /**
    Call this function to initialize the NetModule with data.
     - Parameters:
        - action : Use = 2, Add = , Remove =
        - x : X Coordinate
        - y : Y Coordinate
        - pylonType : Type of pylon
     
    ### Usage Example: ###
    ````
    
    ````
    */
    public init(action: UInt8, x: Int16, y: Int16, pylonType: UInt8){
        self.action = action
        self.x = x
        self.y = y
        self.pylonType = pylonType
    }

    public mutating func decode(_ reader: BinaryReader) throws{
        self.action = try reader.readUInt8()
        self.x = try reader.readInt16()
        self.y = try reader.readInt16()
        self.pylonType = try reader.readUInt8()
    }
    public mutating func encode(_ writer: BinaryWriter) throws{
        try writer.writeUInt8(self.action)
        try writer.writeInt16(self.x)
        try writer.writeInt16(self.y)
        try writer.writeUInt8(self.pylonType)
    }
}
