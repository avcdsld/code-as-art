// A gift is not a gift.
//
// This NFT will not emit Withdrawn/Deposited events when using the gift/steal functions, provided the NFT has not been recognized.
// Unless the owner recognizes the NFT themselves, it remains hidden from external viewers.
// Once recognized by the owner, the NFT is no longer considered a gift.
//
import "NonFungibleToken"
import "ViewResolver"
import "MetadataViews"

access(all) contract GiftV2: NonFungibleToken {
    access(all) let CollectionPublicPath: PublicPath
    access(all) let CollectionStoragePath: StoragePath
    access(all) var totalSupply: UInt64
    access(all) var giftThumbnail: {MetadataViews.File}
    access(all) var notGiftThumbnail: {MetadataViews.File}

    access(all) resource NFT: NonFungibleToken.NFT {
        access(all) let id: UInt64
        access(self) var recognition: {Address: Bool}

        init(id: UInt64) {
            self.id = id
            self.recognition = {}
        }

        access(all) fun recognize() {
            self.recognition[self.owner!.address] = true
        }

        access(all) fun forget() {
            self.recognition[self.owner!.address] = false
        }

        access(all) fun isRecognizedBy(_ recognizer: Address): Bool {
            return self.recognition[recognizer] ?? false
        }

        access(all) fun createEmptyCollection(): @{NonFungibleToken.Collection} {
            return <- GiftV2.createEmptyCollection(nftType: Type<@GiftV2.NFT>())
        }

        access(all) view fun getViews(): [Type] {
            return [
                Type<MetadataViews.Display>()
            ]
        }

        access(all) fun resolveView(_ view: Type): AnyStruct? {
            switch view {
                case Type<MetadataViews.Display>():
                    return MetadataViews.Display(
                        name: (!self.isRecognizedBy(self.owner!.address) ? "Gift #" : "NOT Gift #").concat(self.id.toString()),
                        description: !self.isRecognizedBy(self.owner!.address) ? "This is a gift." : "This is NOT a gift.",
                        thumbnail: !self.isRecognizedBy(self.owner!.address) ? GiftV2.giftThumbnail : GiftV2.notGiftThumbnail,
                    )
            }
            return nil
        }
    }

    access(all) resource interface GiftCollectionPublic {
        access(all) fun deposit(token: @{NonFungibleToken.NFT})
        access(all) fun gift(token: @{NonFungibleToken.NFT})
        access(all) view fun getIDs(): [UInt64]
        access(all) view fun getLength(): Int
        access(all) view fun borrowNFT(_ id: UInt64): &{NonFungibleToken.NFT}?
        access(all) view fun borrowGift(_ id: UInt64): &GiftV2.NFT? {
            post {
                (result == nil) || (result?.id == id): "Cannot borrow Gift reference"
            }
        }
    }

    access(all) resource Collection: GiftCollectionPublic, NonFungibleToken.Collection {
        access(all) var ownedNFTs: @{UInt64: {NonFungibleToken.NFT}}

        init () {
            self.ownedNFTs <- {}
        }

        access(all) view fun getSupportedNFTTypes(): {Type: Bool} {
            let supportedTypes: {Type: Bool} = {}
            supportedTypes[Type<@GiftV2.NFT>()] = true
            return supportedTypes
        }

        access(all) view fun isSupportedNFTType(type: Type): Bool {
            return type == Type<@GiftV2.NFT>()
        }

        access(NonFungibleToken.Withdraw) fun withdraw(withdrawID: UInt64): @{NonFungibleToken.NFT} {
            let token <- self.ownedNFTs.remove(key: withdrawID) ?? panic("Missing NFT")
            let tokenRef = (&token as &{NonFungibleToken.NFT}) as! &GiftV2.NFT
            assert(tokenRef.isRecognizedBy(self.owner!.address), message: "This is a gift.")
            return <- token
        }

        access(all) fun deposit(token: @{NonFungibleToken.NFT}) {
            let id: UInt64 = token.id
            let tokenRef = (&token as &{NonFungibleToken.NFT}) as! &GiftV2.NFT
            assert(tokenRef.isRecognizedBy(self.owner!.address), message: "This is a gift.")
            self.ownedNFTs[id] <-! token
        }

        access(all) fun steal(id: UInt64): @{NonFungibleToken.NFT} {
            let token <- self.ownedNFTs.remove(key: id) ?? panic("Missing NFT")
            let tokenRef = (&token as &{NonFungibleToken.NFT}) as! &GiftV2.NFT
            assert(!tokenRef.isRecognizedBy(self.owner!.address), message: "This is NOT a gift.")
            return <- token
        }

        access(all) fun gift(token: @{NonFungibleToken.NFT}) {
            let id: UInt64 = token.id
            let tokenRef = (&token as &{NonFungibleToken.NFT}) as! &GiftV2.NFT
            assert(!tokenRef.isRecognizedBy(self.owner!.address), message: "This is NOT a gift.")
            self.ownedNFTs[id] <-! token
        }

        access(all) view fun getIDs(): [UInt64] {
            return self.ownedNFTs.keys
        }

        access(all) view fun getLength(): Int {
            return self.ownedNFTs.length
        }

        access(all) view fun borrowNFT(_ id: UInt64): &{NonFungibleToken.NFT}? {
            return &self.ownedNFTs[id] as &{NonFungibleToken.NFT}?
        }

        access(all) view fun borrowGift(_ id: UInt64): &GiftV2.NFT? {
            if self.ownedNFTs[id] != nil {
                return (&self.ownedNFTs[id] as &{NonFungibleToken.NFT}?) as! &GiftV2.NFT?
            }
            return nil
        }

        access(all) view fun borrowViewResolver(id: UInt64): &{ViewResolver.Resolver}? {
            if let nft = &self.ownedNFTs[id] as &{NonFungibleToken.NFT}? {
                return nft as &{ViewResolver.Resolver}
            }
            return nil
        }

        access(all) fun createEmptyCollection(): @{NonFungibleToken.Collection} {
            return <- GiftV2.createEmptyCollection(nftType: Type<@GiftV2.NFT>())
        }
    }

    access(all) resource Maintainer {
        access(all) fun setThumbnail(giftThumbnail: {MetadataViews.File}, notGiftThumbnail: {MetadataViews.File}) {
            GiftV2.giftThumbnail = giftThumbnail
            GiftV2.notGiftThumbnail = notGiftThumbnail
        }
    }

    access(all) fun createEmptyCollection(nftType: Type): @{NonFungibleToken.Collection} {
        return <- create Collection()
    }

    access(all) view fun getContractViews(resourceType: Type?): [Type] {
        return []
    }

    access(all) view fun resolveContractView(resourceType: Type?, viewType: Type): AnyStruct? {
        return nil
    }

    access(all) fun mintNFT(): @NFT {
        GiftV2.totalSupply = GiftV2.totalSupply + 1
        return <- create NFT(id: GiftV2.totalSupply)
    }

    init() {
        self.CollectionPublicPath = /public/GiftV2Collection
        self.CollectionStoragePath = /storage/GiftV2Collection
        self.totalSupply = 0
        self.giftThumbnail = MetadataViews.HTTPFile(url: "https://nftstorage.link/ipfs/bafkreicmoh2ummsp4qgyp6fvk7lj7uy44jmnymhl6v75h5bbexf5i6njdm")
        self.notGiftThumbnail = MetadataViews.HTTPFile(url: "https://nftstorage.link/ipfs/bafkreiftdj3uj25a4tdnofc3ht6ir2pftwbn2dvtxsajj3rzkrsbdvkkqi")
        self.account.storage.save(<- create Maintainer(), to: /storage/GiftV2Maintainer)
        self.account.storage.save(<- create Collection(), to: self.CollectionStoragePath)
        let cap = self.account.capabilities.storage.issue<&GiftV2.Collection>(self.CollectionStoragePath)
        self.account.capabilities.publish(cap, at: self.CollectionPublicPath)
    }
}
