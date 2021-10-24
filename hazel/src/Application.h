#pragma once

#include "Core.h"

namespace Hazel {
class Application {
public:
  Application();
  virtual ~Application();

  void Run();
};

Application *CreateApplication();
} // namespace Hazel
