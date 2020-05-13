//
//  PacketTile.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketTile: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .Tile
    public var payload: [UInt8] = []
    public var action: UInt8 = 0
    public var tileX: Int16 = 0
    public var tileY: Int16 = 0
    public var var1: Int16 = 0
    public var var2: UInt8 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.action = try reader.readUInt8()
        self.tileX = try reader.readInt16()
        self.tileY = try reader.readInt16()
        self.var1 = try reader.readInt16()
        self.var2 = try reader.readUInt8()
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
