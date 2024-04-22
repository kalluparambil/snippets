```
# concatenate MTS video files in mylist.txt
# mylist.txt should be a separate file in the same folder with contents like below.
# file '00000.MTS'
# file '00001.MTS'

ffmpeg -f concat -safe 0 -i mylist.txt -c copy output.wav
```
