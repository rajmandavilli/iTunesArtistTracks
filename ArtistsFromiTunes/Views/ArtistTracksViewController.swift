//
//  ArtistTracksViewController.swift
//  ArtistsFromiTunes
//
//  Created by Raj Mandavilli on 3/23/21.
//

import UIKit
import Combine

class ArtistTracksViewController: UIViewController {

    @IBOutlet weak var tracksTableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var artistNameTextField: UITextField!
    
    let viewModel = ArtistTracksViewModel()
    private let trackTableViewCellIdentifier = "TrackTableViewCell"
    
    private var cancellables: Set<AnyCancellable> = []
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.$tracks
            .sink { [weak self] _ in
                self?.updateUI()
            }
            .store(in: &cancellables)
    }

    private func updateUI() {
        DispatchQueue.main.async {
            self.activityIndicatorView(isDisplayed: false)
            self.tracksTableView.reloadData()
        }
    }
    
    private func activityIndicatorView(isDisplayed: Bool) {
        self.activityIndicatorView.isHidden = !isDisplayed
        if self.activityIndicatorView.isHidden {
            self.activityIndicatorView.stopAnimating()
        } else {
            self.activityIndicatorView.startAnimating()
        }
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        guard let artistName = artistNameTextField.text else {
            return
        }
        activityIndicatorView(isDisplayed: true)
        viewModel.fetchTracksForArtist(artistName)
    }
}

extension ArtistTracksViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfTracks()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: trackTableViewCellIdentifier, for: indexPath) as! TrackTableViewCell
        cell.configure(viewModel.tracks[indexPath.row])
        return cell
    }

}
