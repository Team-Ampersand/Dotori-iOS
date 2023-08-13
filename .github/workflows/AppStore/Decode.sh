#!/bin/bash

# XCConfig
rm -rf XCConfig
gpg -d -o "$DECRYPTED_XCCONFIG_PATH" --pinentry-mode=loopback --passphrase "$XCCONFIG_SECRET" "$ENCRYPTED_XCCONFIG_PATH"
unzip XCConfig.zip
rm -rf XCConfig.zip

# Provisioning Profile
gpg -d -o "$DECRYPTED_PROVISION_PATH" --pinentry-mode=loopback --passphrase "$PROVISION_SECRET" "$ENCRYPTED_PROVISION_PATH"
gpg -d -o "$DECRYPTED_SHARE_PROVISION_PATH" --pinentry-mode=loopback --passphrase "$SHARE_PROVISION_SECRET" "$ENCRYPTED_SHARE_PROVISION_PATH"

# master.key
gpg -d -o "$DECRYPTED_MASTER_KEY_PATH" --pinentry-mode=loopback --passphrase "$MASTER_KEY_SECRET" "$ENCRYPTED_MASTER_KEY_PATH"

# fastlane env
gpg -d -o "$DECRYPTED_FASTLANE_ENV_PATH" --pinentry-mode=loopback --passphrase "$FASTLANE_SECRET" "$ENCRYPTED_FASTLANE_ENV_PATH"

# AppStore Connect API Key
gpg -d -o "$DECRYPTED_APPSTORE_CONNECT_PATH" --pinentry-mode=loopback --passphrase "$APPSTORE_CONNECT_SECRET" "$ENCRYPTED_APPSTORE_CONNECT_PATH"