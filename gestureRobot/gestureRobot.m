%created by: @ritexarma
%This MATLAB code allows computer to detect red color markers and process them
%Corresponding output is sent serially that can be used to control a robot on same serial port
%for more info visit https://bytestrokes.wordpress.com/

ser=serial('COM45','Baudrate',9600); %create serial object, change serial port as per assigned by your system
fopen(ser); %open serial port

%initiate image acquisition and define variables required

vid=videoinput('winvideo',1,'YUY2_320x240');      %you are needed to check your webcam device ID and supported format

set(vid,'ReturnedColorSpace','rgb');
preview(vid);
pause(2);

%display('Initialising sequence...')
while 1
    
    im1=getsnapshot(vid); 	%capture image
    
    im2= imsubtract(im1(:,:,1), rgb2gray(im1));	
    
    
    %Use a median filter to filter out noise
    im3 = medfilt2(im2, [3 3]);
    
    im4 = im2bw(im3,0.5);
    
    imshow(im4)
    
    [C, M, N]=bwboundaries(im4,'noholes');
    a=regionprops(M,'centroid');
    
	if N==0 %if no objects then send command to stop
        display('x');
        fwrite(ser,'x');
        pause(0.5);
    else

       if(N==1) 	%if 1 object then 
            cent=(a.Centroid(1,1));
            if(cent<=100) 	%if centroid of the object is within first 100 pixels width wise move left
                display('a');
				fwrite(ser,'a');
				pause(0.5);
              
            else if(cent>100)
                    if(cent>=200)	%if centrid is among last 120 pixels move right
                        display('d');
                        fwrite(ser,'d');
                        pause(0.5);   
                    else
                        display('w'); 	%if in middle move forward
                        fwrite(ser,'w');
                        pause(0.5);
                    end
                end
            end
       else
			if (N==2) %if two object are there at any position then move backwards
				display('s');
				fwrite(ser,'s');
                                pause(0.5);
			end
       end
    end 
end