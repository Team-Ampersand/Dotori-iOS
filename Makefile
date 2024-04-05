generate:
	tuist install
	tuist generate

ci_generate:
	tuist install
	TUIST_ENV=CI tuist generate

clean:
	rm -rf **/*.xcodeproj
	rm -rf *.xcworkspace

reset:
	mise exec -- tuist clean
	rm -rf **/*.xcodeproj
	rm -rf *.xcworkspace

module:
	swift Scripts/GenerateModule.swift

dependency:
	swift Scripts/NewDependency.swift

init:
	swift Scripts/InitEnvironment.swift

signing:
	swift Scripts/CodeSigning.swift

setup:
	sh Scripts/Setup.sh
