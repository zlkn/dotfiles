#!/bin/bash

declare -a DESTS=(
  "../vim/.config/nvim/lua/palette.lua"
  "../wezterm/.config/wezterm/palette.lua"
)

for dst in ${DESTS[@]};
do
  echo "Populate palette ${dst}"

  # language=lua
  cat << EOD > ${dst}
  -- !!! Generated do not edit manually !!!
local palette = {
    normal = "#2c363c",
    cursor = "#20bbfc",
    ansi = {
        -- black   = "#f0edec",
        black = "#d1d1d1",
        red     = "#b81a6b",
        green   = "#1e763c",
        yellow  = "#8d5b00",
        blue = "#015493",
        magenta = "#75228e",
        cyan    = "#007070",
        white   = "#2C363C"
      },
    brights = {
        black = "#57606a",
        red     = "#b81a6b",
        green   = "#1e763c",
        yellow  = "#8d5b00",
        blue = "#015493",
        magenta = "#75228e",
        cyan    = "#007070",
        white = "#004c63",
      },
      light = {
        black   = "#57606a",
        red     = "#E8C5C1",
        green   = "#BFD8BF",
        yellow  = "#E1D1B3",
        blue    = "#C1D5E3",
        magenta = "#D9C8D9",
        cyan    = "#B7D3D6",
        white   = "#57606a",
    },
    dark = {
        black   = "#ffffff",
        red     = "#D48B91",
        green   = "#8CBF9B",
        yellow  = "#CCB37F",
        blue    = "#8FB2D4",
        magenta = "#B395B3",
        cyan    = "#87B2B8",
        white   = "#2C363C",
    },
    rainbow = {
        red = '#cc241d',
        orange = '#d65d0e',
        yellow =  '#d79921',
        green = '#689d6a',
        cyan = '#a89984',
        blue = '#458588',
        violet = '#b16286',
    },
    extra = {
        deepTeal = "#3a869c",
        darkBlue = "#0a3069",
        brightBlue = "#0550ae",
        teal = "#004c63",
        tirquose = "#007474",
        darkGreen = "#1a7248",
        moonStonecyan = "#4fb8cc",
        cornflowerBlue = "#b6d6fd",
        bg1 = "#f2f2f2",
        bg2 = "#e7e7e7",
        backgroundGray = "#e7e7e7",
        background = "#e7e7e7",
        darkGray = "#424242",
        mediumGray = "#808080",
        pencilGray = "#9d9d9d",
        gray4 = "#d1dfe1",
        gray0 = "#dfdfe1",
        gray1 = "#d1d1d1",
        gray2 = "#a1a1a1",
        gray3 = "#57606a",
        white = "#6f8396",
        pureWhite = "#ffffff",
      },
  }
return palette
EOD

done


