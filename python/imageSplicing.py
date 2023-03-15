import cv2
import numpy as np

def imageSplicing(inputImagePath):
    # Load the image
    img = cv2.imread(inputImagePath)
    # Convert the image to grayscale
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

    # Split the image into two halves
    half = gray.shape[1] // 2
    left = gray[:, :half]
    right = gray[:, half:]

    # Compute the mean and standard deviation of each half
    mean_left, std_left = cv2.meanStdDev(left)
    mean_right, std_right = cv2.meanStdDev(right)

    # Compute the absolute difference between the means and standard deviations
    mean_diff = np.abs(mean_left - mean_right)
    std_diff = np.abs(std_left - std_right)

    # Compute the mean and standard deviation of the differences
    mean_diff_mean, mean_diff_std = cv2.meanStdDev(mean_diff)
    std_diff_mean, std_diff_std = cv2.meanStdDev(std_diff)

    # Determine if the image is spliced or not based on the threshold values
    is_spliced = mean_diff_mean > 5 or std_diff_mean > 5
    # Print the result
    if (is_spliced):
        print('The image is Tampered')
    else:
        print('The image is not Tampered')

# imageSplicing("/mnt/d/Personal Projects/python/sample9E.png")