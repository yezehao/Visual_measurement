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
    // get value form Trackbar of "Houghline" window
    int ksize  = getTrackbarPos("ksize" , "Houghline");
    int sigmaX = getTrackbarPos("sigmaX", "Houghline");
    int sigmaY = getTrackbarPos("sigmaY", "Houghline");
    int threhd = getTrackbarPos("threhd", "Houghline");
    int apsize = getTrackbarPos("apsize", "Houghline");
    int Hthrehd = getTrackbarPos("Hthrehd", "Houghline");

    // Convert the graph into grayscale image
    cvtColor(src, gray, COLOR_BGR2GRAY);
    // Using Gaussian filter to process grayscale image
    if ( ksize % 2 == 1 || ( ksize == 0 && sigmaX != 0 ) ) {
    GaussianBlur(gray, edge, Size(ksize, ksize), sigmaX, sigmaY);}
    // Using Canny detector to process image which has been processed
    if ( apsize % 2 == 1 && 3 <= apsize && apsize <= 7 ){ // Aperture size should be odd between 3 and 7 in function 'Canny'
    Canny(edge, edge, threhd, 3*threhd, apsize);}

    Mat hough;
    cvtColor(edge, hough, COLOR_GRAY2BGR);
    
    // Standard Hough Line Transform
    vector<Vec2f> lines; // will hold the results of the detection
    HoughLines(edge, lines, 1, CV_PI/180, Hthrehd, 0, 0 ); // runs the actual detection
    // Draw the lines
    for ( size_t i = 0; i < lines.size(); i++ ){
        float rho = lines[i][0]; 
        float theta = lines[i][1];
        Point pt1; Point pt2;
        double a = cos(theta);
        double b = sin(theta);
        double x0 = a * rho;
        double y0 = b * rho;
        pt1.x = cvRound (x0 + 1000*(-b));
        pt1.y = cvRound (y0 + 1000*(a));
        pt2.x = cvRound (x0 - 1000*(-b));
        pt2.y = cvRound (y0 - 1000*(a));
        line( hough, pt1, pt2, Scalar(0,0,255), 1, LINE_AA);
    }
    
    // Displace the image processed by canny detector
	imshow("Houghline Edge Detection", hough);
}

//== Main Function ==
int main(){
    // Display the image in a wimdow called "Origin Image"
	imshow("Origin Image", src);
    // Create a window called "Houghline" for display (user will see this text at the top of the window)
    namedWindow("Houghline", WINDOW_AUTOSIZE);

    /* Set the parameters of Gaussian Filter */
    createTrackbar("ksize" , "Houghline", nullptr, 100, Canny);
    createTrackbar("sigmaX", "Houghline", nullptr, 50, Canny);
    createTrackbar("sigmaY", "Houghline", nullptr, 50, Canny);
    setTrackbarPos("ksize" , "Houghline", 3);
    setTrackbarPos("sigmaX", "Houghline", 0);
    setTrackbarPos("sigmaY", "Houghline", 0);

    /* Set the parameters of Cannyy detection */
    // Set the lower threshold of Canny Detector
    createTrackbar("threhd", "Houghline", nullptr, 500, Canny);
    setTrackbarPos("threhd", "Houghline", 0);
    // Set the apertureSize of Canny Detector
    createTrackbar("apsize" , "Houghline", nullptr, 7, Canny);
    setTrackbarMin("apsize", "Houghline", 3);// Aperturesize should be greater than 3
    setTrackbarMax("apsize", "Houghline", 7);// Aperturesize should be smaller than 7

    /* Set the parameters of Houghline Detector*/
    createTrackbar("Hthrehd", "Houghline", nullptr, 500, Canny);
    setTrackbarPos("Hthrehd", "Houghline", 250);


    // Wait for a keystroke in the window
    waitKey(0);
}