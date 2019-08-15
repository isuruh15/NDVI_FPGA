import numpy as np
import cv2
from matplotlib import pyplot as plt


def cropFrame(frame,deltaX,deltaY,isFromEnd=0):
    if (isFromEnd):
        y=0
        x=0
        print deltaY, deltaX
        return frame[y:y+(480-int(round(deltaY))),x:x+(640-int(round(deltaX)))]
    y=0
    x=0
    h=100
    w=100
    return frame[y:y+h, x:x+w]

#consider good[3] as the best matching descriptor
def getCoordinates(bestMatch,rgb=1):
    rgbPoint = kp2[bestMatch[0].trainIdx].pt
    nirPoint = kp1[bestMatch[0].queryIdx].pt
    if (rgb):return rgbPoint
    return nirPoint

def resizeToEqual(frame1,frame2):
    h1 = frame1.shape[0]
    w1 = frame1.shape[1]
    h2 = frame2.shape[0]
    w2 = frame2.shape[1]
    if (h1>h2)and(w1>w2):
        return frame1[0:h2,0:w2],frame2
    elif (h1<h2)and(w1<w2):
        return frame1,frame2[0:h1,0:w1]
    elif (h1>h2)and(w1<w2):
        return frame1[0:h2,0:w1],frame2[0:h2,0:w1]
    elif (h1<h2)and(w1>w2):
        return frame1[0:h1,0:w2],frame2[0:h1,0:w2]
    else:
        return frame1,frame2
    
        

    


  
imgQuery = cv2.imread('NIR.jpg',-1)         # queryImage
imgTrain = cv2.imread('RGB.jpg',-1)         # trainImage


##cv2.imshow("ori",imgTrain)
##cv2.imshow("cropped",cropFrame(imgTrain,100,100,1))
##cv2.waitKey(0)
##cv2.destroyAllWindows()




# Initiate SIFT detector
sift = cv2.xfeatures2d.SIFT_create()

# find the keypoints and descriptors with SIFT
kp1, des1 = sift.detectAndCompute(imgQuery,None)
kp2, des2 = sift.detectAndCompute(imgTrain,None)

# BFMatcher with default params
bf = cv2.BFMatcher()
matches = bf.knnMatch(des1,des2, k=2)

# Apply ratio test
good = []
for m,n in matches:
    if m.distance < 0.75*n.distance:
        good.append([m])

if (getCoordinates(good[3],0)[0]>getCoordinates(good[3],1)[0]):
    deltaX = (getCoordinates(good[3],0)[0]-getCoordinates(good[3],1)[0])
    if (getCoordinates(good[3],0)[1]>getCoordinates(good[3],1)[1]):
        #QImage should crop
        deltaY = (getCoordinates(good[3],0)[1]-getCoordinates(good[3],1)[1])
    else:
        deltaY = (getCoordinates(good[3],1)[1]-getCoordinates(good[3],0)[1])
        newT = cropFrame(imgTrain,0,deltaY,1)
        newQ = cropFrame(imgQuery,deltaX,0,1)
        print 'almost'
        cv2.imshow("ori",imgTrain)
##        cv2.imshow("croppedNIR",cropFrame(imgQuery,deltaX,0,1))
##        cv2.imshow("croppedRGB",cropFrame(imgTrain,0,deltaY,1))
        
        cv2.imshow("EqualNIR",resizeToEqual(newT,newQ)[1])
        cv2.imshow("EqualRGB",resizeToEqual(newT,newQ)[0])
        cv2.imwrite('RGB_modified.png',resizeToEqual(newT,newQ)[0])
        cv2.imwrite('NIR_modified.png',resizeToEqual(newT,newQ)[1])
        cv2.waitKey(0)
        cv2.destroyAllWindows()
        
else:
    deltaX = (getCoordinates(good[3],1)[0]-getCoordinates(good[3],0)[0])
    if (getCoordinates(good[3],0)[1]>getCoordinates(good[3],1)[1]):
        deltaY = (getCoordinates(good[3],0)[1]-getCoordinates(good[3],1)[1])
    else:
        #TImage should crop
        deltaY = (getCoordinates(good[3],1)[1]-getCoordinates(good[3],0)[1])

    
        
    
        
   
# cv2.drawMatchesKnn expects list of lists as matches.
img3 = cv2.drawMatchesKnn(imgQuery,kp1,imgTrain,kp2,good,None,flags=2)

#plt.imshow(img3),plt.show()
