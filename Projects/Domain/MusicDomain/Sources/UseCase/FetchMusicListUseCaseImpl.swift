import ConcurrencyUtil
import LinkPresentation
import MusicDomainInterface

struct FetchMusicListUseCaseImpl: FetchMusicListUseCase {
    private let musicRepository: any MusicRepository

    init(musicRepository: any MusicRepository) {
        self.musicRepository = musicRepository
    }

    func callAsFunction(date: String) async throws -> [MusicModel] {
        try await musicRepository.fetchMusicList(date: date)
            .concurrentMap { try await $0.toModel() }
    }
}

private extension MusicEntity {
    func toModel() async throws -> MusicModel {
        let emptyModel = MusicModel(
            id: id,
            url: url,
            title: nil,
            thumbnailUIImage: nil,
            username: username,
            createdTime: createdTime,
            stuNum: stuNum
        )
        let provider = LPMetadataProvider()
        guard let url = URL(string: url) else {
            return emptyModel
        }
        return try await withCheckedThrowingContinuation({ continuation in
            provider.startFetchingMetadata(for: url) { metadata, error in
                if error != nil {
                    continuation.resume(returning: emptyModel)
                    return
                }

                guard let metadata else {
                    continuation.resume(returning: emptyModel)
                    return
                }

                metadata.imageProvider?.loadObject(
                    ofClass: UIImage.self,
                    completionHandler: { image, error in
                        if error != nil {
                            continuation.resume(returning: emptyModel)
                            return
                        }
                        if let image = image as? UIImage {
                            let model = MusicModel(
                                id: id,
                                url: self.url,
                                title: metadata.title,
                                thumbnailUIImage: image,
                                username: username,
                                createdTime: createdTime,
                                stuNum: stuNum
                            )
                            continuation.resume(returning: model)
                            return
                        }
                        continuation.resume(returning: emptyModel)
                        return
                    }
                )
            }
        })
    }
}
