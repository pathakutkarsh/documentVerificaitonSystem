import random
import string
import sys
import time
import cv2 as cv2
from imageSplicing import imageSplicing
from documentScanning import scan


def main(inputImagePath):
    startTime=time.time()
    inputImage= cv2.imread(inputImagePath)
    for iterationNumber in range(3):
        print("Iteration number is "+ str(iterationNumber))
        output=scan(inputImage=inputImage,resizeLimit=1080,morphologyIteration=2+iterationNumber*2, cannyLowerThreshold=100-iterationNumber*35)
        endTime=time.time()
        print(endTime - startTime)
        # cv2.imwrite("output.png", output)
        if (max(output.shape)>400):
            return output    

    
        

if __name__ == '__main__':

    if (len(sys.argv)<2):
        print("Please enter image path")
    else:
        for numberOfArgument in range(1,len(sys.argv)):
            fileName=''.join(random.choices(string.ascii_uppercase +
                                string.digits, k=10))+'.png'
            outputImage=main(sys.argv[numberOfArgument])
            if outputImage is None:
                print("False")
            else:
                cv2.imwrite(fileName,outputImage)
                print(fileName)
                # imageSplicing('/mnt/d/Personal Projects/python/DocumentVerification/'+fileName)
                #imageSplicing('/mnt/d/Personal Projects/python/DocumentVerification/'+fileName)
                imageSplicing(sys.argv[numberOfArgument])