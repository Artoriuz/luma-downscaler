// MIT License

// Copyright (c) 2023 João Chrisóstomo

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

//!HOOK LUMA
//!BIND LUMA
//!WIDTH OUTPUT.w
//!HEIGHT OUTPUT.h
//!WHEN OUTPUT.w LUMA.w <
//!DESC Luma Downscaler (Linear-Light Gaussian)

vec4 hook() {
    vec2 factor = ceil(input_size / target_size);
    ivec2 start = ivec2(ceil(-factor - 0.5));
    ivec2 end = ivec2(floor(factor - 0.5));

    float output_luma = 0.0;
    float wt = 0.0;
    float w = 0.0;
    for (int dx = start.x; dx <= end.x; dx++) {
        for (int dy = start.y; dy <= end.y; dy++) {
            w = exp(-1.0 * pow(length(vec2(dx + 0.5, dy + 0.5)), 2.0) / length(0.5 * factor));
            output_luma += linearize(LUMA_texOff(vec2(dx + 0.5, dy + 0.5))).x * w;
            wt += w;
        }
    }
    vec4 output_pix = vec4(output_luma / wt, 0.0, 0.0, 1.0);
    return delinearize(output_pix);
}
