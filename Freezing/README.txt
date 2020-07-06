Frame Freezing Generator: VARIUM DB
===================================

0. VARIUM DB don't have the audio component available. So, as a 0 step we create a blank audio component with ffmpeg and then we separate audio and video. 

Run the ffmpeg_addBlankAudiotoAvi.m script (set the location of the ffmpeg executable and the input and output folders)

Run the ffmpeg_wav_component.m script to separate the audio component.

1. Having both audio and video components, run one of the delay_HRC[X].m scripts. This set of scripts will generate the avs files that we need to create the delayed versions of our videos.

(set the input folders for audio and video, and the avs folder location)

2. Once we have the avs files for the corresponding videos, run the ffmpeg_routine_delay.m script to build the delayed videos.

(set the location of the ffmpeg executable, set the location of the avs files as input and the location where the delayed videos will be storaged)


#################################
Requirements:

- ffmpeg: Portable version available at https://ffmpeg.zeranoe.com/builds/
- AviSynth: 32-bit v.2.0.6 available at http://avisynth.nl/index.php/Main_Page