import os
import random
import string
import sys
import time
import cv2 as cv2
from imageSplicing import imageSplicing
from documentScanning import scan
from qrscanning import Validation


def main(inputImagePath):
    inputImage= cv2.imread(inputImagePath)
    for iterationNumber in range(3):
        output=scan(inputImage=inputImage,resizeLimit=1080,morphologyIteration=2+iterationNumber*2, cannyUpperThreshold=200-iterationNumber*90)
        # cv2.imwrite("output.png", output)
        if (max(output.shape)>400):
            return output    

    
        

if __name__ == '__main__':

    if (len(sys.argv)<2):
        print("Please enter image path")
    else:
        for numberOfArgument in range(1,len(sys.argv)):
            fileName=''.join(random.choices(string.ascii_uppercase +
                                string.digits, k=10))+'.jpg'
            outputImage=main(sys.argv[numberOfArgument])
            if outputImage is None:
                outputImage=sys.argv[numberOfArgument]
            
            cv2.imwrite('D:\\Projects\\DocumentVerificationSystem\\temp\\'+fileName,outputImage)
            print(fileName)
            print(imageSplicing('D:\\Projects\\DocumentVerificationSystem\\temp\\'+fileName))
            print(Validation(imageFilePath='D:\\Projects\\DocumentVerificationSystem\\temp\\'+fileName))