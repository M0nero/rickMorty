//
//  CharactersListViewModel.swift
//  RickAndMorty
//
//  Created by Damir Akbarov on 21.08.2023.
//

import Foundation

final class CharactersListViewModel: ViewModel {
    // MARK: - Service
    private let service: MainServiceProtocol
    
    // MARK: - Properties
    let charactersData = DataListProperty<ResultItem>([])
    let characters = DataListProperty<Result>([])
    let reloadViewCommand = Command()
    
    // MARK: - Private Properties
    private let page = DataProperty<Int>(1)
    private let totalPages = DataProperty<Int>(2)
    
    // MARK: - Navigation properties
    let showCharacterCommand = TCommand<Result>()
    
    // MARK: - Init
    init(_ service: MainServiceProtocol) {
        self.service = service
    }
    
    // MARK: - Public methods
    func initialize() {
        title.value = text.title
        getData()
    }
    
    func getData() {
        service.getList(page: 1)
            .sink { [weak self] completion in
                guard let error = try? completion.error().localizedDescription else { return }
                self?.showConfirmAlert(message: error)
            } receiveValue: { [weak self] wrapper in
                self?.totalPages.value = wrapper.info.pages
                self?.characters.value = wrapper.results
                self?.appendCharactersData(wrapper.results)
            }
            .store(in: &cancellables)
    }
    
    func getNextData() {
        guard totalPages.value >= page.value + 1 else { return }
        page.value += 1
        service.getList(page: page.value)
            .sink { [weak self] completion in
                guard let error = try? completion.error().localizedDescription else { return }
                self?.showConfirmAlert(message: error)
            } receiveValue: { [weak self] wrapper in
                self?.characters.value += wrapper.results
                self?.appendCharactersData(wrapper.results)
            }
            .store(in: &cancellables)
    }
    
    func resetPage() {
        totalPages.value = 2
        page.value = 1
        characters.value = []
        charactersData.value = []
    }
    
    func showCharacter(by id: Int) {
        guard let character = characters.value.first(where: { $0.id == id }) else { return }
        showCharacterCommand.call(character)
    }
    
    func getItem(by indexPath: IndexPath) -> ResultItem {
        return charactersData.value[indexPath.row]
    }
    
    // MARK: - Private methods
    private func appendCharactersData(_ characters: [Result]) {
        let newItems = characters.map { character -> ResultItem in
            return ResultItem(id: character.id, title: character.name, imageUrl: character.image)
        }
        
        charactersData.value.append(contentsOf: newItems)
    }
}

// MARK: - Resources
private extension TextConstants {
    var title: String { "Characters" }
}
