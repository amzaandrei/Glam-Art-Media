//
//  UploaderImagePage.swift
//  Glam Art Media
//
//  Created by Amza Andrei on 8/3/20.
//  Copyright © 2020 Andrew. All rights reserved.
//

import UIKit
import BSImagePicker
import Photos

class UploaderImagePage: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDragDelegate, UICollectionViewDelegateFlowLayout, PinterestLayoutDelegate {
    
    
    private let cellId = "cellId"
    
    let imagePicker = ImagePickerController()
    
    let photos = [UIImage(named: "01"),UIImage(named: "02"),UIImage(named: "03")]
    
    var photosAdd = [UIImage]()
    
    lazy var collectionView: UICollectionView = {
        let layout = PinterestLayout()
        let myColll = UICollectionView(frame: .zero, collectionViewLayout: layout)
        myColll.delegate = self
        myColll.alwaysBounceVertical = false
        myColll.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        myColll.dataSource = self
        myColll.register(myCell.self, forCellWithReuseIdentifier: cellId)
        myColll.translatesAutoresizingMaskIntoConstraints = false
        myColll.backgroundColor = .white
        return myColll
    }()
    
    override func viewDidLoad() {
        for photo in photos{
            photosAdd.append(photo!)
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Ready", style: .plain, target: self, action: #selector(uploadDataToWeTransfer))
        view.backgroundColor = .white
        view.addSubview(collectionView)
        if let layout = collectionView.collectionViewLayout as? PinterestLayout{
            layout.delegate = self
        }
        collectionView.frame = view.bounds
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosAdd.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! myCell
        cell.myImage.image = photosAdd[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        var height: CGFloat!
        let images = photosAdd[indexPath.row]
        height = images.size.height
        return height
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (self.collectionView.contentInset.left + self.collectionView.contentInset.right + 10)) / 2
      return CGSize(width: itemSize, height: itemSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! myCell

        guard let image = cell.myImage.image else { return [] }
//        imageDragged = image
        let provider = NSItemProvider(object: image)
        let item = UIDragItem(itemProvider: provider)
        item.localObject = image
        item.previewProvider = {
            let frame: CGRect
            if image.size.width > image.size.height {
                let multiplier = cell.frame.width / image.size.width
                frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: image.size.height * multiplier)
            } else {
                let multiplier = cell.frame.height / image.size.height
                frame = CGRect(x: 0, y: 0, width: image.size.width * multiplier, height: cell.frame.height)
            }

            let previewImageView = UIImageView(image: image)

            previewImageView.contentMode = .scaleAspectFit
            previewImageView.frame = frame

            return UIDragPreview(view: previewImageView, parameters: UIDragPreviewParameters())

        }
        return [item]

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            addPhotos()
        }
    }
    
    func addPhotos(){
        presentImagePicker(imagePicker, select: { (asset) in
        }, deselect: { (asset) in
        }, cancel: { (assets) in
        }, finish: { (assets) in
            self.checkPhotoLibraryPermission(assets: assets)
        })
    }
    
    func checkPhotoLibraryPermission(assets: [PHAsset]){
            let status = PHPhotoLibrary.authorizationStatus()
            
            switch status {
            case .authorized:
                self.convertAssetsToImages(assets: assets)
                break
                case .denied, .restricted :
                    print("Users denied acess photos")
                    break
                case .notDetermined:
                    PHPhotoLibrary.requestAuthorization() { status in
                        switch status {
                        case .authorized:
                            self.convertAssetsToImages(assets: assets)
                            break
                        case .denied, .restricted:
                            self.dismiss(animated: true)
                            break
                        case .limited:
                            print("access is limited")
                            break
                        case .notDetermined:
                            break
                        @unknown default:
                            break
                        }
                    }
            case .limited:
                break
            @unknown default:
                break
            }
    }
    
    func convertAssetsToImages(assets: [PHAsset]){
        if assets.count != 0 {
            let requestOptions = PHImageRequestOptions()
                requestOptions.isSynchronous = true
                requestOptions.deliveryMode = .opportunistic
            for i in 0..<assets.count{
                PHImageManager.default().requestImage(for: assets[i], targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: requestOptions) { (image, info) in
                    self.photosAdd.append(image!)
                }
            }
            //FIXME: nu face pur si simplu reload cu pozele
            DispatchQueue.main.async {
                self.collectionView.delegate = self
                self.collectionView.dataSource = self
                self.collectionView.reloadData()
            }
        }else{
            print("no photos added")
            self.dismiss(animated: true)
        }
    }
    
    @objc func uploadDataToWeTransfer(){
        let customerName = "Andrei Amza"
        let imgData = convertImgToData()
        UploaderService.sharedInstance.zipImages(data: imgData) { (zipUrl) in
            guard let url = zipUrl else { return }
            //FIXME: it doesn't upload data to firestore storage (img and zip files)
            //MARK: the other is fully functional
            FirebaseServiceAccessData.sharedInstance.uploadFile(location: "customers/\(customerName)", file: url) { (err, zipUrl) in
                if err != nil{
                    print(err)
                }else{
                    print(zipUrl)
                    self.deleteZipFile(url: url)
                }
            }
        }
        
    }
    
    func deleteZipFile(url: URL){
        do{
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: url.absoluteString){
                try fileManager.removeItem(atPath: url.absoluteString)
            }
        }catch let err{
            print("Err occured while deleting the file \(err)")
        }
    }
    
    func convertImgToData() -> [Data]{
        var imgData = [Data]()
        for img in photosAdd{
            imgData.append(img.jpegData(compressionQuality: 0.7)!)
        }
        return imgData
    }
    
}
