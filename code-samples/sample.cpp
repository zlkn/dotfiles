// C++ (17/20) — syntax sampler
#include <algorithm>
#include <cmath>
#include <format>
#include <iostream>
#include <map>
#include <optional>
#include <ranges>
#include <string>
#include <tuple>
#include <vector>

enum class Shade : uint8_t { Red=1, Green, Blue };

template <typename T>
struct Point {
    T x{}, y{};
};

template <typename T>
T distance(const Point<T>& a, const Point<T>& b) {
    auto [dx, dy] = std::tuple{a.x - b.x, a.y - b.y};
    return std::sqrt(dx*dx + dy*dy);
}

template <typename T>
concept Number = std::integral<T> || std::floating_point<T>;

template <Number T>
T sum(std::ranges::range auto&& r) {
    T s{};
    for (auto&& v : r) s += static_cast<T>(v);
    return s;
}

int main() {
    std::vector<int> v{1,2,3,4};
    auto odds = v | std::views::filter([](int x){ return x%2; })
                  | std::views::transform([](int x){ return x*x; });
    std::map<std::string, double> m{{"pi", 3.14159}, {"e", 2.71828}};
    Point<double> p{0,1}, q{2,3};

    std::optional<std::string> maybe = (m.contains("pi") ? std::optional{"ok"} : std::nullopt);
#if __cpp_lib_format
    std::cout << std::format("shade={} dist={:.2f} sum={}\n",
                              static_cast<int>(Shade::Red),
                              distance(p,q),
                              sum<long>(v));
#else
    std::cout << "shade=" << static_cast<int>(Shade::Red)
              << " dist=" << distance(p,q)
              << " sum=" << sum<long>(v) << "\n";
#endif
    if (maybe) std::cout << *maybe << "\n";
}
