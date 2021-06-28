clear all; % clears all previous variables
clc; % clears the command window

info=audiodevinfo; % evaluate this line alone to determine which number is attached to the input you want

Fs=48000; % sample rate (Hz)
bits=16; % sample size (bits)
channels=1; % how many channels (keep at 1)
inputID=2; % check info matrix for mic ID
outputID=3; % check info matrix for speaker ID

recObj=audiorecorder(Fs,bits,channels,inputID); % makes an audiorecorder object


disp('Start speaking.') % Lets you know when the recording starts
recordblocking(recObj, 5); % makes a recording for 5 seconds
disp('End of Recording.'); % Lets you know when the recording stops

player = audioplayer(recObj,outputID); % Sets a player object with a specified output
player.play(); % plays back the recording

test3=getaudiodata(recObj); % saves the audio file into a matrix

filename='/Users/mackenziestiles/Desktop/SML Lab Matlab/fNIRS/fNIRS path/test3.mp4'; % saves the audio format into a wav, mp4, whatever you would like

audiowrite(filename, test3, Fs); % actually saves the file somewhere (ask Shuqi how to fix)

speechObjectIBM = speechClient('IBM','languageCode','en-US'); % initialized a speech object, this is IBM because that is what I am using
% if you switch which platform to use, please go to
% https://www.mathworks.com/matlabcentral/fileexchange/65266-speech2text
% and rename based on their work
% speechObjectIBM = speechClient('IBM','keywords',"example,keywords",'keywords_threshold',0.5);
% speechObjectIBM.Options;

TEXT = speech2text(speechObjectIBM,test3,48000); % changes the audio file into a table with transcript and confidence level

transcript = table2array(TEXT(1,1)); % accesses the transcript so it can be manipulated, turns it into a string

transcript{1}