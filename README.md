# Image Segmentation

This MATLAB code provides a graphical user interface (GUI) for image segmentation. The code allows users to perform various image processing tasks, such as loading an image, converting it to grayscale, adding and removing noise, performing edge detection, and histogram equalization.

## Screenshots

![interface](https://github.com/Anwar-Rizk/Image-Processing/assets/74681273/6fcc7e0c-b6a3-4db8-8400-64d921e3b098)

![output](https://github.com/Anwar-Rizk/Image-Processing/assets/74681273/bdc91e9f-c87a-4fe3-867e-f66ffd1c8a35)

## How it Works

1. **GUI Initialization**: The code initializes the GUI for image segmentation. The GUI can be a singleton, allowing only one instance to run.

2. **Image Selection**: Users can load an image (JPEG or PNG) by pressing the "Select Image" button. The selected image is displayed in the first axes.

3. **Grayscale Conversion**: Pressing the "Convert to Grayscale" button converts the selected image to grayscale and displays it in the second axes. The grayscale image's histogram is shown in the seventh axes.

4. **Noise Addition**: Users can add different types of noise (salt & pepper, speckle, Gaussian, or Poisson) to the grayscale image by selecting the noise type from the dropdown menu and pressing the "Add Noise" button. The noisy image is displayed in the third axes, and its histogram is shown in the seventh axes.

5. **Noise Removal**: Users can remove noise from the noisy image using various methods (median filtering, average filtering, Gaussian filtering, or Wiener filtering). The denoised image is displayed in the fourth axes, and its histogram is shown in the seventh axes.

6. **Edge Detection**: Pressing the "Edge Detection" button allows users to perform edge detection on the grayscale image using different methods (Canny, Difference of Gaussians, Sobel, Roberts, or Prewitt). The edged image is displayed in the fifth axes, and its histogram is shown in the seventh axes.

7. **Histogram Equalization**: Pressing the "Histogram Equalization" button applies histogram equalization to the grayscale image and displays the result in the sixth axes. The equalized histogram is shown in the seventh axes.

8. **Histogram Display**: The seventh axes displays the histogram of the currently processed image.

## Functions Overview

The code is organized into several functions:

- `imageSegmentation`: Initializes the GUI and sets up the necessary callbacks.
- `imageSegmentation_OpeningFcn`: Executes before the GUI becomes visible.
- `imageSegmentation_OutputFcn`: Returns output from the GUI to the command line.
- `selectImage_Callback`: Handles the button press event for image selection.
- `convertGray_Callback`: Handles the button press event for converting the image to grayscale.
- `addNoise_Callback`: Handles the button press event for adding noise to the image.
- `removeNoise_Callback`: Handles the button press event for removing noise from the image.
- `edgeDetection_Callback`: Handles the button press event for edge detection in the image.
- `histogramEqualization_Callback`: Handles the button press event for histogram equalization.

## Prerequisites

- MATLAB R2019a or later
- Image Processing Toolbox

## License

Feel free to use and modify this code for your image segmentation needs.

## Video for more details

https://github.com/Anwar-Rizk/Image-Processing/assets/74681273/8c4fd23b-7b6b-4c64-b9d1-c063c967174a
