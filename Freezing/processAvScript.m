function processAvScript(hrc, nf, dirOutput, avsDirFile, video1, audio, v_name, stn, pos, len)
%Builds the avs file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ffmpeg:        path of the ffmpeg exe file
%nf:            processing video number of frames
%dirOutput:     directory where all process videos are stored
%avsDirFile:    directory where avs scripts are stored
%video1:        Processing Video name (include entire path)
%video2:        Loading video name (include entire path)
%v_name:        Processing Video name (only name, no path, no extention)
%stn:           number of stalling events
%pos:           position of the event
%len:           stalling event duration
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% Position and length
position=[0,1,2];
length_sec=[30,60,120];
%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% Number of frames
num_frame=nf;
frame_unit=round(num_frame/3);

%%%%%%%%%%%%%%%%%%%%%%


switch stn
    case 1
        %Creating the avs file (*)
        fid=fopen(strcat(avsDirFile,v_name(1:end-4),hrc,'.avs'),'w');

        %Loading video source files, one for the actual video, and other for the loading circle effect
        fprintf(fid,'video1=avisource("%s")\n',video1);
        fprintf(fid,'audio=wavsource("%s")\n',audio);
        
        %setting position and length stall values
        position1=pos(1)-1;
        length1= length_sec(len(1));
        c1=length1;

        if (position1==0)
            a1=(frame_unit*position1);
            b1=a1+c1-1;
        else
            a1=(frame_unit*position1)-1;
            b1=a1+c1;
        end;
        
        %Audio variables
        x1=a1/30;
        z1=c1/30;

        %videoaux extract the part of the sequence to be affected
        fprintf(fid,'videoaux=Trim(video1,%s,%s)\n',num2str(a1),num2str(b1));

        %Freezeframe(video,a,b,a) freeze the video for (b-a) seconds repeating the a frame
        fprintf(fid,'video4=FreezeFrame(videoaux, 0, %s, 0)\n',num2str(c1));
        %fprintf(fid,'video4=overlay(video3,Trim(video2,0,%s),mode="blend",opacity=0.5)\n',num2str(c1));
        
        %Generate the audiostall
        fprintf(fid,'aux_a1=AudioTrim(audio,%s,%s)\n',num2str(x1),num2str(-z1));
        fprintf(fid,'aux_b1=delayaudio(aux_a1,%s)\n',num2str(z1));
        fprintf(fid,'audio_stall1=AudioTrim(aux_b1,0,%s)\n',num2str(-z1));        
        
        
        %Merge all video pieces
        switch pos(1)
            case 1
                fprintf(fid,'video5=video4+Trim(video1,%s,0)\n',num2str(a1));
                fprintf(fid,'audio_fin=audio_stall1+audio\n');
            case 2
                fprintf(fid,'video5=Trim(video1,0,%s)+video4+Trim(video1,%s,0)\n',num2str(a1),num2str(a1));
                fprintf(fid,'audio_fin=AudioTrim(audio,0,%s)+audio_stall1+AudioTrim(audio,%s,0)\n',num2str(x1),num2str(x1));
            otherwise
                fprintf(fid,'video5=Trim(video1,0,%s)+video4+Trim(video1,%s,0)\n',num2str(a1),num2str(a1));
                fprintf(fid,'audio_fin=AudioTrim(audio,0,%s)+audio_stall1+AudioTrim(audio,%s,0)\n',num2str(x1),num2str(x1));
        end
        fprintf(fid,'av=AudioDub(video5, audio_fin)\n');
        fprintf(fid,'return av\n');
        fclose(fid);
        
    case 2
       
        %Creating the avs file
        fid=fopen(strcat(avsDirFile,v_name(1:end-4),hrc,'.avs'),'w');

        %Loading video source files, one for the actual video, and other for the loading circle effect
        fprintf(fid,'video1=avisource("%s")\n',video1);
        fprintf(fid,'audio=wavsource("%s")\n',audio);
        
        %setting position and length stall values
        %setting position and length stall values
        position1=pos(1)-1;
        position2=pos(2)-1;
        length1= length_sec(len(1));
        length2= length_sec(len(2));
        
        if (position1>position2)
            aux=position1;
            position1=position2;
            position2=aux;
            
            aux2=length1;
            length1=length2;
            length2=aux2;             
        end
        
        c1=length1;
        c2=length2;        

        if (position1==0)
            a1=(frame_unit*position1);
            a2=(frame_unit*position2)-1;
            b1=a1+c1-1;
            b2=a2+c2;
        else
            a1=(frame_unit*position1)-1;
            a2=(frame_unit*position2)-1;
            b1=a1+c1;
            b2=a2+c2;
        end;
        
        %Audio variables
        x1=a1/30;
        z1=c1/30;
        
        x2=a2/30;
        z2=c2/30;

        %videoaux extract the part of the sequence to be affected
        fprintf(fid,'videoaux=Trim(video1,%s,%s)\n',num2str(a1),num2str(b1));
        fprintf(fid,'videoaux2=Trim(video1,%s,%s)\n',num2str(a2),num2str(b2));

        %Freezeframe(video,a,b,a) freeze the video for (b-a) seconds repeating the a frame
        fprintf(fid,'video4=FreezeFrame(videoaux, 0, %s, 0)\n',num2str(c1));
        fprintf(fid,'video4_2=FreezeFrame(videoaux2, 0, %s, 0)\n',num2str(c2));
        
        %Generate the audiostall 1 and 2
        fprintf(fid,'aux_a1=AudioTrim(audio,%s,%s)\n',num2str(x1),num2str(-z1));
        fprintf(fid,'aux_b1=delayaudio(aux_a1,%s)\n',num2str(z1));
        fprintf(fid,'audio_stall1=AudioTrim(aux_b1,0,%s)\n',num2str(-z1));
        
        fprintf(fid,'aux_a2=AudioTrim(audio,%s,%s)\n',num2str(x2),num2str(-z2));
        fprintf(fid,'aux_b2=delayaudio(aux_a2,%s)\n',num2str(z2));
        fprintf(fid,'audio_stall2=AudioTrim(aux_b2,0,%s)\n',num2str(-z2));         
        
        %fprintf(fid,'video4=overlay(video3,Trim(video2,0,%s),mode="blend",opacity=0.5)\n',num2str(c1));
        %fprintf(fid,'video4_2=overlay(video3_2,Trim(video2,0,%s),mode="blend",opacity=0.5)\n',num2str(c2));
        
        %Merge all video pieces
        if (position1==0)&&(position2==1)
                fprintf(fid,'video5=video4+Trim(video1,%s,%s)+video4_2+Trim(video1,%s,0)\n',num2str(a1),num2str(a2),num2str(a2));
                fprintf(fid,'audio_fin=audio_stall1+AudioTrim(audio,%s,%s)+audio_stall2+AudioTrim(audio,%s,0)\n',num2str(x1),num2str(x2),num2str(x2));
        elseif (position1==0)&&(position2==2)
                fprintf(fid,'video5=video4+Trim(video1,%s,%s)+video4_2+Trim(video1,%s,0)\n',num2str(a1),num2str(a2),num2str(a2));
                fprintf(fid,'audio_fin=audio_stall1+AudioTrim(audio,%s,%s)+audio_stall2+AudioTrim(audio,%s,0)\n',num2str(x1),num2str(x2),num2str(x2));
        elseif (position1==1)&&(position2==2)
                fprintf(fid,'video5=Trim(video1,0,%s)+video4+Trim(video1,%s,%s)+video4_2+Trim(video1,%s,0)\n',num2str(a1),num2str(a1),num2str(a2),num2str(a2));
                fprintf(fid,'audio_fin=AudioTrim(audio,0,%s)+audio_stall1+AudioTrim(audio,%s,%s)+audio_stall2+AudioTrim(audio,%s,0)\n',num2str(x1),num2str(x1),num2str(x2),num2str(x2));
        end
        fprintf(fid,'av=AudioDub(video5, audio_fin)\n');
        fprintf(fid,'return av\n');
        fclose(fid);

    otherwise
        %Creating the avs file
        fid=fopen(strcat(avsDirFile,v_name(1:end-4),hrc,'.avs'),'w');

        %Loading video source files, one for the actual video, and other for the loading circle effect
        fprintf(fid,'video1=avisource("%s")\n',video1);
        fprintf(fid,'audio=wavsource("%s")\n',audio);  
        
        %setting position and length stall values
        %setting position and length stall values
        position1=pos(1)-1;
        position2=pos(2)-1;
        position3=pos(3)-1;
        length1= length_sec(len(1));
        length2= length_sec(len(2));
        length3= length_sec(len(3));
        
        if (position1>position2)||(position1>position3)||(position2>position3)
            aux=sortrows([position1,position2,position3;length1,length2,length3]',1)';
            
            position1=aux(1,1);
            position2=aux(1,2);
            position3=aux(1,3);
            
            length1= aux(2,1);
            length2= aux(2,2);
            length3= aux(2,3);           
        end
        
        c1=length1;
        c2=length2;         
        c3=length3;
        
        
        a1=(frame_unit*position1);
        a2=(frame_unit*position2)-1;
        a3=(frame_unit*position3)-1;
        b1=a1+c1-1;
        b2=a2+c2; 
        b3=a3+c3;
        
        %Audio variables
        x1=a1/30;
        z1=c1/30;
        
        x2=a2/30;
        z2=c2/30;
        
        x3=a3/30;
        z3=c3/30;
        
        %videoaux extract the part of the sequence to be affected
        fprintf(fid,'videoaux=Trim(video1,%s,%s)\n',num2str(a1),num2str(b1));
        fprintf(fid,'videoaux2=Trim(video1,%s,%s)\n',num2str(a2),num2str(b2));
        fprintf(fid,'videoaux3=Trim(video1,%s,%s)\n',num2str(a3),num2str(b3));

        %Freezeframe(video,a,b,a) freeze the video for (b-a) seconds repeating the a frame
        fprintf(fid,'video4=FreezeFrame(videoaux, 0, %s, 0)\n',num2str(c1));
        fprintf(fid,'video4_2=FreezeFrame(videoaux2, 0, %s, 0)\n',num2str(c2));
        fprintf(fid,'video4_3=FreezeFrame(videoaux3, 0, %s, 0)\n',num2str(c3));
        
        %Generate the audiostall 1,2 and 3
        fprintf(fid,'aux_a1=AudioTrim(audio,%s,%s)\n',num2str(x1),num2str(-z1));
        fprintf(fid,'aux_b1=delayaudio(aux_a1,%s)\n',num2str(z1));
        fprintf(fid,'audio_stall1=AudioTrim(aux_b1,0,%s)\n',num2str(-z1));
        
        fprintf(fid,'aux_a2=AudioTrim(audio,%s,%s)\n',num2str(x2),num2str(-z2));
        fprintf(fid,'aux_b2=delayaudio(aux_a2,%s)\n',num2str(z2));
        fprintf(fid,'audio_stall2=AudioTrim(aux_b2,0,%s)\n',num2str(-z2));      
        
        fprintf(fid,'aux_a3=AudioTrim(audio,%s,%s)\n',num2str(x3),num2str(-z3));
        fprintf(fid,'aux_b3=delayaudio(aux_a3,%s)\n',num2str(z3));
        fprintf(fid,'audio_stall3=AudioTrim(aux_b3,0,%s)\n',num2str(-z3));        
        
        %fprintf(fid,'video4=overlay(video3,Trim(video2,0,%s),mode="blend",opacity=0.5)\n',num2str(c1));
        %fprintf(fid,'video4_2=overlay(video3_2,Trim(video2,0,%s),mode="blend",opacity=0.5)\n',num2str(c2));
        %fprintf(fid,'video4_3=overlay(video3_3,Trim(video2,0,%s),mode="blend",opacity=0.5)\n',num2str(c3));
        
        fprintf(fid,'video5=video4+Trim(video1,%s,%s)+video4_2+Trim(video1,%s,%s)+video4_3+Trim(video1,%s,0)\n',num2str(a1),num2str(a2),num2str(a2),num2str(a3),num2str(a3));
        fprintf(fid,'audio_fin=audio_stall1+AudioTrim(audio,%s,%s)+audio_stall2+AudioTrim(audio,%s,%s)+audio_stall3+AudioTrim(audio,%s,0)\n',num2str(x1),num2str(x2),num2str(x2),num2str(x3),num2str(x3));
        
        fprintf(fid,'av=AudioDub(video5, audio_fin)\n');
        fprintf(fid,'return av\n');
        fclose(fid);
end

end

