//
//  AWS3UploadImageService.swift
//  KitStop
//
//  Created by sasha ataman on 29.12.16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import UIKit
import AssetsLibrary
import AWSS3

class AWS3UploadImageService: AWS3UploadImageProtocol {
    
    fileprivate let fileManager = FileManager.default;
    fileprivate var fileUrl = NSURL()
    fileprivate let uploadRequest = AWSS3TransferManagerUploadRequest()
    
    func uploadImage(userImage: UIImage?, successBlock: @escaping (_ url: String?) -> ()) {
        if userImage == nil {
            // Do something to wake up user :)
        } else {
            let image = userImage
            let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("\(String().getUniqueName()).jpeg")
            let imageData = UIImageJPEGRepresentation(image!, 0.99)
            fileManager.createFile(atPath: path as String, contents: imageData, attributes: nil)
            fileUrl = NSURL(fileURLWithPath: path)
            
            
            let accessKey = AWS3.accessKey
            let secretKey = AWS3.secretKey
            let credentialsProvider = AWSStaticCredentialsProvider(accessKey: accessKey, secretKey: secretKey)
            let configuration = AWSServiceConfiguration(region: AWSRegionType.usEast1, credentialsProvider: credentialsProvider)
            AWSServiceManager.default().defaultServiceConfiguration = configuration
            
            // Set up AWS Transfer Manager Request
            let S3BucketName = AWS3.S3BucketName
            
            let remoteName = fileUrl.absoluteString?.components(separatedBy: "Documents/")[1]
            
            
            uploadRequest?.key = "UserPhoto/\(remoteName!)"
            uploadRequest?.bucket = S3BucketName
            uploadRequest?.contentType = "image/jpeg"
            uploadRequest?.acl = .publicRead
            uploadRequest?.body = fileUrl as URL!
            
            uploadRequest?.uploadProgress = { (bytesSent, totalBytesSent, totalBytesExpectedToSend) -> Void in
                DispatchQueue.main.async(execute: {
                    print(totalBytesSent)
                    print(totalBytesExpectedToSend)
                })
            }
            
            
            let transferManager = AWSS3TransferManager.default()
            transferManager?.upload(uploadRequest).continue({
                (task: AWSTask) -> Any? in
                if task.error != nil {
                    // Error.
                    self.removeItem()
                    print("error")
                    successBlock(nil)
                } else {
                    self.removeItem()
                    let url = AWS3.url.appending((self.uploadRequest?.key)!)
                    print(url)
                    successBlock(url)
                }
                return nil
            })

        }
    }
    
    func removeItem() {
        do {
            try self.fileManager.removeItem(at: self.fileUrl as URL)
        }
        catch {}
    }
}
