project_name = io.readfile("./project_name");
print("Project Name: " .. project_name);

workspace(project_name)
	location "./build/"
	targetdir "%{wks.location}/bin/%{cfg.buildcfg}-%{cfg.platform}/"
	objdir "%{wks.location}/obj/%{prj.name}/%{cfg.buildcfg}-%{cfg.platform}/"
	buildlog "%{wks.location}/obj/%{cfg.platform}/%{cfg.buildcfg}-%{prj.name}.log"

	largeaddressaware "on"
	editandcontinue "off"
	staticruntime "on"

	systemversion "latest"
	characterset "MBCS"
	warnings "extra"

	flags {
		"noincrementallink",
		"multiprocessorcompile",
	}

	platforms {
		"x86",
	}

	configurations {
		"Release",
		"Debug",
	}

	--x86
	filter "platforms:x86"	
		architecture "x86"
	--end

	filter "Release"
		defines "NDEBUG"
		optimize "full"
		runtime "release"
		symbols "off"

	filter "Debug"
		defines "DEBUG"
		optimize "debug"
		runtime "debug"
		symbols "on"

	project(project_name)
		targetname(project_name)
		language "c++"
		cppdialect "c++17"
		kind "consoleapp"
		warnings "off"

		pchheader "stdafx.hpp"
		pchsource "./src/stdafx.cpp"
		forceincludes "stdafx.hpp"

		dependson {
			"basic",
		}

		links {
			"basic",
		}

		includedirs {
			"./src/",
			"./deps/basic/include/"
		}

		files {
			"./src/**"
		}

	group "deps"
	project "basic"
		language "c"
		kind "staticlib"
		warnings "off"

		includedirs {
			"./deps/basic/include/",
		}

		files {
			"./deps/basic/src/**",
			"./deps/basic/arch/windows/**",
		}
