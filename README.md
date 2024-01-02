# GLSL Chroma from Luma (CfL) Prediction

## Overview
These are simple downscaling shaders that modify the luma plane before it is merged with chroma. The primary use-case for is 0.5x downscaling since that would leave chroma unmodified on normal 4:2:0 files,
possibly providing not only more quality but also higher performance compared to conventional playback (which upscales chroma first before merging it with luma to then downscale RGB).

## Instructions
Add something like this to your mpv config:
```
glsl-shader="path/to/shader/luma-downscaler-box.glsl"
```
