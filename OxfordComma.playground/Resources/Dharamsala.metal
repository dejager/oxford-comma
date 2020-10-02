#include <metal_stdlib>
using namespace metal;

#define smoothIntersect(a, b, k) smoothUnion(a, b, -k)
#define sphereField(center, radius, position) ( length(center - position) - radius)
#define halfField(position) (position.y - res.y / 2.0)
#define CS(a) float2(cos(a), sin(a))

float smoothUnion(float a, float b, float k){
  float h = clamp(0.5 + 0.5 * (b - a) / k, 0.0, 1.0);
  return mix( b, a, h) - k * h * (1.0 - h);
}

kernel void takeTheChapstick(texture2d<float, access::write> o[[texture(0)]],
                             constant float &time [[buffer(0)]],
                             constant float2 *touchEvent [[buffer(1)]],
                             constant int &numberOfTouches [[buffer(2)]],
                             ushort2 gid [[thread_position_in_grid]]) {

  int width = o.get_width();
  int height = o.get_height();
  float2 res = float2(width, height);
  float2 p = float2(gid.xy);

  float2 uv = 7.0 * (p.xy - 0.5 * res.xy) / max(res.x, res.y);

  float2 P = res / 2. -CS(time * 2.0) * res / 3.0;

  float sphere = sphereField( P, res.y / 6.0, p);
  float a = smoothUnion(sphere, halfField(p), res.y / 10.0);
  float b = smoothIntersect(sphere, halfField(p), res.y / 10.0);

  float clampedA = clamp(a, 0.0, 1.0);
  float clampedB = clamp(b, 0.0, 1.0);

  float4 color = float4(mix(1, clampedA, clampedB), 0.3, 0.36, 1);

  o.write(color, gid);
}
