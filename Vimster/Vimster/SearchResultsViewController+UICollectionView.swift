//
//  SearchResultsViewController+UICollectionView.swift
//  Vimster
//
//  Created by Alex Song on 2/15/17.
//  Copyright © 2017 LexCorp. All rights reserved.
//

import UIKit

extension SearchResultsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = calcHeightByAspectRatio(ratioWidth: 16, ratioHeight: 9, width: width)
        return CGSize(width: collectionView.bounds.width - 20, height: height)
    }
    
}

extension SearchResultsViewController: UICollectionViewDelegate {}

extension SearchResultsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCell", for: indexPath) as! VideoCell
        if let title = self.videos?[indexPath.row].name, let videoEmbedHTML = self.videos?[indexPath.row].embedHTML {
            cell.videoTitle.text = title
            let url = URL(string: "https://")!
            cell.webView.loadHTMLString(videoEmbedHTML as String, baseURL:url)
            cell.webView.contentMode = .scaleAspectFill
            
        }
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return VimsterConstants.SearchCategory.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let videos = videos {
            return videos.count
        } else {
            return VimsterConstants.SearchCategory.numberOfItems
        }
    }
    
}
