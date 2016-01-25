require_relative 'dinodex_ui'

DinodexUI.start(csv_files: [
  "./dinodex.csv",
  "./african_dinosaur_export.csv",
])
