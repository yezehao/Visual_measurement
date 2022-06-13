//== Header files ==
#include <opencv2/core/mat.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/highgui.hpp>
#include <iostream>

//== Namespaces ==
using namespace std;
using namespace cv;

//== Mat Class ==
//Create objects as follow
Mat src = imread("door.jpeg");// import the image
Mat edge; Mat gray;

//== Callback Function ==
void Canny(int /*unused*/,void* /*unused*/)
{
    // get value form Trackbar of "Canny" window
    int ksize  = getTrackbarPos("ksize" , "Canny");
    int sigmaX = getTrackbarPos("sigmaX", "Canny");
    int sigmaY = getTrackbarPos("sigmaY", "Canny");
    int threhd = getTrackbarPos("threhd", "Canny");
    int apsize = getTrackbarPos("apsize", "Canny");

    // Convert the graph into grayscale image
    cvtColor(src, gray, COLOR_BGR2GRAY);
    // Using Gaussian filter to process grayscale image
    if ( ksize % 2 == 1 || ( ksize == 0 && sigmaX != 0 ) ) {
    GaussianBlur(gray, edge, Size(ksize, ksize), sigmaX, sigmaY);}
    // Using Canny detector to process image which has been processed
    if (apsize % 2 == 1 && 3 <= apsize && apsize <= 7 ){ // Aperture size should be odd between 3 and 7 in function 'Canny'
    Canny(edge, edge, threhd, 3*threhd, apsize);}
    // Displace the image processed by canny detector
	imshow("Canny Edge Detection", edge);
}

//== Main Function ==
int main(){
    // Display the image in a wimdow called "Origin Image"
	imshow("Origin Image", src);
    // Create a window called "Canny" for display (user will see this text at the top of the window)
    namedWindow("Canny", WINDOW_AUTOSIZE);

    /* Set the parameters of Gaussian Filter */
    createTrackbar("ksize" , "Canny", nullptr, 100, Canny);
    createTrackbar("sigmaX", "Canny", nullptr, 100, Canny);
    createTrackbar("sigmaY", "Canny", nullptr, 100, Canny);
    setTrackbarPos("ksize" , "Canny", 3);
    setTrackbarPos("sigmaX", "Canny", 0);
    setTrackbarPos("sigmaY", "Canny", 0);

    /* Set the parameters of Canny detection */
    // Set the lower threshold of Canny Detector
    createTrackbar("threhd", "Canny", nullptr, 200, Canny);
    setTrackbarPos("threhd", "Canny", 0);
    // Set the apertureSize of Canny Detector
    createTrackbar("apsize" , "Canny", nullptr, 7, Canny);
    setTrackbarMin("apsize", "Canny", 3);// Aperturesize should be greater than 3
    setTrackbarMax("apsize", "Canny", 7);// Aperturesize should be smaller than 7
    // Wait for a keystroke in the window
    waitKey(0);
}
