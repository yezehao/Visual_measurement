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
Mat dst = src.clone();// clone the image


//== Callback Function ==
void gaussianfilter(int /*unused*/,void* /*unused*/)
{
    // get value form Trackbar of "Gaussian Filter" window
    int ksize  = getTrackbarPos("ksize" , "Gaussian Filter");
    int sigmaX = getTrackbarPos("sigmaX", "Gaussian Filter");
    int sigmaY = getTrackbarPos("sigmaY", "Gaussian Filter");

    // Using Gaussian filter to process the cloned image
    if ( ksize % 2 == 1 || ( ksize == 0 && sigmaX != 0 ) ) {
    GaussianBlur(src, dst, Size(ksize, ksize), sigmaX, sigmaY);}
    // Displace the image processed by canny detector
    imshow("Gaussian Blur Image", dst);
}

//== Main Function ==
int main(){
    // Display the image in a wimdow called "Origin Image"
	imshow("Origin Image", src);
    // Create a window called "Gaussian Filter" for display (user will see this text at the top of the window)
    namedWindow("Gaussian Filter", WINDOW_AUTOSIZE);
    // Set the parameters of Gaussian Filter
    createTrackbar("ksize" , "Gaussian Filter", nullptr, 100, gaussianfilter);
    createTrackbar("sigmaX", "Gaussian Filter", nullptr, 100, gaussianfilter);
    createTrackbar("sigmaY", "Gaussian Filter", nullptr, 100, gaussianfilter);
    setTrackbarPos("ksize" , "Gaussian Filter", 3);
    setTrackbarPos("sigmaX", "Gaussian Filter", 0);
    setTrackbarPos("sigmaY", "Gaussian Filter", 0);
    // Wait for a keystroke in the window
    waitKey(0);
}


								  

















// int main()
// {
//     cv::namedWindow("Orgin Image", cv::WINDOW_AUTOSIZE);
//     cv::namedWindow("Gaussian Blur Image", cv::WINDOW_AUTOSIZE);

//     // import the jpeg image 
//     cv::Mat img = cv::imread("door.jpeg", -1);
//     if (img.empty())
//     {
//         cout << "Could not load image ..." << endl;
//         return -1;
//     }
//     cv::imshow("Orgin Image", img);

//     // 声明输出矩阵
//     cv::Mat out;

//     // 进行平滑操作，可以使用GaussianBlur()、blur()、medianBlur()或bilateralFilter()
//     // 此处共进行了两次模糊操作
//     cv::GaussianBlur(img, out, cv::Size(3, 3), 3, 3);
//     cv::GaussianBlur(out, out, cv::Size(3, 3), 3, 3);

//     // 在输出窗口显示输出图像
//     cv::imshow("v", out);
//     // 等待键盘事件
//     cv::waitKey(0);

//     destroyAllWindows();
    
//     return 0;
// }