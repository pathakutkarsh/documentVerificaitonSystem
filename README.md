# Document Verification System

## Overview

The **Document Verification System** enhances document authenticity and security by combining image analysis, QR code validation, and robust backend technologies. Users can verify their documents using a mobile app, which captures document images and processes them through various layers of verification.

## Key Components

1. **Image Splicing Detection:**
   - Detects image splicing or manipulation within the document.
   - Utilizes edge detection, histogram analysis, and template matching.
   - Flags anomalies for further investigation.

2. **Copy-Move Detection:**
   - Identifies duplicated regions within the document.
   - Compares local image patches to find similarities.
   - Prevents fraud by detecting copied content.

3. **QR Code Validation:**
   - Extracts QR codes (if present) from document images.
   - Decodes QR code data to retrieve relevant information.
   - Validates data against predefined rules.

4. **Technologies Used:**
   - **Python:**
     - Implements core image processing algorithms.
     - Utilizes OpenCV, NumPy, and Pillow.
   - **Flutter:**
     - Builds the mobile app interface for document capture.
   - **Node.js:**
     - Serves as middleware between mobile app and backend.
     - Handles requests and communicates with the database.
   - **Supabase:**
     - Stores document metadata securely.
   - **Firebase Authentication:**
     - Ensures secure user access.

## Workflow

1. **Document Capture:**
   - Users capture document images using the Flutter mobile app.
   - Images are sent to the backend for processing.

2. **Image Processing:**
   - Backend processes images using splicing and copy-move detection.
   - Detected anomalies are flagged.

3. **QR Code Extraction and Validation:**
   - Extracts QR codes from document images.
   - Validates decoded data against rules.
   - Provides additional confidence in document authenticity.

4. **Database Interaction:**
   - Stores document metadata in Supabase.
   - Records timestamps for submission tracking.

5. **User Feedback:**
   - Mobile app displays verification results.
   - Authentic documents are marked as valid.

## Benefits

- **Enhanced Security:**
  - Combining image analysis and QR code validation prevents forgery.
- **User-Friendly Experience:**
  - Users verify documents easily using their smartphones.
  - Real-time feedback ensures a seamless process.
- **Scalability:**
  - Supabase scales efficiently as user base grows.
  - Firebase authentication ensures security.

---

## To run the python module
```cd python```
## provide the file path to the main function
The file should be of format .png,.jpg,.jpeg etc.
```python main.py 'your/file/path' ```

# To run the nodejs code

1. run npm install
2. run nodemon server.js 


