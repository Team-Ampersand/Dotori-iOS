if test -d "/opt/homebrew/bin/"; then
    PATH="/opt/homebrew/bin/:${PATH}"
fi

export PATH

if which swiftlint > /dev/null; then
  echo "✅ SwiftLint was installed"
else
  echo "❌ SwiftLint was not installed"
  brew install swiftlint
fi


if which swiftformat > /dev/null; then
  echo "✅ SwiftFormat was installed"
else
  echo "❌ SwiftFormat was not installed"
  brew install swiftformat
fi

if which tuist > /dev/null; then
  echo "✅ Tuist was installed"
else
  echo "❌ Tuist was not installed"
  curl -Ls https://install.tuist.io | bash
fi

git config --local include.path .gitconfig
chmod 777 .githooks/*