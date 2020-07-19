//
//  PacketNpcUpdate.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//  Direction: Server -> Client

import Foundation
import SwiftyBytes

/// NPC Update (INCOMPLETE)
public struct PacketNpcUpdate: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .NpcUpdate
    public var payload: [UInt8] = []
    public var npcId: Int16 = 0
    public var posX: Float32 = 0
    public var posY: Float32 = 0
    public var velocityX: Float32 = 0
    public var velocityY: Float32 = 0
    public var target: UInt16 = 0
    public var flags: UInt8 = 0
    public var ai: [Float32] = []
    public var npcNetId: Int16 = 0
    public var releaseOwner: UInt8 = 0
    public var life: Int32 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        print("Not Implemented")
    }
    mutating public func encodePayload() throws{
        print("Not Implemented")
    }
}
