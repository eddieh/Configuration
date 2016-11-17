# Configuration

This project demonstrates how to consolidate configurations for Apple
projects and Android projects all in one place. It also demonstrates
how in-development or temporary configurations can be kept out of the
mainline preventing conflict with other team members. In addition
configurations can be saved and easily applied for any number of
scenarios such as developing, testing, debugging, staging, production,
release, profiling and so on.

## Overview

Configuration are all kept in the directory `Configs` and follow the
following naming scheme:

    [Platform][Project][BuildStyle](-Specialization).[Ext]
                                   -----------------
                                        Optional

`Platform` is Apple or Android. `Project` is the name of the
project. `BuildStyle` is Common, Debug, Release, etc. `Ext` is the
platform specific extension either `gradle` or
`xcconfig`. `Specialization` (is optional) and should be a helpful yet
short description of the configuration.

Examples:

    Apple-AppleApplication-Common.xcconfig
    Android-AndroidProject-Debug.gradle
    Apple-AppleApplication-Debug-experimental.xcconfig
    Apple-AppleApplication-Debug-eddie-bug-345.xcconfig

When software is built the developer picks one of the
configurations. The build systems for each platform applies the
configuration and produces a build. If the developer doesn't pick a
configuration a universal default configuration is applied.

## Using Configurations

    -xcconfig filename
      Load the build settings defined in filename when building all
      targets.  These settings will override all other set- tings,
      including settings passed individually on the command line.

## How It Works

    #if defined(VT_USE_CONFIG) && VT_USE_CONFIG
        NSLog(@"use config");
    #else
        NSLog(@"not using config");
    #endif
