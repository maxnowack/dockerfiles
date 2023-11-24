#!/bin/sh

echo Live-stream secret: $STREAM_KEY

# raspivid -o - -t 0 -w 1920 -h 1080 -fps 40 -b 8000000 -g 40 | ffmpeg -re -ar 44100 -ac 2 -acodec pcm_s16le -f s16le -ac 2 -i /dev/zero -f h264 -i pipe:0 -c:v copy -c:a aac -ab 128k -g 40 -strict experimental -f flv -r 30 rtmps://a.rtmps.youtube.com/live2/$STREAM_KEY
# raspivid -o - -t 0 -vf -hf -fps 30 -b 6000000 | ffmpeg -re -ar 44100 -ac 2 -acodec pcm_s16le -f s16le -ac 2 -i /dev/zero -f h264 -i - -vcodec copy -acodec aac -ab 128k -g 50 -strict experimental -f flv rtmp://x.rtmp.youtube.com/live2/$STREAM_KEY
raspivid --nopreview -md 4 -w 640 -h 480 -fps 15 -t 0 -b 200000 -g 30 -n -o - | ffmpeg -y -xerror -thread_queue_size 32K -f h264 -r 15 -itsoffset 0 -i - -ar 11025 -itsoffset 5.5 -async 1 -ac 1 -thread_queue_size 32K -async 1 -c:v copy -f flv -flags:v +global_header -rtmp_buffer 10000 -r 15 -async 1 rtmps://a.rtmps.youtube.com/live2/$STREAM_KEY
