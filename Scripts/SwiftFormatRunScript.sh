if test -d "/opt/homebrew/bin/"; then
	PATH="/opt/homebrew/bin/:${PATH}"
fi

export PATH
FORMAT="$(dirname "$0")/.swiftformat"

if which swiftformat > /dev/null; then
	swiftformat . --config "${FORMAT}"
else
	echo "warning: SwiftForamt not installed, please run 'brew install swiftformat'"
fi