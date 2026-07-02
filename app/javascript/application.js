// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import Chart from "chart.js/auto"

document.addEventListener("turbo:load", () => {
  const canvas = document.getElementById("last7DaysChart")

  if (!canvas) return

  const labels = JSON.parse(canvas.dataset.labels)
  const counts = JSON.parse(canvas.dataset.counts)

  const existingChart = Chart.getChart(canvas)
  if (existingChart) {
    existingChart.destroy()
  }

  new Chart(canvas, {
    type: "line",
    data: {
      labels: labels,
      datasets: [
        {
          label: "投稿数",
          data: counts,
          borderWidth: 2,
          tensino: 0.4
        }
      ]
    },
    options: {
      responsive: true,
      scales: {
        y: {
          beginAtZero: true,
          ticks: {
            stepSize: 1
          }
        }
      }
    }
  })
})

document.addEventListener("turbo:load", () => {
  const dateInput = document.getElementById("book_count_search_date")
  const bookRows = document.querySelectorAll(".book-row")

  if (!dateInput) return

  bookRows.forEach((row) => {
    row.addEventListener("click", (event) => {
      if (event.target.closest("a")) return

      dateInput.value = row.dataset.date
    })
  })
})