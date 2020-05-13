//
//  PacketUpdateTileEntity.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketUpdateTileEntity: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .UpdateTileEntity
    public var payload: [UInt8] = []
    public var key: Int32 = 0
    public var isRemove: Bool = false
    public var tileEntityType: UInt8 = 0
    public var tileId: Int32 = 0
    public var x: Int16 = 0
    public var y: Int16 = 0
    public var npc: Int16 = 0
    public var itemType: Int16 = 0
    public var prefix: UInt8 = 0
    public var stack: Int16 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.key = try reader.readInt32()
        self.isRemove = try reader.readBool()
        if !self.isRemove {
            self.tileEntityType = try reader.readUInt8()
            self.tileId = try reader.readInt32()
            self.x = try reader.readInt16()
            self.y = try reader.readInt16()
            if self.tileEntityType == 0 {
                self.npc = try reader.readInt16()
            }
            self.itemType = try reader.readInt16()
            self.prefix = try reader.readUInt8()
            self.stack = try reader.readInt16()
        }
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
