#include <parser.h>
#include <tokenizer.h>

const std::string code_path = "code";

std::string replace(const std::string& orig, const std::string& find, const std::string& replace)
{
	std::string result = orig;
	size_t pos = 0;
	while ((pos = result.find(find, pos)) != std::string::npos)
	{
		result.replace(pos, find.length(), replace);
		pos += replace.length();
	}
	return result;
}

int main(int argc, char* argv[])
{
	print_info("fs-basic");

	if (!std::filesystem::exists(code_path))
	{
		print_error("No code folder found!");
		return 1;
	}

	print_info("Code:");

	std::vector<std::string> buffer;

	for (const auto& entry : std::filesystem::directory_iterator(code_path))
	{
		auto cleaned = replace(entry.path().filename().string(), "''", "\"");
		buffer.emplace_back(cleaned);
		print_info("%s", cleaned.c_str());
	}

	basic_init(2048, 512); // memory size, stack size
	basic_register_io(putchar, getchar);

	for (auto line : buffer)
	{
		basic_eval(line.data());
	}

	basic_eval("RUN");
	basic_destroy();

	return 0;
}
