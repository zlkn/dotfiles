#!/bin/bash

declare -a DESTS=(
  "../vim/.config/nvim/lua/palette.lua"
  "../wezterm/.config/wezterm/palette.lua"
)

# language=lua
for dst in ${DESTS[@]};
do
  echo "Populate palette ${dst}"

  # language=lua
  cat << EOD > ${dst}
  -- !!! Generated do not edit manually !!!
local palette = {
    ansi = {
        black = "#424242",
        green = "#009965",
        red = "#c30771",
        yellow = "#b57414",
        blue = "#138cbf",
        cyan = "#009999",
        magenta = "#5e2d88",
        white = "#778491",
    },
    brights = {
        black = "#040404",
        green = "#218242",
        red = "#980054",
        blue = "#015493",
        yellow = "#e57400",
        cyan = "#007474",
        magenta = "#871094",
        -- white = "#57606a",
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
        backgroundGray = "#ebebed",
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


