#pragma once

#include <filesystem>
#include <cstdio>

#define println(__FMT__, ...) std::printf(__FMT__ "\n", __VA_ARGS__);
#define print_info(__FMT__, ...) println("[ INFO ][" __FUNCTION__ "]: " __FMT__, __VA_ARGS__);
#define print_warning(__FMT__, ...) println("[ WARNING ][" __FUNCTION__ "]: " __FMT__, __VA_ARGS__);
#define print_error(__FMT__, ...) println("[ ERROR ][" __FUNCTION__ "]: " __FMT__, __VA_ARGS__);