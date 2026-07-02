# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
#pin "chart.js/auto", to: "chart.js--auto.js" # @4.5.1
pin "chart.js/auto", to: "https://cdn.jsdelivr.net/npm/chart.js@4.5.0/auto/+esm"
pin "@kurkle/color", to: "@kurkle--color.js" # @0.3.4
