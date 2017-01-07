function varargout = ShowResult(varargin)
% SHOWRESULT MATLAB code for ShowResult.fig
%      SHOWRESULT, by itself, creates a new SHOWRESULT or raises the existing
%      singleton*.
%
%      H = SHOWRESULT returns the handle to a new SHOWRESULT or the handle to
%      the existing singleton*.
%
%      SHOWRESULT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SHOWRESULT.M with the given input arguments.
%
%      SHOWRESULT('Property','Value',...) creates a new SHOWRESULT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ShowResult_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ShowResult_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ShowResult

% Last Modified by GUIDE v2.5 06-Jan-2017 21:57:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ShowResult_OpeningFcn, ...
                   'gui_OutputFcn',  @ShowResult_OutputFcn, ...
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


% --- Executes just before ShowResult is made visible.
function ShowResult_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ShowResult (see VARARGIN)

% Choose default command line output for ShowResult
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ShowResult wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ShowResult_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;