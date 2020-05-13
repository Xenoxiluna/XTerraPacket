//
//  PacketTreeGrowFX.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketTreeGrowFX: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .TreeGrowFX
    public var payload: [UInt8] = []
    public var growEffect: Bool = false
    public var x: Int16 = 0
    public var y: Int16 = 0
    public var height: UInt8 = 0
    public var treeGore: Int16 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.growEffect = try reader.readBool()
        self.x = try reader.readInt16()
        self.y = try reader.readInt16()
        self.height = try reader.readUInt8()
        self.treeGore = try reader.readInt16()
    }
    public func encoded() -> [UInt8]{
        print("Not Implemented")
        return []
    }
    mutating public func encode(){
        print("Not Implemented")
    }
    public func getLength(){
        print("Not Implemented")
    }
}
