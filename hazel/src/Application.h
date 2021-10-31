#pragma once

#include "Core.h"
#include "Events/Event.h"

namespace Hazel {

class Application {
public:
    Application();
    virtual ~Application();

    void Run();
};

Application *CreateApplication();
} // namespace Hazel
