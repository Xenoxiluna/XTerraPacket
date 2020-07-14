import XCTest
@testable import XTerraPacket

final class XTerraPacketTests: XCTestCase {
    func testConnectRequest() {
        let pbytes: [UInt8] = [15, 0, 1, 11, 84, 101, 114, 114, 97, 114, 105, 97, 50, 51, 48]
        guard let packet = try? TerrariaPacketFactory.decodePacket(packet: pbytes) else { return }
        var newpacket = packet as! PacketConnectRequest
        do{
            try newpacket.decodePayload()
        }catch {}
        XCTAssertEqual(packet.getType(), TerrariaPacketType.ConnectRequest)
        XCTAssertEqual(newpacket.version, "Terraria230")
    }

    func testPlayerInfo() {
        let pbytes: [UInt8] = [39, 0, 4, 3, 0, 0, 5, 98, 111, 105, 105, 51, 0, 0, 0, 0, 215, 90, 55, 255, 125, 90, 105, 90, 75, 175, 165, 140, 160, 180, 215, 255, 230, 175, 160, 105, 60, 0, 0]
        guard let packet = try? TerrariaPacketFactory.decodePacket(packet: pbytes) else { return }
        var newpacket = packet as! PacketPlayerInfo
        do{
            try newpacket.decodePayload()
        }catch {}
        XCTAssertEqual(packet.getType(), TerrariaPacketType.PlayerInfo)
        XCTAssertEqual(newpacket.name, "\u{5}boii3")
        
        newpacket.name = "Boi4"
        do{
            try newpacket.encode()
            try newpacket.decodePayload()
        }catch {}
        XCTAssertEqual(newpacket.name, "\u{4}Boi4")
    }
    
    func testPasswordSend(){
        let pbytes: [UInt8] = [9, 0, 38, 5, 108, 111, 108, 112, 108]
        guard let packet = try? TerrariaPacketFactory.decodePacket(packet: pbytes) else { return }
        var newpacket = packet as! PacketPasswordSend
        do{
            try newpacket.decodePayload()
        }catch {}
        XCTAssertEqual(packet.getType(), TerrariaPacketType.PasswordSend)
        XCTAssertEqual(newpacket.password, "\u{5}lolpl")
    }
    
    func testLoadNetModule(){
        let pbytes: [UInt8] = [12, 0, 82, 6, 0, 14, 0, 0, 0, 0, 0, 63]
        guard let packet = try? TerrariaPacketFactory.decodePacket(packet: pbytes) else { return }
        var newpacket = packet as! PacketLoadNetModule
        do{
            try newpacket.decode()
        }catch {}
        XCTAssertEqual(packet.getType(), TerrariaPacketType.LoadNetModule)
        XCTAssertEqual(newpacket.command, PacketLoadNetModule.CommandType.Say)
        XCTAssertEqual(newpacket.netModuleId, 6)
    }
    
    func testPlayerUpdate(){
        let pbytes: [UInt8] = [25, 0, 13, 0, 104, 20, 0, 0, 0, 114, 165, 133, 71, 0, 48, 213, 69, 84, 225, 107, 64, 0, 0, 0, 0]
        guard let packet = try? TerrariaPacketFactory.decodePacket(packet: pbytes) else { return }
        var newpacket = packet as! PacketPlayerUpdate
        do{
            try newpacket.decode()
        }catch {}
        XCTAssertEqual(packet.getType(), TerrariaPacketType.PlayerUpdate)
        XCTAssertEqual(newpacket.positionY, 4.6667764e-10)
    }
    
    static var allTests = [
        ("testConnectRequest", testConnectRequest),
        ("testPlayerInfo", testPlayerInfo),
        ("testPasswordSend", testPasswordSend),
        ("testLoadNetModule", testLoadNetModule),
    ]
}
