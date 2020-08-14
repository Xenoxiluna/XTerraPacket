//
//  PacketFinishedConnectingToServer.swift
//
//
//  Created by Quentin Berry on 5/22/20.
//  Direction: Server -> Client

import Foundation
import SwiftyBytes

/// Finished connecting to the server
public struct PacketFinishedConnectingToServer: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var context: TerrariaPacketContext = .ServerToClient
    public var packetType: TerrariaPacketType = .FinishedConnectingToServer
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
