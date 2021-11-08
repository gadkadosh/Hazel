#pragma once

#include "Core.h"
#include "Events/ApplicationEvent.h"
#include "Events/Event.h"
#include "ImGui/ImGuiLayer.h"
#include "LayerStack.h"
#include "Window.h"

namespace Hazel {

class Application {
public:
    Application();
    virtual ~Application();

    void Run();

    bool OnWindowClosed(WindowCloseEvent &e);
    void OnEvent(Event &e);

    void PushLayer(Layer *layer);
    void PushOverlay(Layer *layer);

    inline Window &GetWindow() { return *m_Window; }

    static inline Application &Get() { return *s_Instance; }

private:
    std::unique_ptr<Window> m_Window;
    ImGuiLayer *m_ImGuiLayer;
    bool m_Running = true;
    LayerStack m_LayerStack;

private:
    static Application *s_Instance;
};

// To be defined in CLIENT
Application *CreateApplication();

} // namespace Hazel
