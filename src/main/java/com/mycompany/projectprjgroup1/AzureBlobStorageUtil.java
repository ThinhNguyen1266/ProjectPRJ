/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.projectprjgroup1;

import com.azure.storage.blob.BlobClient;
import com.azure.storage.blob.BlobContainerClient;
import com.azure.storage.blob.BlobServiceClient;
import com.azure.storage.blob.BlobServiceClientBuilder;
import java.io.File;
import java.io.IOException;

/**
 *
 * @author Thinh
 */
public class AzureBlobStorageUtil {

    private String connectionString = "9EczHEQP650WEWT7uMSu3Ytj/yGN3kPRdo4wxFxtSoR7rVzpVlVxgf8RbS2afTE3/AjHNIhfNrCb+AStdqCk1w==";
    private String containerName = "pics";

    public String uploadImage(String imagePath, String blobName) throws IOException {
        BlobServiceClient blobServiceClient = new BlobServiceClientBuilder().connectionString(connectionString).buildClient();
        BlobContainerClient containerClient = blobServiceClient.getBlobContainerClient(containerName);
        BlobClient blobClient = containerClient.getBlobClient(blobName);

        File file = new File(imagePath);
        blobClient.uploadFromFile(file.getPath());

        // Trả về URL của blob
        return blobClient.getBlobUrl();
    }

    public String getBlobUrl(String blobName) {
        BlobServiceClient blobServiceClient = new BlobServiceClientBuilder().connectionString(connectionString).buildClient();
        BlobContainerClient containerClient = blobServiceClient.getBlobContainerClient(containerName);
        BlobClient blobClient = containerClient.getBlobClient(blobName);

        return blobClient.getBlobUrl();
    }
}
