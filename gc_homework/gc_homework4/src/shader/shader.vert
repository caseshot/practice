#version 330 core
layout (location = 0) in vec3 a_pos;

uniform mat4 u_v;
uniform mat4 u_p;

void main() {
    gl_Position = u_p * u_v * vec4(a_pos, 1.0);
}
