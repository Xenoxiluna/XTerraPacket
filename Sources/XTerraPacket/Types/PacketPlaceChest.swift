//
//  PacketPlaceChest.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//  Direction: Server <-> Client

import Foundation
import SwiftyBytes

/// Place chest
public struct PacketPlaceChest: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var context: TerrariaPacketContext = .ServerToClient
    public var packetType: TerrariaPacketType = .PlaceChest
    public var payload: [UInt8] = []
    public var action: ChestAction = .PlaceChest
    public var tileX: Int16 = 0
    public var tileY: Int16 = 0
    public var style: Int16 = 0
    public var chestIdDestroy: Int16 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        if let a = ChestAction.init(rawValue: try reader.readUInt8()){
            self.action = a
        }
        self.tileX = try reader.readInt16()
        self.tileY = try reader.readInt16()
        self.style = try reader.readInt16()
        self.chestIdDestroy = try reader.readInt16()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt8(action.rawValue)
        try writer.writeInt16(tileX)
        try writer.writeInt16(tileY)
        try writer.writeInt16(style)
        try writer.writeInt16(chestIdDestroy)
        payload.append(contentsOf: writer.data.bytes)
    }
    
    public enum ChestAction: UInt8 {
        case PlaceChest = 0
        case KillChest = 1
        case PlaceDresser = 2
        case KillDresser = 3
        case PlaceContainers = 4
        case KillContainers = 5
    }
}
