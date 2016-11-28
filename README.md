# Configuration

This project demonstrates how to consolidate configurations for Apple
projects and Android projects all in one place. It also demonstrates
how in-development or temporary configurations can be kept out of the
mainline preventing conflicts with other team members. In addition
configurations can be saved and easily applied for any number of
scenarios such as developing, testing, debugging, staging, production,
release, profiling and so on.

## Overview

Configuration are all kept in the directory `Configs` and follow the
following naming scheme:

    [Platform]-[Project]-[BuildStyle](-Specialization).[Ext]
                                     -----------------
                                          Optional

`Platform` is Apple or Android. `Project` is the name of the
project. `BuildStyle` is Common, Debug, Release, etc. `Ext` is the
platform specific extension either `gradle` or
`xcconfig`. `Specialization` (is optional) and should be a helpful yet
short description of the configuration. Terms in brackets `[]` are
required where as terms in parentheses `()` are optional.

Examples:

    Apple-AppleApplication-Common.xcconfig
    Apple-AppleApplication-Debug-experimental.xcconfig
    Apple-AppleApplication-Debug-eddie-bug-345.xcconfig
    ...
    Android-AndroidProject-Debug.gradle
    Android-AndroidProject-Debug-experimental.gradle
    Android-AndroidProject-Debug-eddie-bug-729.gradle
    ...

When software is built the developer picks one of the
configurations. The build systems for each platform applies the
configuration and produces a build. If the developer doesn't pick a
configuration a universal default configuration is applied.

## Using Configurations

If you join a team or otherwise start on a project, building should be
as easy as possible. In the ideal situation the project builds with a
good default configuration from a single button press in an IDE or a
single command in Bash.

### Configuring Configurations in Xcode

Start by making a copy of an existing `xcconfig` file. Make sure the
new configurtation file is added to your Xcode project. From the
projects's Info settings in Xcode add a new Configuration and set its
configuration file to the copied `xcconfig` file.

![add new config](https://github.com/eddieh/Configuration/blob/master/Images/xcode-new-config.png)

Add a new scheme by selecting "New Scheme..." from the Scheme selector.

![add new scheme](https://github.com/eddieh/Configuration/blob/master/Images/xcode-new-scheme.png)

Edit the scheme and set its build configuration to the new
Configuration. If the new scheme would be useful to the rest of your
team, select "Shared".

![edit build config](https://github.com/eddieh/Configuration/blob/master/Images/xcode-build-config.png)

### Specifying a Configuration in Bash for Xcode

    -xcconfig filename
      Load the build settings defined in filename when building all
      targets.  These settings will override all other settings,
      including settings passed individually on the command line.

### Configuring Configurations in Android Studio

Start by making a copy of an existing `gradle` file in the `Configs`
directory. Open a module's `build.gradle` file. In the file find the
`buildTypes` and add an entry corresponding to the file you made in
the `Configs` directory. Assuming your build variant is a debug build
for an exiremental refactor with a corresponding config file named
`Android-AndroidProject-Debug-expiremental.gradle` you'd name your new
build variant `debugExpiremental`

There are four important parts in the build type for our purposes. The
first important part is the line that imports our configuration using
the `apply from:` form. The second important part is setting the
variant to be debuggable by adding `debuggable true`. Third the build
type must be set to use the implicit signing config for debug builds
`signingConfig signingConfigs.debug`. The fourth part is to define all
the build config variables the build type will use. This is done by
adding lines of the form `buildConfigField "type",
"NAME_OF_VAR_IN_JAVA", "NameOfVar"`

A sample build type block follows:

    buildTypes {
        ...
        debugExpiremental {
            // import our variant config file
            apply from: '../../Configs/Android-AndroidProject-Debug-expiremental.gradle'

            // custom build variants must be set debuggable
            debuggable true

            // custom build variants must use the implicitly defined `debug` signing config
            signingConfig signingConfigs.debug

            // declare build config fields
            buildConfigField "boolean", "VT_USE_CONFIG", VTUseConfig
        }
        ...
    }

Making changes to the `gradle` files in Android Studio requires a
project sync to work properly.

![project sync](https://github.com/eddieh/Configuration/blob/master/Images/as-project-sync.png)

Now that the project has been sync'd the new build variant can be
selected in Android Studio by selecting the 'Build Variants' panel and
then selecting the desired build variant from the dropdown list.

![select variant](https://github.com/eddieh/Configuration/blob/master/Images/as-select-variant.png)

### Specifiying a Configuration in Bash for Android Builds


## How It Works

    #if defined(VT_USE_CONFIG) && VT_USE_CONFIG
        NSLog(@"use config");
    #else
        NSLog(@"not using config");
    #endif
