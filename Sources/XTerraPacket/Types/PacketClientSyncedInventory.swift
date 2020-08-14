//
//  PacketClientSyncedInventory.swift
//
//
//  Created by Quentin Berry on 5/22/20.
//  Direction: Client -> Server

import Foundation
import SwiftyBytes

public struct PacketClientSyncedInventory: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var context: TerrariaPacketContext = .ClientToServer
    public var packetType: TerrariaPacketType = .ClientSyncedInventory
    public var payload: [UInt8] = []
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
    }
    mutating public func encodePayload() throws{
    }
}
