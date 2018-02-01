# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Added
- Set secret from file

## [0.6.0] - 2018-02-01
### Added
- Secret is created if it cannot be patched/updated

## [0.5.0] - 2017-12-19
### Fixed
- Fix wrong commit when deploying something other than master

## [0.4.0] - 2017-12-12
### Added
- Error message if failed to get secret json

## [0.3.0] - 2017-11-26
### Added
- Add easy deployment
- Restart a deployment

## [0.2.0] - 2017-11-26
### Added
- Get a single secret's decoded value
- Set a single secret's value, given a non-encoded value (yes, we properly encode for you!)

## [0.1.0] - 2017-11-26
### Added
- List secrets of a resource
