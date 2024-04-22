```
# concatenate MTS video files in mylist.txt
# mylist.txt should be a separate file in the same folder with contents like below.
# file '00000.MTS'
# file '00001.MTS'

# Ref: https://trac.ffmpeg.org/wiki/Concatenate
ffmpeg -f concat -safe 0 -i mylist.txt -c copy output.MTS

# Ref: https://shotstack.io/learn/use-ffmpeg-to-trim-video/
ffmpeg -i 00001.MTS -ss 00:01:57 -to 00:04:38 -c:v copy -c:a copy 00001a.MTS

```
