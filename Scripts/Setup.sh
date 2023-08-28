if test -d "/opt/homebrew/bin/"; then
    PATH="/opt/homebrew/bin/:${PATH}"
fi

export PATH

if which swiftlint > /dev/null; then
  echo ":white_check_mark: SwiftLint was installed"
else
  echo ":x: SwiftLint was not installed"
  brew install swiftlint
fi


if which swiftformat > /dev/null; then
  echo ":white_check_mark: SwiftFormat was installed"
else
  echo ":x: SwiftFormat was not installed"
  brew install swiftformat
fi

if which tuist > /dev/null; then
  echo ":white_check_mark: Tuist was installed"
else
  echo ":x: Tuist was not installed"
  curl -Ls https://install.tuist.io | bash
fi

git config --local include.path ../.gitconfig
chmod 777 ../.githooks/*