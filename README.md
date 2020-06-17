
# WORK IN PROGRESS
# `XTerraPacket`
  Terraria Packet Library

 ## Usage
 Brief example using SwiftNIO for now... You can also look at [TerraProxy-CLI](https://github.com/Xenoxiluna/TerraProxy-CLI) for inspiration/uses.
```swift
let packetData = bb.getBytes(at: 0, length: bb.readableBytes)!
guard var packet = try? TerrariaPacketFactory.decodePacket(packet: packetData) else {
    print("Parse failed!")
    print("Failed bytes: \(packetData))")
    channel.writeAndFlush(NIOAny.init(bb), promise: nil)
    return
}

print("Swift Packet type: \(type(of: packet))")
print("Packet Type: \(packet.getType())")

do{
    try packet.decode()
    print("Decoded Packet Bytes: \(packet.bytes))")
}catch{
    print("Decode failed...")
    print("Failed Packet Bytes: \(packet.bytes))")
    return
}

switch packet.getType(){
case TerrariaPacketType.ConnectApproval:
    let appPacket = packet as! PacketConnectApproval
    connection.setPlayerId(playerId: Int(appPacket.playerId))
default:
    print("")
}
```
 
 ## Dependencies

- [SwiftyBytes 0.2.3](https://github.com/Xenoxiluna/SwiftyBytes)

 ## License

 `XTerraPacket` is licensed under the [MIT License](LICENSE)
