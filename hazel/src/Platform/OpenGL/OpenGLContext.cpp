#include "OpenGLContext.h"
#include "hzpch.h"

#include <GLFW/glfw3.h>
#include <glad/glad.h>

namespace Hazel {

OpenGLContext::OpenGLContext(GLFWwindow *windowHandle)
    : m_WindowHadle(windowHandle) {
    HZ_CORE_ASSERT(windowHandle, "Window handel is null");
}

void OpenGLContext::Init() {
    glfwMakeContextCurrent(m_WindowHadle);

    int status = gladLoadGLLoader((GLADloadproc)glfwGetProcAddress);
    HZ_CORE_ASSERT(status, "Failed to initialize glad.")
}

void OpenGLContext::SwapBuffers() {
    glBegin(GL_TRIANGLES);
    glEnd();
    glfwSwapBuffers(m_WindowHadle);
}

} // namespace Hazel
