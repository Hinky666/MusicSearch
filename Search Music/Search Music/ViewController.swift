//
//  ViewController.swift
//  Search Music
//
//  Created by mabookpro4 on 12/10/19.
//  Copyright © 2019 mabookpro4. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var albums = [Album]()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        searchBar.delegate = self as UISearchBarDelegate
        collectionView.delegate = self as UICollectionViewDelegate
        collectionView.dataSource = self as UICollectionViewDataSource
        let indentation = (self.view.bounds.size.width - 300) / 4
        collectionView.contentInset = UIEdgeInsets(top: indentation, left: indentation, bottom: indentation, right: indentation)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "InfoViewController" {
            if let destinationVC = segue.destination as? InfoViewController {
                if let album = sender as? Album {
                    destinationVC.album = album
                    let index = albums.index(where: {$0 === album})
                    let indexPath = IndexPath(row: index!, section: 0)
                    if let cell = collectionView.cellForItem(at: indexPath) as? AlbumCell {
                        destinationVC.image = cell.albumImage.image
                    }
                }
            }
        }
    }
    
}

// MARK: - CollectionView methods

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCell", for: indexPath) as? AlbumCell {
            cell.updateCell(album: albums[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let album = albums[indexPath.row]
        performSegue(withIdentifier: "InfoViewController", sender: album)
        searchBar.resignFirstResponder()
    }
    
}

// MARK: - SearchBar methods

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text != nil || searchBar.text != ""
        {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1)
                {
            DataController.instance.getAlbums(searchRequest: searchBar.text!) { (requestedAlbums) in
                self.albums = requestedAlbums.sorted(by: {$0.collectionName < $1.collectionName})
                DispatchQueue.main.async
                    {
                    self.collectionView.reloadData()
                }
            }
        }
        searchBar.resignFirstResponder()
        }
    }
}

