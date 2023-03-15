import cv2
import numpy as np

# Load the image
img = cv2.imread('/mnt/d/Personal Projects/python/sampleImage4 - Copy.jpg')

resized_img = cv2.resize(img, (0,0), fx=0.5, fy=0.5)
# resized_img= img
# Convert the image to grayscale
gray = cv2.cvtColor(resized_img, cv2.COLOR_BGR2GRAY)

# Set the block size and stride
block_size = 16
stride = 50

# Calculate the number of blocks in each dimension
h, w = gray.shape
nbh = (h - block_size) // stride + 1
nbw = (w - block_size) // stride + 1

# Initialize the block distances matrix
block_distances = np.zeros((nbh, nbw))

# Compute the block distances
print(nbh, nbw)
for i in range(nbh):
    for j in range(nbw):
        # Extract the block
        y = i * stride
        x = j * stride
        block = gray[y:y+block_size, x:x+block_size].astype(np.float32)
        block -= block.mean()
        block /= block.std(ddof=1)
        
        # Compute the distance between the block and its best match
        min_distance = float('inf')
        for y_ in range(max(0, y-block_size), min(h-block_size, y+block_size-stride)+1):
            for x_ in range(max(0, x-block_size), min(w-block_size, x+block_size-stride)+1):
                if x_ == x and y_ == y:
                    continue
                other_block = gray[y_:y_+block_size, x_:x_+block_size].astype(np.float32)
                other_block -= other_block.mean()
                other_block /= other_block.std(ddof=1)
                distance = np.linalg.norm(block-other_block)
                if distance < min_distance:
                    min_distance = distance
        block_distances[i, j] = min_distance

# Threshold the block distances to get the binary map
binary_map = block_distances < np.mean(block_distances) + 2 * np.std(block_distances)

# Dilate the binary map to group nearby blocks
kernel = np.ones((3, 3), np.uint8)
dilated_map = cv2.dilate(binary_map.astype(np.uint8), kernel)

# Extract the contours from the binary map
contours, hierarchy = cv2.findContours(dilated_map, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

tampered = False
for contour in contours:
    x, y, w, h = cv2.boundingRect(contour)
    cv2.rectangle(img, (x, y), (x+w, y+h), (0, 0, 255), 2)
    tampered = True


# Display whether the image is tampered or not
if tampered:
    print('The image is tampered')
else:
    print('The image is not tampered')