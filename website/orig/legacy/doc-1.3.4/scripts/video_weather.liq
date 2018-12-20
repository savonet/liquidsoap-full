img = single("weather.jpg")
cam = input.v4l2()
cam = video.transparent(color=0x0000ff,precision=0.2,cam)
source = add([img,cam])
