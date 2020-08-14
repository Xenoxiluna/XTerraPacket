//
//  PacketSocialHandshake.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

/// Social Handshake
public struct PacketSocialHandshake: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var context: TerrariaPacketContext = .ServerToClient
    public var packetType: TerrariaPacketType = .SocialHandshake
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
