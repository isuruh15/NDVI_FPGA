import numpy as np
import cv2
from matplotlib import pyplot as plt

cap1 = cv2.VideoCapture(1)
cap2 = cv2.VideoCapture(2)

def cropFrame(frame1,y,x,h,w):
    
    return frame1[y:y+h, x:x+w]

def BFMathcher():
    while(True):
        # Capture frame-by-frame
        ret1, frame1 = cap1.read()
        ret2, frame2 = cap2.read()

        # Initiate SIFT detector
        orb = cv2.ORB_create()

        # Our operations on the frame come here
        gray1 = cv2.cvtColor(frame1, cv2.COLOR_BGR2GRAY)
        gray2 = cv2.cvtColor(frame2, cv2.COLOR_BGR2GRAY)

        # find the keypoints and descriptors with SIFT
        kp1, des1 = orb.detectAndCompute(frame1,None)
        kp2, des2 = orb.detectAndCompute(frame2,None)

        #matching section
        # create BFMatcher object
        bf = cv2.BFMatcher(cv2.NORM_HAMMING, crossCheck=True)

        # Match descriptors.
        matches = bf.match(des1,des2)

        # Sort them in the order of their distance.
        matches = sorted(matches, key = lambda x:x.distance)

        # Draw first 10 matches.
    ##    img3 = cv2.drawMatches(frame1,kp1,frame2,kp2,matches[:10], None, flags=2)

    ##    plt.imshow(img3),plt.show()

        # Display the resulting frame
    ##    cv2.imshow('frame1',gray1)
    ##    cv2.imshow('frame2',gray2)
        cv2.imshow('frame1',cropFrame(frame1,0,0,700,700))
        cv2.imshow('frame2',cropFrame(frame2,50,50,750,750))
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

    # When everything done, release the capture
    cap1.release()
    cap2.release()
    cv2.destroyAllWindows()

##def siftMatcher():
##    



BFMathcher()

