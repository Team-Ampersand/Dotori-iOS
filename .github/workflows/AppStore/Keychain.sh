#!/bin/bash

security create-keychain -p "" "$KEYCHAIN" 
security list-keychains -s "$KEYCHAIN" 
security default-keychain -s "$KEYCHAIN" 
security unlock-keychain -p "" "$KEYCHAIN"
security set-keychain-settings -lut 3600
security list-keychains

tuist signing decrypt
security import "Tuist/Signing/dotori.p12" -k "$KEYCHAIN" -P "$CERTS_EXPORT_PWD" -A
security set-key-partition-list -S apple-tool:,apple: -s -k "" "$KEYCHAIN"

mkdir -p "$HOME/Library/MobileDevice/Provisioning Profiles" 
cd "Tuist/Signing"
echo `ls *.mobileprovision`
for PROVISION in `ls *.mobileprovision`
do
  UUID=`/usr/libexec/PlistBuddy -c 'Print :UUID' /dev/stdin <<< $(security cms -D -i ./$PROVISION)`
  cp "./$PROVISION" "$HOME/Library/MobileDevice/Provisioning Profiles/$UUID.mobileprovision"
done