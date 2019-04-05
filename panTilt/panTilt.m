%created by: @ritexarma (twitter)
%This MATLAB code allows user to interact with the computer through gestures and control a servo
%Wear red color marker or band on fingers and point towards your webcam and have fun
%for more info visit https://bytestrokes.wordpress.com/

ser=serial('COM12','Baudrate',9600); %create serial object, change serial port as per assigned by your system
fopen(ser); %open serial port

%initiate image acquisition and define variables required

vid=videoinput('winvideo',1,'RGB24_160x120');      %you need to check your webcam device ID and supported format

set(vid,'ReturnedColorSpace','rgb');
preview(vid);
pause(2);

display('Initialising sequence...')
while 1
    
    im1=getsnapshot(vid); 	%capture image
    
    im2= imsubtract(im1(:,:,1), rgb2gray(im1));
    
    
    %Use a median filter to filter out noise
    im3 = medfilt2(im2, [3 3]);
    
    im4 = im2bw(im3,0.2);
    
    imshow(im4)
    
    [C, M, N]=bwboundaries(im4,'noholes');
    a=regionprops(M,'centroid');
    
    if(N==1) 	%if 1 object then
        centx=(a.Centroid(1,1));     %centroid x axis value in variable cent
        display(centx);      %display value on matlab window
        cent2x = (160-centx);
        cent3x = (80-cent2x);
        if(cent3x > 0)
            fwrite(ser, 'a');  %write a serially
            pause(0.1);       %wait for 0.1 second
        end
        if(cent3x == 0)
            fwrite(ser, 's');  %write s serially
            pause(0.1);       %wait for 0.1 second
        end
        if(cent3x < 0)
            fwrite(ser, 'd');  %write d serially
            pause(0.1);       %wait for 0.1 second
        end
    else        %in all other cases i.e. 0 object or more than one object do nothing
    end
end