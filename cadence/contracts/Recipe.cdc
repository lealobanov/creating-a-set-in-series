
import "SetAndSeries"

access(all) contract Recipe {
    access(all)
    struct NFTSetData {

        // Unique ID for the Set
        access(all)
        let setId: UInt32

        // Series ID the Set belongs to
        access(all)
        let seriesId: UInt32

        // Maximum number of editions that can be minted in this Set
        access(all)
        let maxEditions: UInt32
                
        // The JSON metadata for each NFT edition can be stored off-chain on IPFS.
        // This is an optional dictionary of IPFS hashes, which will allow marketplaces
        // to pull the metadata for each NFT edition
        access(self)
        var ipfsMetadataHashes: {UInt32: String}

        // Set level metadata
        // Dictionary of metadata key value pairs
        access(self)
        var metadata: {String: String}
        
        init(
            setId: UInt32,
            seriesId: UInt32,
            maxEditions: UInt32,
            ipfsMetadataHashes: {UInt32: String},
            metadata: {String: String}) {

            self.setId = setId
            self.seriesId = seriesId
            self.maxEditions = maxEditions
            self.metadata = metadata
            self.ipfsMetadataHashes = ipfsMetadataHashes

            emit SetCreated(seriesId: self.seriesId, setId: self.setId)
        }

        access(all)
        view fun getIpfsMetadataHash(editionNum: UInt32): String? {
            return self.ipfsMetadataHashes[editionNum]
        }

        access(all)
        view fun getMetadata(): {String: String} {
            return self.metadata
        }

        access(all)
        view fun getMetadataField(field: String): String? {
            return self.metadata[field]
        }
    }

    access(all)
    resource Series {

        // Unique ID for the Series
        access(all)
        let seriesId: UInt32

        // Array of NFTSets that belong to this Series
        access(self)
        var setIds: [UInt32]

        // Series sealed state
        access(all)
        var seriesSealedState: Bool;

        // Set sealed state
        access(self)
        var setSealedState: {UInt32: Bool};

        // Current number of editions minted per Set
        access(self)
        var numberEditionsMintedPerSet: {UInt32: UInt32}

        init(
            seriesId: UInt32,
            metadata: {String: String}) {

            self.seriesId = seriesId
            self.seriesSealedState = false
            self.numberEditionsMintedPerSet = {}
            self.setIds = []
            self.setSealedState = {}

            SetAndSeries.seriesData[seriesId] = SeriesData(
                    seriesId: seriesId,
                    metadata: metadata
            )      
        }

        access(all)
        fun addNftSet(
            setId: UInt32,
            maxEditions: UInt32,
            ipfsMetadataHashes: {UInt32: String},
            metadata: {String: String}) {
            pre {
                self.setIds.contains(setId) == false: "The Set has already been added to the Series."
            }

            // Create the new Set struct
            var newNFTSet = NFTSetData(
                setId: setId,
                seriesId: self.seriesId,
                maxEditions: maxEditions,
                ipfsMetadataHashes: ipfsMetadataHashes,
                metadata: metadata
            )

            // Add the NFTSet to the array of Sets
            self.setIds.append(setId)

            // Initialize the NFT edition count to zero
            self.numberEditionsMintedPerSet[setId] = 0

            // Store it in the sets mapping field
            SetAndSeries.setData[setId] = newNFTSet

            emit SetCreated(seriesId: self.seriesId, setId: setId)
        }
    }
}