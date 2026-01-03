# Misskey API Integration Guide

This document outlines how to integrate with the Misskey API to access cloud storage (Drive) features.

## API Basics
- **Protocol**: HTTP POST
- **Base URL**: `https://{instance_url}/api/`
- **Content-Type**: `application/json` (except for file uploads)
- **Authentication**: Include your Access Token in the request body as the parameter `i`.

## 1. Obtain Cloud Storage Information
To get information about the user's drive capacity and current usage.

- **Endpoint**: `/api/drive`
- **Method**: `POST`
- **Request Body**:
  ```json
  {
    "i": "YOUR_ACCESS_TOKEN"
  }
  ```
- **Response**:
  ```json
  {
    "capacity": 1073741824, // Total capacity in bytes
    "usage": 5242880        // Used space in bytes
  }
  ```

## 2. Browse Drive Content
### List Files
- **Endpoint**: `/api/drive/files`
- **Method**: `POST`
- **Request Body** (Optional parameters):
  ```json
  {
    "i": "YOUR_ACCESS_TOKEN",
    "limit": 20,       // Max 100
    "sinceId": null,   // Pagination
    "untilId": null,   // Pagination
    "folderId": null,  // null for root, or specific folder ID
    "type": null       // Filter by MIME type prefix (e.g., "image")
  }
  ```

### List Folders
- **Endpoint**: `/api/drive/folders`
- **Method**: `POST`
- **Request Body**:
  ```json
  {
    "i": "YOUR_ACCESS_TOKEN",
    "limit": 20,
    "folderId": null
  }
  ```

## 3. File Operations
### Upload File
- **Endpoint**: `/api/drive/files/create`
- **Method**: `POST`
- **Content-Type**: `multipart/form-data`
- **Parameters**:
  - `i`: Access Token
  - `file`: The file binary data
  - `folderId`: (Optional) ID of the folder to upload to
  - `name`: (Optional) Filename
  - `isSensitive`: (Optional) Boolean

### Create Folder
- **Endpoint**: `/api/drive/folders/create`
- **Method**: `POST`
- **Request Body**:
  ```json
  {
    "i": "YOUR_ACCESS_TOKEN",
    "name": "New Folder",
    "parentId": null
  }
  ```

## Integration Strategy for OneShare

1.  **Authentication**:
    *   Allow user to input **Instance URL** (e.g., `misskey.io`) and **Access Token**.
    *   Store these securely in `SettingsModel` or a new `AccountModel`.

2.  **Validation & Storage Info**:
    *   Call `/api/drive` upon adding the account to verify the token and fetch initial storage usage.
    *   Display "Used: X / Total: Y" in the UI.

3.  **Browsing**:
    *   Implement a file browser interface that starts at the root (`folderId: null`).
    *   Fetch folders (`/api/drive/folders`) and files (`/api/drive/files`) in parallel or sequentially to populate the view.
    *   Handle pagination using `untilId` (cursor based).

4.  **Transfer**:
    *   **Upload**: Use `multipart/form-data` to post to `/api/drive/files/create`.
    *   **Download**: The file object returned by `drive/files` contains a `url` field. Use standard HTTP GET to download.

## References
- [Misskey Hub API Documentation](https://misskey-hub.net/en/docs/api/)
- [Misskey Endpoints (Community List)](https://misskey-hub.net/en/docs/api/endpoints.html)
