#include <GLFW/glfw3.h>
#include <iostream>
#include <cmath>

#if defined(__APPLE__)
#include <OpenGL/gl3.h>
#else
#include <GL/gl.h>
#endif

// ────────────────────────────────────────────────────────────────
// Vertex shader (simple full-screen quad)
const char* vertexSrc = R"(
#version 330 core
layout(location=0) in vec2 aPos;
void main() {
  gl_Position = vec4(aPos, 0.0, 1.0);
}
)";

// ────────────────────────────────────────────────────────────────
// Fragment shader – raymarching scene
const char* fragmentSrc = R"(
#version 330 core
out vec4 FragColor;

uniform float iTime;
uniform vec2  iResolution;

// ─── SDF primitives ──────────────────────────────────────────────
float sdSphere(vec3 p, float r) {
  return length(p) - r;
}

float sdBox(vec3 p, vec3 b) {
  vec3 q = abs(p) - b;
  return length(max(q, 0.0)) + min(max(q.x, max(q.y, q.z)), 0.0);
}

float sdPlane(vec3 p) {
  return p.y;
}

// ─── Scene ───────────────────────────────────────────────────────
float map(vec3 p) {
  float d = sdPlane(p);                                 // floor

  // animated sphere 1
  d = min(d, sdSphere(p - vec3( 0.0, 1.0 + sin(iTime)*0.3, 0.0), 0.8));

  // animated sphere 2
  d = min(d, sdSphere(p - vec3( 2.0, 1.5, sin(iTime*1.2)),      0.6));

  // animated box
  d = min(d, sdBox(   p - vec3(-2.0, 1.0, cos(iTime)),          vec3(0.7)));

  return d;
}

// ─── Normal ──────────────────────────────────────────────────────
vec3 calcNormal(vec3 p) {
  const float eps = 0.001;
  vec2  e   = vec2(eps, 0.0);
  return normalize(vec3(
    map(p + e.xyy) - map(p - e.xyy),
    map(p + e.yxy) - map(p - e.yxy),
    map(p + e.yyx) - map(p - e.yyx)
  ));
}

// ─── Soft shadow ─────────────────────────────────────────────────
float softShadow(vec3 ro, vec3 rd) {
  float res = 1.0;
  float t   = 0.01;
  for (int i = 0; i < 32; i++) {
    float h = map(ro + t * rd);
    res = min(res, 8.0 * h / t);
    t += clamp(h, 0.01, 0.50);
    if (h < 0.001 || t > 5.0) break;
  }
  return clamp(res, 0.0, 1.0);
}

void main() {
  vec2 uv = (gl_FragCoord.xy - 0.5 * iResolution.xy) / iResolution.y;

  // ─── Camera (orbiting) ─────────────────────────────────────────
  float camDist = 8.0;
  vec3  ro      = vec3(sin(iTime*0.3)*camDist, 4.0, cos(iTime*0.3)*camDist);
  vec3  target  = vec3(0.0, 1.5, 0.0);
  vec3  forward = normalize(target - ro);
  vec3  right   = normalize(cross(forward, vec3(0,1,0)));
  vec3  up      = cross(right, forward);
  vec3  rd      = normalize(forward + uv.x * right + uv.y * up);

  // ─── Raymarch ──────────────────────────────────────────────────
  float t = 0.0;
  vec3  p;
  for (int i = 0; i < 128; i++) {
    p = ro + t * rd;
    float d = map(p);
    if (d < 0.001 || t > 50.0) break;
    t += d * 0.8;
  }

  // ─── Shading ───────────────────────────────────────────────────
  vec3 col = vec3(0.0);

  if (t < 50.0) {
    vec3 n        = calcNormal(p);
    vec3 lightDir = normalize(vec3(1.0, 1.5, -0.8));

    float diff   = max(dot(n, lightDir), 0.0);
    float shadow = softShadow(p + n*0.01, lightDir);

    col  = vec3(0.9, 0.7, 0.5) * diff * shadow * 1.2;               // key light
    col += vec3(0.3, 0.5, 0.8) * max(dot(n, -lightDir), 0.0) * 0.4; // fill light
    col += pow(max(dot(reflect(-rd, n), lightDir), 0.0), 32.0) * 0.8; // specular
  } else {
    col = vec3(0.02, 0.05, 0.15);   // sky
  }

  // gamma + slight tone
  col = pow(col, vec3(0.8));

  FragColor = vec4(col, 1.0);
}
)";

// ────────────────────────────────────────────────────────────────
int main() {
  glfwInit();
  glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
  glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
  glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
#ifdef __APPLE__
  glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
#endif

  GLFWwindow* window = glfwCreateWindow(
    1200, 800,
    "GLSL Raymarching – complex animated scene",
    nullptr, nullptr
  );
  if (!window) {
    glfwTerminate();
    return -1;
  }
  glfwMakeContextCurrent(window);

  // full-screen quad
  float quad[] = { -1,-1, 1,-1, -1,1, 1,1 };
  unsigned VAO, VBO;
  glGenVertexArrays(1, &VAO);
  glGenBuffers(1, &VBO);
  glBindVertexArray(VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(quad), quad, GL_STATIC_DRAW);
  glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, 2 * sizeof(float), 0);
  glEnableVertexAttribArray(0);

  // compile shaders with error checking
  auto compileShader = [](const char* src, GLenum type) -> GLuint {
    GLuint shader = glCreateShader(type);
    glShaderSource(shader, 1, &src, nullptr);
    glCompileShader(shader);

    int success;
    glGetShaderiv(shader, GL_COMPILE_STATUS, &success);
    if (!success) {
      char log[1024];
      glGetShaderInfoLog(shader, 1024, nullptr, log);
      std::cerr << "Shader compile error:\n" << log << "\n";
    }
    return shader;
  };

  GLuint vs = compileShader(vertexSrc, GL_VERTEX_SHADER);
  GLuint fs = compileShader(fragmentSrc, GL_FRAGMENT_SHADER);

  GLuint program = glCreateProgram();
  glAttachShader(program, vs);
  glAttachShader(program, fs);
  glLinkProgram(program);

  int success;
  glGetProgramiv(program, GL_LINK_STATUS, &success);
  if (!success) {
    char log[1024];
    glGetProgramInfoLog(program, 1024, nullptr, log);
    std::cerr << "Program link error:\n" << log << "\n";
  }

  glDeleteShader(vs);
  glDeleteShader(fs);

  glUseProgram(program);

  // main loop
  while (!glfwWindowShouldClose(window)) {
    int w, h;
    glfwGetFramebufferSize(window, &w, &h);
    glViewport(0, 0, w, h);

    glUniform1f(glGetUniformLocation(program, "iTime"),      (float)glfwGetTime());
    glUniform2f(glGetUniformLocation(program, "iResolution"), (float)w, (float)h);

    glClear(GL_COLOR_BUFFER_BIT);
    glBindVertexArray(VAO);
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);

    glfwSwapBuffers(window);
    glfwPollEvents();
  }

  glfwTerminate();
  return 0;
}
