#include <Hazel.h>

class ExampleLayer : public Hazel::Layer {
public:
    ExampleLayer() : Layer("Example"){};

    void OnUpdate() override {}

    void OnEvent(Hazel::Event &event) override {}
};

class Sandbox : public Hazel::Application {
public:
    Sandbox() { PushLayer(new ExampleLayer()); }
    ~Sandbox() {}
};

Hazel::Application *Hazel::CreateApplication() { return new Sandbox(); }
