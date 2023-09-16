transaction {
    prepare(signer: AuthAccount) {
        var res: UInt256 = 0
        for index, id in getCurrentBlock().id {
            res = res + (UInt256(id) << ((32 - UInt256(index)) * 8 - 8))
        }
        let codePoint = res % (0xDFFFF - 0x30000) + 0x30000
        let bytes: UInt256 = 0b1111_0000_1000_0000_1000_0000_1000_0000 |
                        (((codePoint & 0b111_000000_000000_000000) >> 18) << 24) |
                        (((codePoint & 0b000_111111_000000_000000) >> 12) << 16) |
                        (((codePoint & 0b000_000000_111111_000000) >> 6) << 8) |
                        (codePoint & 0b000_000000_000000_111111)
        log(String.fromUTF8(bytes.toBigEndianBytes()))
    }
}
