#Working
#threshold for tampered = 100, nontampered 500
import cv2

gray = cv2.imread('/content/result.jpg')
img = cv2.cvtColor(gray, cv2.COLOR_BGR2GRAY)
gray = cv2.cvtColor(gray, cv2.COLOR_BGR2GRAY)
gray = cv2.equalizeHist(gray)
img = cv2.cvtColor(gray, cv2.COLOR_GRAY2BGR)

img = cv2.GaussianBlur(img, (5, 5), 0)
img = cv2.resize(img, (0,0), fx=0.5, fy=0.5)

sift = cv2.xfeatures2d.SIFT_create()

kp, des = sift.detectAndCompute(img, None)

flann = cv2.FlannBasedMatcher()

# Match descriptors
matches = flann.knnMatch(des, des, k=2)

good_matches = []
for m,n in matches:
    if m.distance < 0.7*n.distance:
        good_matches.append(m)

num_keypoints = len(kp)
if num_keypoints > 0:
    num_good_matches = len(good_matches)
    percentage_good_matches = num_good_matches / num_keypoints * 100

    
    threshold = 500
    if percentage_good_matches > threshold:
        print("Image is likely to have been Tampered")
    else:
        print("Image is not likely to have been tampered")
else:
    print("No keypoints detected in the image")