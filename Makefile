# Using https://github.com/loverdos/fsharp-mono-template
# to automate https://gist.github.com/swlaschin/5742974
# when using mono under Mac and the command line
#
# The original script from https://gist.github.com/swlaschin/5742974
# is slightly altered.
# 
# Make sure you have curl and mono (+fsharpi), everything else is downloaded, including
# NuGet and any dependencies declared in ./.nuget/packages.config
#
# Christos KK Loverdos

.PHONY: clean fetch-deps

all: ./tools/nuget/nuget.exe ./tools/FAKE/tools/FAKE.exe fetch-deps run

clean: clean-output
	rm -rf ./packages ./tools

clean-output:
	rm -f *.dot *.svg *.csv

./tools/nuget/nuget.exe:
	rm -rf ./tools/nuget && mkdir -p ./tools/nuget
	curl -Lo ./tools/nuget/nuget.exe https://nuget.org/nuget.exe

./tools/FAKE/tools/FAKE.exe: ./tools/nuget/nuget.exe
	mono ./tools/nuget/nuget.exe install FAKE -OutputDirectory tools -ExcludeVersion -Prerelease

fetch-deps: ./tools/FAKE/tools/FAKE.exe
	mono ./tools/FAKE/tools/FAKE.exe ./fetch-deps.fsx

run: fetch-deps
	fsharpi ./type-dependency-graph.fsx