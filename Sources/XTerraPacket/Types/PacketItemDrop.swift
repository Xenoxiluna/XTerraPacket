//
//  PacketItemDrop.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketItemDrop: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .ItemDrop
    public var payload: [UInt8] = []
    public var itemId: Int16 = 0
    public var positionX: Float32 = 0
    public var positionY: Float32 = 0
    public var velocityX: Float32 = 0
    public var velocityY: Float32 = 0
    public var stackSize: Int16 = 0
    public var prefix: UInt8 = 0
    public var noDelay: UInt8 = 0
    public var itemNetId: Int16 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.itemId = try reader.readInt16()
        self.positionX = try reader.readFloat32()
        self.positionY = try reader.readFloat32()
        self.velocityX = try reader.readFloat32()
        self.velocityY = try reader.readFloat32()
        self.stackSize = try reader.readInt16()
        self.prefix = try reader.readUInt8()
        self.noDelay = try reader.readUInt8()
        self.itemNetId = try reader.readInt16()
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
