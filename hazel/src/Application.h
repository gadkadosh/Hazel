#pragma once

#include "Core.h"
#include "Events/ApplicationEvent.h"
#include "Events/Event.h"
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

private:
    std::unique_ptr<Window> m_Window;
    bool m_Running = true;
    LayerStack m_LayerStack;
};

// To be defined in CLIENT
Application *CreateApplication();

} // namespace Hazel
