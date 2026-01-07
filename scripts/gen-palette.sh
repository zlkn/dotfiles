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
    ansi = {
        black = "#ececec",
        red = "#c30771",
        green = "#218242",
        yellow = "#b57414",
        blue = "#015493",
        magenta = "#5e2d88",
        cyan = "#007474",
        white = "#3a3a3a",
    },
    brights = {
        black = "#57606a",
        red = "#c30771",
        green = "#218242",
        yellow = "#b57414",
        blue = "#015493",
        magenta = "#5e2d88",
        cyan = "#007474",
        white = "#004c63",
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


