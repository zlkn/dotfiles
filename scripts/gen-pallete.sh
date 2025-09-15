#!/bin/bash

declare -a DESTS=("../vim/.config/nvim/lua/palette.lua" "../wezterm/.config/wezterm/palette.lua")
# language=lua
for dst in ${DESTS[@]};
do
  echo "Populate palette ${dst}"

  cat << EOD > ${dst}
  -- !!! Generated do not edit manually !!!
  local palette = {
      ansi = {
          black = "#424242",
          red = "#c30771",
          green = "#0d844c",
          yellow = "#a66f00",
          blue = "#015692",
          magenta = "#523c79",
          cyan = "#008ec4",
          white = "#9d9d9d",
      },
      brights = {
          black = "#1f1f1f",
          red = "#fb007a",
          green = "#10b97a",
          yellow = "#ee9900",
          blue = "#0550ae",
          magenta = "#871094",
          cyan = "#1fbdd0",
          white = "#57606a",
      },
      extra = {
          deepTeal = "#3a869c",
          darkBlue = "#0a3069",
          teal = "#004c63",
          tirquose = "#007474",
          test = "#00897b",
          cornflowerBlue = "#b6d6fd",
          gray0 = "#dfdfe1",
          gray1 = "#d1d1d1",
          gray2 = "#a1a1a1",
          cherry = "#980054",
          dep = "#82071e",
          func = "#8430ce",
          broghtBrown = "#993c00",
          test = "#004c63",
          cyan = "#007474",
          green = "#10a778",
          chromeGreen = "#0d844c",
          PineGreen = "#27745c",
          lightSeaGreen = "#5fd7af",
          deepTeal = "#3a869c",
          teal = "#007474",
          moonStonecyan = "#4fb8cc",
          darkBlue = "#0a3069",
          brown = "#a66f00",
          yellow = "#d7af5f",
          cornflowerBlue = "#b6d6fd",
          darkGray = "#424242",
          borderGray = "#ebebed", -- <-
          backgroundGray = "#ececec",
          border = "#d1d1d1",
          mediumGray = "#808080",
          pencilGray = "#9d9d9d",
          lightGray = "#f0f0f0",
          pureWhite = "#ffffff",
      },
  }
  return palette
EOD

done


