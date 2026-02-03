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
    light = {

    },
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
    dark = {

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
        -- backgroundGray = "#ececec",
        -- backgroundGray = "#ebebed", <-
        -- backgroundGray = "#f2f2f2",
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


