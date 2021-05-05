<p align="center">
<img src="doc-resources/nextappskit.png" style="max-height: 300px; margin-bottom: -30px" alt="NextAppsKit">
</p>

<h1 align="center">NextAppsKit</h1>

<p align="center">
<a href="https://developer.apple.com/swift/"><img src="https://img.shields.io/badge/Swift-4.2-orange.svg?style=flat" style="max-height: 300px;" alt="Swift"/></a>
<img src="https://img.shields.io/badge/platform-iOS-lightgrey.svg" style="max-height: 300px;" alt="Platform: iOS">
</p>



NextAppsKit is a framework containing utility methods, common UI components and other code that is relevant to most apps. The focus is on client-server iOS apps, however, this framework may include code for other Apple platforms.

## Requirements
* Support iOS 9.0 or later – NextAppsKit should at all times support 1 major version behind the current, non beta, iOS release.
* Write as much as possible in Swift.
* Preserve the coding style that's present throughout the project.
* Use assertions (`assertionFailure()`) whenever possible, instead of ignoring branches in logic flow (e.g. `else` from an `if let`).
* Do not use force unwrapping.

## Publishing an update
* Update the version of the `NextAppsKit` target in Xcode
* Update the version in NextAppsKit.podspec
* Commit these changes
* Add a version tag to the latest commit:
* `pod repo push nextapps-private NextAppsKit.podspec --allow-warnings`
* If you get an `Unable to find the nextapps-private repo. If it has not yet been cloned, add it via pod repo add.` error, you still have to do `pod repo add`:
  * `pod repo add nextapps-private https://bitbucket.org/next-apps/private-pod-specs/src/master/`
  * Try `pod repo push` again

## To-do
* Add common UI components
* Add unit tests
* Add CI

## License
NextAppsKit is property of Next Apps. If a project were to be transferred (change of ownership), a copy should be made of all the used code from NextAppsKit into the project that's being transferred. When ever doing so, make sure to remove the Smiirl integration from that project.

## Contact
*Author: Louis D'hauwe*

*Email: [louis@nextapps.be](mailto:louis@nextapps.be)*
