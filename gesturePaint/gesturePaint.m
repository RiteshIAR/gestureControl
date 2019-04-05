%created by: @ritexarma (twitter)
%This MATLAB code allows user to interact with the computer through gestures
%Wear red color marker or band on fingers and point towards your webcam and have fun
%for more info visit https://bytestrokes.wordpress.com/

import java.awt.Robot; %import mouse control class
import java.awt.event.*
mouse = Robot;

screen = get(0, 'screensize'); %get screenzise information
vid=videoinput('winvideo',1,'YUY2_320x240'); %start video acquisition,  you can select any supported resolution

set(vid,'ReturnedColorSpace','rgb'); %change colour composition
preview(vid); %preview streaming video
pause(2);

display('Initialising sequence...')

while 1 %infinite loop

     im1=getsnapshot(vid); % capture a frame

     im2= imsubtract(im1(:,:,1), rgb2gray(im1)); %extract red color

     %Use a median filter to filter out noise
     im3 = medfilt2(im2, [3 3]);

     im4 = im2bw(im3,0.24);

     imshow(im4)

     [C, M, N]=bwboundaries(im4,'noholes'); %labeling of objects
     a=regionprops(M,'centroid'); % get centroid information
 
     if N >= 1 %if more than one object are present

          if N>1
               if ((a(2).Centroid(1,1)) - (a(1).Centroid(1,1)) <=25 ) %if two objects have a space less than 25 pixels
                    mouse.mouseMove((screen(3)-a(1).Centroid(1,1).*4.26),a(1).Centroid(1,2).*3.2); % move mouse cursor to respective location on screen. 4.26 and 3.2 is for scaling small centroid movement in video to large cursor movement on screen because video is 320x240 but my computer screen has 1366x768 resolution

               else
                    mouse.mouseMove((screen(3)-a(1).Centroid(1,1)*4.26),a(1).Centroid(1,2).*3.2); %move as per first object
                    mouse.mousePress(InputEvent.BUTTON1_MASK); %left click
                    mouse.mouseRelease(InputEvent.BUTTON1_MASK); %release left button for the click to complete
               end

          else %if one object
               mouse.mouseMove((screen(3)-a(1).Centroid(1,1)*4.26),a(1).Centroid(1,2).*3.2); %simply move the pointer
          end

     else ; %for no object do nothing
     end
end