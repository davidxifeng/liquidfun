workspace 'liquidfun'
  configurations { 'Debug', 'Release' }
  platforms { 'linux', 'macosx' }

project 'box2d_static_lib'
  language 'C++'
  kind 'StaticLib'

  location 'build'

  includedirs { "." }
  defines { "LIQUIDFUN_EXTERNAL_LANGUAGE_API=1" }

  files {
    'Box2D/**.cpp'
  }

  filter 'system:linux or macosx'
    buildoptions { "-fPIC" }

  filter 'configurations:Debug'
    targetdir 'bin/debug'
    flags       { "Symbols" }

  filter 'configurations:Release'
    targetdir 'bin/release'
    optimize    "Full"

  filter 'platforms:linux'
    system 'linux'

  filter 'platforms:macosx'
    system 'macosx'
