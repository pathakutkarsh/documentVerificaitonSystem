import numpy as np
import cv2
import re
import pytesseract
from pyzbar.pyzbar import decode
import pyzbar.pyzbar as pyzbar
from PIL import Image as im

path=11

# OPTICAL CHARACTER RECOGNITION
def OCR(image):
  pytesseract.pytesseract.tesseract_cmd = 'C:\\Program Files\\Tesseract-OCR\\tesseract.exe'
  extractedInformation = pytesseract.image_to_string(image)
  return extractedInformation



#BARCODE SCANNING#
def barcodescan(image):
  gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
  _, thresh = cv2.threshold(gray, 120, 255, cv2.THRESH_BINARY_INV + cv2.THRESH_OTSU)
  kernel = np.ones((3, 3), np.uint8)
  thresh = cv2.dilate(thresh,kernel,iterations=4)
  contours, _ = cv2.findContours(thresh, cv2.RETR_LIST, cv2.CHAIN_APPROX_SIMPLE)
  bboxes = []
  for cnt in contours:
    area = cv2.contourArea(cnt)
    xmin,ymin,width,height = cv2.boundingRect(cnt)
    extent = area / (width * height)
    ar = float(width)/(height)
    if (extent > np.pi / 4) and (area > 1500):
      bboxes.append((xmin, ymin, xmin + width, ymin + height))
  #print(bboxes)
  qrs = []
  info = set()
  for xmin, ymin, xmax, ymax in bboxes:
    roi = image[ymin:ymax, xmin:xmax]
    data = im.fromarray(roi)
    data.save('my.png')
    img = cv2.imread('my.png')
    detectedBarcodes = decode(img)
    if not detectedBarcodes:
        print("" ,end="")
    for barcode in detectedBarcodes:
      (x, y, w, h) = barcode.rect
      cv2.rectangle(img, (x-10, y-10),
              (x + w+10, y + h+10),
              (255, 0, 0), 2)
      if barcode.data!="":
            return barcode.data


# VALIDATION OF TEXT
if(path==12):
  def Validation(imageFilePath):
    image = cv2.imread(imageFilePath) 
    x=[]
    barcodeResults=(str(barcodescan(image)))
    barcodeResults=barcodeResults.lower()
    ls=barcodeResults.split()
    ocrResults= OCR(image)
    ocrResults=ocrResults.lower()
    ls2=ocrResults.split()
    print(ls)
    print(ls2)
    ls.pop(0)
    ls.pop(len(ls)-1)
    flag=0
    for i in ls:
      for j in ls2:
        if i==j:
          flag=1
          break
      if(flag==0):
        #print(i)
        x.append(i)
      flag=0
    print(x)
    print(len(x))
    if len(x)>3:
      print("NOT VALIDATED")
    else:
      print("Document Validated")

else:
  def Validation(imageFilePath):
    image = cv2.imread(imageFilePath) 
    x=[]
    b=((str(barcodescan(image))))
    #print(b)
    ls=b.split()
    #print(ls)
    o=""
    l=o.join(ls)
    #print(l)
    co=l.find("C0")
    r=(l[:co])
    f=(l[co:])
    v=(l[co+30:co+51])
    p=re.findall('[A-Z][^A-Z]*',r)
    ab=f[0:7]
    p.append(ab)
    #print(p)
    ab=f[7:11]
    p.append(ab)
    ab=f[11:20]
    p.append(ab)
    ab=f[20:30]
    p.append(ab)
    n = 3
    out = [(v[i:i+n]) for i in range(0, len(v), n)]
    new=out+p
    #list(map(str.lower,new))
    #Info=Info.lower()
    ocrResults= OCR(image)
    ls2=ocrResults.split()
    #print(new)
    #print(ls2)
    #ls.pop(0)
    #ls.pop(len(ls)-1)
    flag=0
    for i in new:
      for j in ls2:
        if i==j:
          flag=1
          break
      if(flag==0):
        #print(i)
        x.append(i)
      flag=0
    print(x)
    #print(len(x))
    if len(x)>2:
      print("NOT VALIDATED")
    else:
      print("Document Validated")

# Validation("/mnt/d/Projects/DocumentVerificationSystem/sample12e.jpg")

