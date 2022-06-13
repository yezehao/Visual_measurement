#include <algorithm>
#include <opencv2/imgproc.hpp>
#include <opencv2/highgui.hpp>

using namespace cv;

Mat original = imread(samples::findFile("door.jpeg"), IMREAD_COLOR);
Mat smoothed (original.size(), CV_8UC3);
Mat edges    (original.size(), CV_8UC1);

//https://docs.opencv.org/4.x/d2/d2c/tutorial_sobel_derivatives.html
static void
sobel(int /*unused*/, void* /*unused*/) {
    // It is safe to assume values are positive or zero because they are from trackbars.
    int gaussian_ksize  = getTrackbarPos("gaussian_ksize" , "Trackbars");
    int gaussian_sigmaX = getTrackbarPos("gaussian_sigmaX", "Trackbars");
    int gaussian_sigmaY = getTrackbarPos("gaussian_sigmaY", "Trackbars");
    // ksize should be odd, or sigmaX should not be zero when ksize is zero
    if ( gaussian_ksize % 2 == 1 || (gaussian_ksize == 0 && gaussian_sigmaX != 0) ) {
        GaussianBlur(original, smoothed, Size(gaussian_ksize, gaussian_ksize), gaussian_sigmaX, gaussian_sigmaY);
    }

    Mat grayscale;
    cvtColor(smoothed, grayscale, COLOR_BGR2GRAY);

    int sobel_ksize = getTrackbarPos("sobel_ksize", "Trackbars");
    int sobel_dx    = getTrackbarPos("sobel_dx"   , "Trackbars");
    int sobel_dy    = getTrackbarPos("sobel_dy"   , "Trackbars");
    // ksize should be odd, order should not be zero, and ksize > order
    if ( sobel_ksize % 2 == 1 && (sobel_dx|sobel_dy) != 0 && sobel_ksize > std::max(sobel_dx, sobel_dy) ) {
        Sobel(grayscale, edges, CV_64F, sobel_dx, sobel_dy, sobel_ksize);
        imshow("Edge Detection", edges);
    }
}

int main() {

    imshow("Original", original);

    namedWindow("Trackbars", WINDOW_AUTOSIZE);
    createTrackbar("gaussian_ksize" , "Trackbars", nullptr, 50, sobel);
    createTrackbar("gaussian_sigmaX", "Trackbars", nullptr, 15, sobel);
    createTrackbar("gaussian_sigmaY", "Trackbars", nullptr, 15, sobel);
    createTrackbar("sobel_ksize"    , "Trackbars", nullptr, 30, sobel);
    createTrackbar("sobel_dx"       , "Trackbars", nullptr,  3, sobel);
    createTrackbar("sobel_dy"       , "Trackbars", nullptr,  3, sobel);
    setTrackbarPos("gaussian_ksize" , "Trackbars", 3);
    setTrackbarPos("gaussian_sigmaX", "Trackbars", 0);
    setTrackbarPos("gaussian_sigmaY", "Trackbars", 0);
    setTrackbarPos("sobel_ksize"    , "Trackbars", 3);
    setTrackbarPos("sobel_dx"       , "Trackbars", 1);
    setTrackbarPos("sobel_dy"       , "Trackbars", 1);
    
    waitKey();
}