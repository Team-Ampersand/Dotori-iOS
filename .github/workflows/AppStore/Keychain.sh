#!/bin/bash

security create-keychain -p "" "$KEYCHAIN" 
security list-keychains -s "$KEYCHAIN" 
security default-keychain -s "$KEYCHAIN" 
security unlock-keychain -p "" "$KEYCHAIN"

tuist signing decrypt
security import "Tuist/Signing/dotori.p12" -k "$KEYCHAIN" -P "$CERTS_EXPORT_PWD" -A
security set-key-partition-list -S apple-tool:,apple: -s -k "" "$KEYCHAIN"