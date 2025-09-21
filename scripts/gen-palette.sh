#!/bin/bash

declare -a DESTS=("../vim/.config/nvim/lua/palette.lua" "../wezterm/.config/wezterm/palette.lua")
# language=lua
for dst in ${DESTS[@]};
do
  echo "Populate palette ${dst}"

  # language=lua
  cat << EOD > ${dst}
  -- !!! Generated do not edit manually !!!
  local palette = {
      ansi = {
          black = "#313131",
          green = "#218242",
          red = "#980054",
          yellow = "#a66f00",
          blue = "#002591",
          magenta = "#5e2d88",
          cyan = "#138cbf",
          white = "#9d9d9d",
      },
      brights = {
          black = "#000000",
          green = "#10a678",
          red = "#c30771",
          yellow = "#e57400",
          blue = "#015692",
          magenta = "#871094",
          cyan = "#1fbdd0",
          white = "#57606a",
      },
      extra = {
          cyan1 = "#009999",
          cyan = "#008ec4",
          deepTeal = "#3a869c",
          darkBlue = "#0a3069",
          teal = "#004c63",
          tirquose = "#007474",
          test = "#00897b",
          cherry = "#980054",
          red = "#d75fa1",
          dep = "#82071e",
          func = "#8430ce",
          broghtBrown = "#993c00",
          green = "#10a778",
          chromeGreen = "#0d844c",
          pineGreen = "#27745c",
          darkGreen = "#1a7248",
          lightSeaGreen = "#5fd7af",
          moonStonecyan = "#4fb8cc",
          yellow = "#d7af5f",
          cornflowerBlue = "#b6d6fd",
          backgroundGray = "#ececec",
          darkGray = "#424242",
          mediumGray = "#808080",
          pencilGray = "#9d9d9d",
          gray0 = "#dfdfe1",
          gray1 = "#d1d1d1",
          gray2 = "#a1a1a1",
          gray3 = "#57606a",
          white = "#6f8396",
          ightGray = "#f0f0f0",
          pureWhite = "#ffffff",
      },
  }
  return palette
EOD

done


