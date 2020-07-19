//
//  PacketDoorUse.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//  Direction: Server <-> Client (Sync)

import Foundation
import SwiftyBytes

/// Door Action
public struct PacketDoorUse: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .DoorUse
    public var payload: [UInt8] = []
    public var action: DoorAction = .OpenDoor
    public var tileX: Int16 = 0
    public var tileY: Int16 = 0
    public var direction: UInt8 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        if let a = DoorAction.init(rawValue: try reader.readUInt8()){
            self.action = a
        }
        self.tileX = try reader.readInt16()
        self.tileY = try reader.readInt16()
        self.direction = try reader.readUInt8()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt8(action.rawValue)
        try writer.writeInt16(tileX)
        try writer.writeInt16(tileY)
        try writer.writeUInt8(direction)
        payload.append(contentsOf: writer.data.bytes)
    }
    
    public enum DoorAction: UInt8 {
        case OpenDoor = 0
        case CloseDoor = 1
        case OpenTrapdoor = 2
        case CloseTrapdoor = 3
        case OpenTallGate = 4
        case CloseTallGate = 5
    }
}
