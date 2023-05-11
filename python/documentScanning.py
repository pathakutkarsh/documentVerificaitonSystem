import cv2 as cv2
import numpy as np

def scan(inputImage,resizeLimit=1080,morphologyIteration=6, cannyUpperThreshold=200):
    # Resize image to workable size
    imageSizeLimit = resizeLimit
    # scalingFactor=0
    maxInputImageSize = max(inputImage.shape)
    if maxInputImageSize > imageSizeLimit:
        scalingFactor = imageSizeLimit / maxInputImageSize
        inputImage = cv2.resize(inputImage, None, fx=scalingFactor, fy=scalingFactor)
    # Copy of resized original image for later use
    resizedInputImageCopy = inputImage.copy()
    # Repeated Closing operation to remove text from the document.
    # cv2.imwrite("scale.png", inputImage)
    kernel = np.ones((5, 5), np.uint8)
    inputImage = cv2.morphologyEx(inputImage, cv2.MORPH_CLOSE, kernel, iterations=morphologyIteration)
    # cv2.imwrite("Morphology.png", inputImage)

    # GrabCut
    mask = np.zeros(inputImage.shape[:2], np.uint8)
    bgdModel = np.zeros((1, 65), np.float64)
    fgdModel = np.zeros((1, 65), np.float64)
    rect = (20, 20, inputImage.shape[1] - 10, inputImage.shape[0] - 10)
    cv2.grabCut(inputImage, mask, rect, bgdModel, fgdModel, 3, cv2.GC_INIT_WITH_RECT)
    mask2 = np.where((mask == 2) | (mask == 0), 0, 1).astype('uint8')
    inputImage = inputImage * mask2[:, :, np.newaxis]
    cv2.grabCut(inputImage, mask, rect, bgdModel, fgdModel, 3, cv2.GC_INIT_WITH_RECT)
    gray = cv2.cvtColor(inputImage, cv2.COLOR_BGR2GRAY)
    gray = cv2.GaussianBlur(gray, (11, 11), 1)
    # cv2.imwrite("gray.png", gray)
    # Edge Detection.
    canny = cv2.Canny(gray, 0, cannyUpperThreshold)
    canny = cv2.dilate(canny, cv2.getStructuringElement(cv2.MORPH_ELLIPSE, (5, 5)))
    # cv2.imwrite("canny.png", canny)
    # Finding contours for the detected edges.
    contours, hierarchy = cv2.findContours(canny, cv2.RETR_LIST, cv2.CHAIN_APPROX_NONE)
    # Keeping only the largest detected contour.
    page = sorted(contours, key=cv2.contourArea, reverse=True)[:5]
 
    # Detecting Edges through Contour approximation.
    # Loop over the contours.
    if len(page) == 0:
        return resizedInputImageCopy
    for c in page:
        # Approximate the contour.
        epsilon = 0.02 * cv2.arcLength(c, True)
        corners = cv2.approxPolyDP(c, epsilon, True)
        # If our approximated contour has four points.
        if len(corners) == 4:
            break
    # Sorting the corners and converting them to desired shape.
    corners = sorted(np.concatenate(corners).tolist())
    # For 4 corner points being detected.
    corners = order_points(corners)
 
    destination_corners = find_dest(corners)
 
    # h, w = inputImageCopy.shape[:2]
    # Getting the homography.
    M = cv2.getPerspectiveTransform(np.float32(corners), np.float32(destination_corners))
    # Perspective transform using homography.
    finalImage = cv2.warpPerspective(resizedInputImageCopy, M, (destination_corners[2][0], destination_corners[2][1]),
                                flags=cv2.INTER_LINEAR)
    return finalImage



def order_points(pts):
    '''Rearrange coordinates to order:
      top-left, top-right, bottom-right, bottom-left'''
    rect = np.zeros((4, 2), dtype='float32')
    pts = np.array(pts)
    s = pts.sum(axis=1)
    # Top-left point will have the smallest sum.
    rect[0] = pts[np.argmin(s)]
    # Bottom-right point will have the largest sum.
    rect[2] = pts[np.argmax(s)]
 
    diff = np.diff(pts, axis=1)
    # Top-right point will have the smallest difference.
    rect[1] = pts[np.argmin(diff)]
    # Bottom-left will have the largest difference.
    rect[3] = pts[np.argmax(diff)]
    # Return the ordered coordinates.
    return rect.astype('int').tolist()

def find_dest(pts):
    (tl, tr, br, bl) = pts
    # Finding the maximum width.
    widthA = np.sqrt(((br[0] - bl[0]) ** 2) + ((br[1] - bl[1]) ** 2))
    widthB = np.sqrt(((tr[0] - tl[0]) ** 2) + ((tr[1] - tl[1]) ** 2))
    maxWidth = max(int(widthA), int(widthB))
 
    # Finding the maximum height.
    heightA = np.sqrt(((tr[0] - br[0]) ** 2) + ((tr[1] - br[1]) ** 2))
    heightB = np.sqrt(((tl[0] - bl[0]) ** 2) + ((tl[1] - bl[1]) ** 2))
    maxHeight = max(int(heightA), int(heightB))
    # Final destination co-ordinates.
    destination_corners = [[0, 0], [maxWidth, 0], [maxWidth, maxHeight], [0, maxHeight]]
 
    return order_points(destination_corners)


# scan(cv2.imread('/mnt/d/Personal Projects/python/sample6.jpg'))

# for increasing the output resolution and decreasing the time need to make copy of original without resizing and
# change coordinates based on the change in resolution. 