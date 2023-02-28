clear
clc
close all

fileReader = dsp.AudioFileReader('18 Dreams (work in progress).mp3');
fileReader.SamplesPerFrame = 512;
N = fileReader.SamplesPerFrame;
fs = fileReader.SampleRate;
deviceWriter = audioDeviceWriter("SampleRate",fs);
f = fs*(0:(N/2))/N;
h = animatedline;
xlim([20 20000]);
ylim([-70 30]);
while ~isDone(fileReader)
    audioData = fileReader();
    deviceWriter(audioData);
    y = mag2db(abs(fft(audioData, N)));
    addpoints(h,f,y(N/2:N));
    drawnow limitrate;
    clearpoints(h);
end
release(fileReader)
release(deviceWriter)