//
//  PacketNpcShopItem.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketNpcShopItem: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .NpcShopItem
    public var payload: [UInt8] = []
    public var slot: UInt8 = 0
    public var itemType: Int16 = 0
    public var stack: Int16 = 0
    public var prefix: UInt8 = 0
    public var value: Int32 = 0
    public var flags: UInt8 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.slot = try reader.readUInt8()
        self.itemType = try reader.readInt16()
        self.stack = try reader.readInt16()
        self.prefix = try reader.readUInt8()
        self.value = try reader.readInt32()
        self.flags = try reader.readUInt8()
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
