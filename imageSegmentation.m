function varargout = imageSegmentation(varargin)
% IMAGESEGMENTATION MATLAB code for imageSegmentation.fig
%      IMAGESEGMENTATION, by itself, creates a new IMAGESEGMENTATION or raises the existing
%      singleton*.
%
%      H = IMAGESEGMENTATION returns the handle to a new IMAGESEGMENTATION or the handle to
%      the existing singleton*.
%
%      IMAGESEGMENTATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGESEGMENTATION.M with the given input arguments.
%
%      IMAGESEGMENTATION('Property','Value',...) creates a new IMAGESEGMENTATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before imageSegmentation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to imageSegmentation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help imageSegmentation

% Last Modified by GUIDE v2.5 18-Dec-2023 01:07:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @imageSegmentation_OpeningFcn, ...
                   'gui_OutputFcn',  @imageSegmentation_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before imageSegmentation is made visible.
function imageSegmentation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to imageSegmentation (see VARARGIN)

% Choose default command line output for imageSegmentation
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes imageSegmentation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = imageSegmentation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
%---------------------------------------------------START-----------------------------------------------------------

% --- Executes on button press in selectImage.
function selectImage_Callback(hObject, eventdata, handles)
% hObject    handle to selectImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% image Selection
global i;
global iGray;
[fileName, path] = uigetfile( {'*.jpg;*.png','image Files'}, 'Select an Image'); 
if fileName == 0 %means null
    disp('User Cancelled');
else
    i = imread(fullfile(path, fileName));
    iGray = rgb2gray(i);
    axes(handles.axes1);
    imshow(i);
end
%-----------------------------------------------------------------------------------------------------------------


% --- Executes on button press in convertGray.
function convertGray_Callback(hObject, eventdata, handles)
% hObject    handle to convertGray (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global iGray; % make 2d image global to use anywhere
axes(handles.axes2);
imshow(iGray);
axes(handles.axes7);
imhist(iGray);
 set(handles.textStatus, 'String', 'Image Histogram in gray scale');
%-------------------------------------------------------------------------------------------------------------------

 % --- Executes on button press in addNoise.
function addNoise_Callback(hObject, eventdata, handles)
% hObject    handle to addNoise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%gaussian Noise, add noise
global iNoisy;
global iGray;
if handles.addNoiseMenu.Value == 1
    iNoisy = imnoise(iGray, 'salt & pepper', 0.02);
elseif handles.addNoiseMenu.Value == 2
    iNoisy = imnoise(iGray, 'speckle', 0.04);
elseif handles.addNoiseMenu.Value == 3
    iNoisy = imnoise(iGray, 'gaussian', 0.02);
else
    iNoisy = imnoise(iGray, 'poisson');
end

axes(handles.axes3);
imshow(iNoisy);
axes(handles.axes7);
histogram(iNoisy);  %histogram(iNoisy, 'BinWidth', 15);
set(handles.textStatus, 'String', 'Added Noise Histogram');
%-----------------------------------------------------------------------------------------------------------------

% --- Executes on button press in removeNoise.
function removeNoise_Callback(hObject, eventdata, handles)
% hObject    handle to removeNoise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Remove noise
global iNoisy
if handles.removeNoiseMenu.Value == 1
    iDenoise = medfilt2(iNoisy);
elseif handles.removeNoiseMenu.Value == 2
    mask = fspecial('average', [3, 3]); 
    iDenoise = filter2(mask, iNoisy);
elseif handles.removeNoiseMenu.Value == 3
    iDenoise = imgaussfilt(iNoisy, 1); % gaussian filter - Adjust the standard deviation as needed
else
    iDenoise = wiener2(iNoisy);
end
 
axes(handles.axes4);
if handles.removeNoiseMenu.Value == 2
    imshow(uint8(iDenoise));
else
    imshow(iDenoise);
end

axes(handles.axes7);
histogram(iDenoise);

set(handles.textStatus, 'String', 'Remove Noise Histogram')
%-----------------------------------------------------------------------------------------------------------------

% --- Executes on button press in edgeDetection.
function edgeDetection_Callback(hObject, eventdata, handles)
% hObject    handle to edgeDetection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global iGray;
if handles.edgeDetectionMenu.Value == 1
    iEdged = edge(iGray, 'canny');
elseif handles.edgeDetectionMenu.Value == 2
     gaussian1 = fspecial('Gaussian', [5, 5], 1);
    gaussian2 = fspecial('Gaussian', [5, 5], 1.1);
    dog = gaussian1 - gaussian2;
    iEdged = imfilter(double(iGray), dog, 'conv', 'replicate');
    %'conv': Specifies that you are using convolution. Convolution is a mathematical operation
    %that involves combining two functions to produce a third. In image processing,
    %it's commonly used for filtering.
    %'replicate': Specifies the boundary handling method. 'Replicate' means that the values of
    %pixels near the image boundaries are replicated to extend the image. This helps to avoid
    %artifacts that might occur when applying filters at the edges of the image.
elseif handles.edgeDetectionMenu.Value == 3
    iEdged = edge(iGray, 'sobel');
elseif handles.edgeDetectionMenu.Value == 4
    iEdged = edge(iGray, 'roberts');
else
    iEdged = edge(iGray, 'prewitt');
end

axes(handles.axes5);
imshow(iEdged);

axes(handles.axes7);
histogram(iEdged);
set(handles.textStatus, 'String', 'Selected Edge Histogram');
%-----------------------------------------------------------------------------------------------------------------


% --- Executes on button press in histogramEqualization.
function histogramEqualization_Callback(hObject, eventdata, handles)
% hObject    handle to histogramEqualization (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%histogram equalization
global iGray;
iHist = histeq(iGray);

axes(handles.axes6);
imshow(iHist);

axes(handles.axes7);
imhist(iHist);
set(handles.textStatus, 'String', 'Histogram Equalization')
%---------------------------------------------------END-----------------------------------------------------------


% --- Executes on selection change in removeNoiseMenu.
function removeNoiseMenu_Callback(hObject, eventdata, handles)
% hObject    handle to removeNoiseMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns removeNoiseMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from removeNoiseMenu


% --- Executes during object creation, after setting all properties.
function removeNoiseMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to removeNoiseMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in addNoiseMenu.
function addNoiseMenu_Callback(hObject, eventdata, handles)
% hObject    handle to addNoiseMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns addNoiseMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from addNoiseMenu


% --- Executes during object creation, after setting all properties.
function addNoiseMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to addNoiseMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in edgeDetectionMenu.
function edgeDetectionMenu_Callback(hObject, eventdata, handles)
% hObject    handle to edgeDetectionMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns edgeDetectionMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from edgeDetectionMenu


% --- Executes during object creation, after setting all properties.
function edgeDetectionMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edgeDetectionMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
