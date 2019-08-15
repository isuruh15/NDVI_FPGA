import numpy as np
import cv2
from matplotlib import pyplot as plt

cap1 = cv2.VideoCapture(1)
cap2 = cv2.VideoCapture(2)

while cv2.waitKey(1) & 0xFF==ord('y'):
    print "waiting"
ret1, frame1 = cap1.read()
ret2, frame2 = cap2.read()



# Display the resulting frame
cv2.imshow('frame1',frame1)
cv2.imshow('frame2',frame2)

cv2.imwrite('RGB.jpg', frame1)
##cv2.imwrite(name, frame1)

cv2.imwrite('NIR.jpg', frame2)
##cv2.imwrite(name, frame2)
##cv2.imshow('frame1C',cropFrame(frame1,0,0,700,700))
##cv2.imshow('frame2C',cropFrame(frame2,50,50,750,750))

if cv2.waitKey(1) & 0xFF == ord('q'):
    cap1.release()
    cap2.release()
    cv2.destroyAllWindows()

