import SetAndSeries from 0x01

transaction {

    let adminCheck: auth(Storage, Capabilities) &SetAndSeries.Admin
    let seriesRef: &SetAndSeries.Series

    prepare(acct: auth(Storage, Capabilities) &Account) {
        self.adminCheck = acct.capabilities.storage.borrow<&SetAndSeries.Admin>(
            from: SetAndSeries.AdminStoragePath
        ) ?? panic("Could not borrow admin reference")

        self.seriesRef = self.adminCheck.borrowSeries(seriesId: 1)
    }

    execute {
        self.seriesRef.addNftSet(
            setId: 1, 
            maxEditions: 5, 
            ipfsMetadataHashes: {}, 
            metadata: {"Rookie": "2004"}
        )
        log("Set added")
    }
}
